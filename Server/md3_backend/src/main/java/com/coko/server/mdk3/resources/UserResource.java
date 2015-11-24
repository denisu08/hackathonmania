package com.coko.server.mdk3.resources;

import io.dropwizard.auth.Auth;

import javax.annotation.security.RolesAllowed;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Validator;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import org.skife.jdbi.v2.DBI;

import com.coko.server.mdk3.dao.UserDAO;
import com.coko.server.mdk3.representations.User;

@Path("/user")
@Produces(MediaType.APPLICATION_JSON)
public class UserResource {
	@Context
	UriInfo uri;
	
	private final UserDAO userDAO;
	private final Validator validator;
    public UserResource(DBI jdbi, Validator validator) {
    	userDAO = jdbi.onDemand(UserDAO.class);
    	this.validator = validator;
    }
    
	@GET
	@Path("/menuaccess")
	@RolesAllowed({"admin", "staff", "user"})
	public Response getContact(@Auth User user, @Context HttpServletRequest request) {
		
//		User userLogin = (User) request.getSession().getAttribute("user");
//		return Response.ok(userLogin).build();
		return Response.ok(user).build();
	}
}
