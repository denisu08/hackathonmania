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

import com.coko.server.mdk3.dao.DataDAO;
import com.coko.server.mdk3.representations.DataKTP;

@Path("/eKTPModule")
@Produces(MediaType.APPLICATION_JSON)
public class EKTPModuleResource {
	
	@Context
	UriInfo uri;
	
	private final DataDAO contactDao;
	private final Validator validator;
    public EKTPModuleResource(DBI jdbi, Validator validator) {
    	contactDao = jdbi.onDemand(DataDAO.class);
    	this.validator = validator;
    }
    
	@GET
	@Path("/{id}")
	@RolesAllowed({"admin", "staff", "user"})
	public Response getContact(@PathParam("id") int id) {
		// retrieve information about the contact with the provided id
		DataKTP contact = contactDao.getContactById(id);
		return Response.ok(contact).build();
	}
	
	@POST
    public Response createContact(@Valid DataKTP contact, @Context HttpHeaders headers) throws URISyntaxException {
		// Validate the contact's data
		Set<ConstraintViolation<DataKTP>> violations = validator.validate(contact);
		// Are there any constraint violations?
		if (violations.size() > 0) {
			// Validation errors occurred
		    ArrayList<String> validationMessages = new ArrayList<String>();
		    for (ConstraintViolation<DataKTP> violation : violations) {
		    	validationMessages.add(violation.getPropertyPath().toString() +":" + violation.getMessage());
		    }
	        return Response.status(Status.BAD_REQUEST).entity(validationMessages).build();
		} else {
	        // OK, no validation errors
	        // Store the new contact
	        int newContactId = contactDao.createContact(contact.getFirstName(), contact.getLastName(), contact.getPhone());
	        return Response.created(new URI(uri.getRequestUri().toString().concat("/" + String.valueOf(newContactId)))).build();
		}
    }

	@DELETE
	@Path("/{id}")
	public Response deleteContact(@PathParam("id") int id) {
		// delete the contact with the provided id
        contactDao.deleteContact(id);
        return Response.noContent().build();
	}

	@PUT
	@Path("/{id}")
	public Response updateContact(@PathParam("id") int id, DataKTP contact) {
		// Validate the updated data
		Set<ConstraintViolation<DataKTP>> violations = validator.validate(contact);
		// Are there any constraint violations?
		if (violations.size() > 0) {
			// Validation errors occurred
            ArrayList<String> validationMessages = new ArrayList<String>();
            for (ConstraintViolation<DataKTP> violation : violations) {
            	validationMessages.add(violation.getPropertyPath().toString() +":" + violation.getMessage());
            }
            
			// Validation errors occurred
		    return Response.status(Status.BAD_REQUEST).entity(validationMessages).build();
		} else {
		    // No errors
		    // update the contact with the provided ID
		    contactDao.updateContact(id, contact.getFirstName(), contact.getLastName(), contact.getPhone());
		    return Response.ok( new DataKTP(id, contact.getFirstName(), contact.getLastName(), contact.getPhone())).build();
		}
	}
}