package com.hackaton.md3;

import net.vz.mongodb.jackson.JacksonDBCollection;

import com.mongodb.DB;
import com.mongodb.Mongo;
import com.yammer.dropwizard.Service;
import com.yammer.dropwizard.config.Bootstrap;
import com.yammer.dropwizard.config.Environment;
 
public class BlogService extends Service<BlogConfiguration> {
 
    public static void main(String[] args) throws Exception {
        new BlogService().run(new String[] { "server" });
    }
 
    @Override
    public void initialize(Bootstrap<BlogConfiguration> bootstrap) {
        bootstrap.setName("blog");
    }
 
    @Override
    public void run(BlogConfiguration configuration, Environment environment) throws Exception {
    	
    	// Run Mongo DB
    	Mongo mongo = new Mongo(configuration.mongohost, configuration.mongoport);
        MongoManaged mongoManaged = new MongoManaged(mongo);
        environment.manage(mongoManaged);
        environment.addHealthCheck(new MongoHealthCheck(mongo));
        
        DB db = mongo.getDB(configuration.mongodb);
        JacksonDBCollection<Blog, String> blogs = JacksonDBCollection.wrap(db.getCollection("blogs"), Blog.class, String.class);
        
        // Run Index Resource
    	// environment.addResource(new IndexResource());
        environment.addResource(new IndexResource(blogs));
    	
    	environment.addResource(new BlogResource(blogs));
    }
 
}