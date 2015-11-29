package com.coko.server.mdk3.resources;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Set;

import javax.annotation.security.RolesAllowed;
import javax.validation.ConstraintViolation;
import javax.validation.Valid;
import javax.validation.Validator;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.core.UriInfo;

import org.skife.jdbi.v2.DBI;

import com.coko.server.mdk3.dao.PemiluDAO;
import com.coko.server.mdk3.representations.DataPemilu;

@Path("/pemiluModule")
@Produces(MediaType.APPLICATION_JSON)
public class PemiluModuleResource {
	@Context
	UriInfo uri;
	
	private final PemiluDAO pemiluDAO;
	private final Validator validator;
    public PemiluModuleResource(DBI jdbi, Validator validator) {
    	pemiluDAO = jdbi.onDemand(PemiluDAO.class);
    	this.validator = validator;
    }
    
    @GET
	@Path("/{id}")
	@RolesAllowed({"admin", "staff", "user"})
	public Response getPemilu(@PathParam("id") int id) {
		// retrieve information about the contact with the provided id
    	DataPemilu contact = pemiluDAO.getContactById(id);
		return Response.ok(contact).build();
	}
	
	@POST
	@RolesAllowed({"admin", "staff", "user"})
    public Response createPemilu(@Valid DataPemilu contact, @Context HttpHeaders headers) throws URISyntaxException {
		// Validate the contact's data
		Set<ConstraintViolation<DataPemilu>> violations = validator.validate(contact);
		// Are there any constraint violations?
		if (violations.size() > 0) {
			// Validation errors occurred
		    ArrayList<String> validationMessages = new ArrayList<String>();
		    for (ConstraintViolation<DataPemilu> violation : violations) {
		    	validationMessages.add(violation.getPropertyPath().toString() +":" + violation.getMessage());
		    }
	        return Response.status(Status.BAD_REQUEST).entity(validationMessages).build();
		} else {
	        // OK, no validation errors
	        // Store the new contact
	        int newContactId = pemiluDAO.createContact(contact.getFirstName(), contact.getLastName(), contact.getPhone());
	        return Response.created(new URI(uri.getRequestUri().toString().concat("/" + String.valueOf(newContactId)))).build();
		}
    }

	@DELETE
	@Path("/{id}")
	@RolesAllowed({"admin", "staff", "user"})
	public Response deletePemilu(@PathParam("id") int id) {
		// delete the contact with the provided id
		pemiluDAO.deleteContact(id);
        return Response.noContent().build();
	}

	@PUT
	@Path("/{id}")
	public Response updatePemilu(@PathParam("id") int id, DataPemilu contact) {
		// Validate the updated data
		Set<ConstraintViolation<DataPemilu>> violations = validator.validate(contact);
		// Are there any constraint violations?
		if (violations.size() > 0) {
			// Validation errors occurred
            ArrayList<String> validationMessages = new ArrayList<String>();
            for (ConstraintViolation<DataPemilu> violation : violations) {
            	validationMessages.add(violation.getPropertyPath().toString() +":" + violation.getMessage());
            }
            
			// Validation errors occurred
		    return Response.status(Status.BAD_REQUEST).entity(validationMessages).build();
		} else {
		    // No errors
		    // update the contact with the provided ID
			pemiluDAO.updateContact(id, contact.getFirstName(), contact.getLastName(), contact.getPhone());
		    return Response.ok( new DataPemilu(id, contact.getFirstName(), contact.getLastName(), contact.getPhone())).build();
		}
	}
}
