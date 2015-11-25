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

@Path("/security")
@Produces(MediaType.APPLICATION_JSON)
public class SecurityResource {
	@Context
	UriInfo uri;
	
	private final UserDAO userDAO;
	private final Validator validator;
    public SecurityResource(DBI jdbi, Validator validator) {
    	userDAO = jdbi.onDemand(UserDAO.class);
    	this.validator = validator;
    }
    
	@GET
	@Path("/session")
	@RolesAllowed({"admin", "staff", "user"})
	public Response getSession(@Auth User user) {
		return Response.ok(user).build();
	}
	
	@GET
	@Path("/roles")
	@RolesAllowed({"admin", "staff", "user"})
	public Response getRoles(@Auth User user) {
		return Response.ok(user.getRoles()).build();
	}
	
	@GET
	@Path("/menuaccess")
	@RolesAllowed({"admin", "staff", "user"})
	public Response getMenuAccess(@Auth User user) {
		return Response.ok(user.getModules()).build();
	}
}
