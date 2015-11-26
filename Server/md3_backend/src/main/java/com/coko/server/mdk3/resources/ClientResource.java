package com.coko.server.mdk3.resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import com.coko.server.mdk3.representations.DataKTP;
import com.coko.server.mdk3.views.DataEntryView;

@Produces(MediaType.TEXT_PLAIN)
@Path("/client/")
public class ClientResource {
	private Client client;

	public ClientResource(Client client) {
		this.client = client;
	}

	@GET
	@Path("showContact")
	@Produces(MediaType.TEXT_HTML)
	public DataEntryView showContact(@QueryParam("id") int id, @Context SecurityContext context) {
		DataKTP c = client.target("http://localhost:8080/contact/" + id).request().get(DataKTP.class);
		String output = "ID: " + id + "\nFirst name: " + c.getFirstName()
				+ "\nLast name: " + c.getLastName() + "\nPhone: "
				+ c.getPhone();
		
		return new DataEntryView(c);
	}

	@GET
	@Path("newContact")
	public Response newContact(@QueryParam("firstName") String firstName,
			@QueryParam("lastName") String lastName,
			@QueryParam("phone") String phone) {		
		try {
			WebTarget target = client.target("http://localhost:8080/contact");
			Response response = target.request().post(Entity.entity(new DataKTP(0, firstName, lastName, phone), MediaType.APPLICATION_JSON));
			
			if (response.getStatus() == 201) {
				// Created
				return Response.status(302).entity("The contact was created successfully! The new contact can be found at " + response.getHeaders().getFirst("Location")).build();
			} else {
				// Other Status code, indicates an error
				return Response.status(422).entity(response.getEntity()).build();
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return Response.status(302).entity("The contact was created successfully!").build();
	}

	@GET
	@Path("updateContact")
	public Response updateContact(@QueryParam("id") int id,
			@QueryParam("firstName") String firstName,
			@QueryParam("lastName") String lastName,
			@QueryParam("phone") String phone) {
		WebTarget target = client.target("http://localhost:8080/contact/" + id);
		Response response = target.request().put(Entity.entity(new DataKTP(id, firstName, lastName, phone), MediaType.APPLICATION_JSON));
		
		if (response.getStatus() == 200) {
			// Created
			return Response.status(302).entity("The contact was updated successfully!").build();
		} else {
			// Other Status code, indicates an error
			return Response.status(422).entity(response.getEntity()).build();
		}
	}

	@GET
	@Path("deleteContact")
	public Response deleteContact(@QueryParam("id") int id) {
		client.target("http://localhost:8080/contact/" + id).request().delete();;
		return Response.noContent().entity("Contact was deleted!").build();
	}
}