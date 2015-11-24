package com.coko.server.mdk3;

import io.dropwizard.Application;
import io.dropwizard.assets.AssetsBundle;
import io.dropwizard.auth.AuthDynamicFeature;
import io.dropwizard.auth.AuthValueFactoryProvider;
import io.dropwizard.auth.CachingAuthenticator;
import io.dropwizard.auth.basic.BasicCredentialAuthFilter;
import io.dropwizard.auth.basic.BasicCredentials;
import io.dropwizard.client.JerseyClientBuilder;
import io.dropwizard.jdbi.DBIFactory;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import io.dropwizard.views.ViewBundle;

import javax.ws.rs.client.Client;

import org.glassfish.jersey.server.filter.RolesAllowedDynamicFeature;
import org.skife.jdbi.v2.DBI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.coko.server.mdk3.health.Mdk3ServerHealthCheck;
import com.coko.server.mdk3.representations.User;
import com.coko.server.mdk3.resources.ClientResource;
import com.coko.server.mdk3.resources.EKTPModuleResource;
import com.coko.server.mdk3.resources.UserResource;

public class App extends Application<Mdk3Configuration> {
	private static final Logger LOGGER = LoggerFactory.getLogger(App.class);

	public static void main(String[] args) throws Exception {
		new App().run(args);
	}

	@Override
	public void initialize(Bootstrap<Mdk3Configuration> bootstrap) {
		bootstrap.addBundle(new AssetsBundle());
		bootstrap.addBundle(new ViewBundle());
	}

	@Override
	public void run(Mdk3Configuration c, Environment e) throws Exception {
		LOGGER.info("Method App#run() called");
		// System.out.println("Hello world, by Dropwizard!");
		/* for (int i = 0; i < c.getMessageRepetitions(); i++) {
			System.out.println(c.getMessage());
		}
		System.out.println(c.getAdditionalMessage()); */
		
		// Create a DBI factory and build a JDBI instance
		final DBIFactory factory = new DBIFactory();
		final DBI jdbi = factory.build(e, c.getDataSourceFactory(), "mysql");
		
		// Add the resource to the environment
//		e.jersey().register(new EKTPModuleResource(jdbi, e.getValidator()));
		
		// build the client and add the resource to the environment
		final Client client = new JerseyClientBuilder(e).build("REST Client");
//		e.jersey().register(new ClientResource(client));
		
		e.jersey().register(new UserResource(jdbi, e.getValidator()));
		
		Mdk3Authenticator phoneAuthenticator = new Mdk3Authenticator(jdbi);
		CachingAuthenticator<BasicCredentials, User> cachingAuthenticator = new CachingAuthenticator<>(
           e.metrics(), phoneAuthenticator,
           c.getAuthenticationCachePolicy());
		
		e.jersey().register(new AuthDynamicFeature(
            new BasicCredentialAuthFilter.Builder<User>()
                .setAuthenticator(cachingAuthenticator)
                .setAuthorizer(new Mdk3Authorizer())
                .setRealm("MDK3 REALM COKO")
                .buildAuthFilter()));
		
	    e.jersey().register(RolesAllowedDynamicFeature.class);
	    //If you want to use @Auth to inject a custom Principal type into your resource
	    e.jersey().register(new AuthValueFactoryProvider.Binder<>(User.class));
	    
	    // Add health checks
	    e.healthChecks().register("MDK3 Server Health Check", new Mdk3ServerHealthCheck(client));
	}
}
