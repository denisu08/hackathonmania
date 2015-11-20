package com.hackaton.md3;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import net.vz.mongodb.jackson.DBCursor;
import net.vz.mongodb.jackson.JacksonDBCollection;

import com.yammer.metrics.annotation.Timed;

@Path("/")
public class IndexResource {

	private JacksonDBCollection<Blog, String> collection;
	 
    public IndexResource(JacksonDBCollection<Blog, String> blogs) {
        this.collection = blogs;
    }
    
	@GET
	@Produces(value = MediaType.APPLICATION_JSON)
	@Timed
	public List<Blog> index() {
//		return Arrays.asList(new Blog(
//			"Day 12: OpenCV--Face Detection for Java Developers",
//			"https://www.openshift.com/blogs/day-12-opencv-face-detection-for-java-developers"));
		
		DBCursor<Blog> dbCursor = collection.find();
        List<Blog> blogs = new ArrayList<>();
        while (dbCursor.hasNext()) {
            Blog blog = dbCursor.next();
            blogs.add(blog);
        }
        return blogs;
	}
}