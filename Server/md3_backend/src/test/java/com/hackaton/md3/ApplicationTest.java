package com.hackaton.md3;

import static org.fest.assertions.Assertions.assertThat;
import io.dropwizard.testing.junit.DropwizardAppRule;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.glassfish.jersey.client.authentication.HttpAuthenticationFeature;
import org.junit.Before;
import org.junit.ClassRule;
import org.junit.Test;

import com.coko.server.mdk3.App;
import com.coko.server.mdk3.Mdk3Configuration;
import com.coko.server.mdk3.representations.DataKTP;

//import com.dwbook.phonebook.representations.Contact;

public class ApplicationTest {
	private Client client;
	private DataKTP dataKTPForTest = new DataKTP();

	@ClassRule
	public static final DropwizardAppRule<Mdk3Configuration> RULE = new DropwizardAppRule<Mdk3Configuration>(App.class, "config.yaml");

	@Before
	public void setUp() {
		client = ClientBuilder.newClient();
		// Set the credentials to be used by the client
		HttpAuthenticationFeature feature = HttpAuthenticationFeature.basic("user", "superSecretPassword");
		client.register(feature);
	}

	@Test
	public void createAndRetrieveContact() {
		// Create a new contact by performing the appropriate http request (POST)
		WebTarget target = client.target("http://localhost:8080/eKTPModule");
		Response response = target.request().post(Entity.entity(dataKTPForTest, MediaType.APPLICATION_JSON));
		
		// Check that the response has the appropriate response code (201)
		assertThat(response.getStatus()).isEqualTo(201);
		// Retrieve the newly created contact
		String newContactURL = (String) response.getHeaders().get("Location").get(0);
		DataKTP contact = client.target(newContactURL).request().get(DataKTP.class);
		
		// Check that it has the same properties as the initial one
		assertThat(contact.getFirstName()).isEqualTo(dataKTPForTest.getFirstName());
		assertThat(contact.getLastName()).isEqualTo(dataKTPForTest.getLastName());
		assertThat(contact.getPhone()).isEqualTo(dataKTPForTest.getPhone());
	}
}
