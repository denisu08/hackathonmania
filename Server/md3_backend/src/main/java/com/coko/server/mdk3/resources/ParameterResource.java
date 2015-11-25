package com.coko.server.mdk3.resources;

import java.util.List;

import javax.validation.Validator;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import org.skife.jdbi.v2.DBI;

import com.coko.server.mdk3.dao.ParameterDAO;
import com.coko.server.mdk3.helpers.Mdk3Constant;
import com.coko.server.mdk3.representations.Parameter;

@Path("/public/")
@Produces(MediaType.APPLICATION_JSON)
public class ParameterResource {
	@Context
	UriInfo uri;
	
	private final ParameterDAO parameterDAO;
	private final Validator validator;
    public ParameterResource(DBI jdbi, Validator validator) {
    	parameterDAO = jdbi.onDemand(ParameterDAO.class);
    	this.validator = validator;
    }
    
	@GET
	@Path("/param/{typeId}")
	public Response getContact(@PathParam("typeId") int type) {

		List<Parameter> result = null;
		
		switch(type) {
			case Mdk3Constant.PARAM_TYPE_AGAMA:
				result = parameterDAO.getAllAgama();
				break;
			case Mdk3Constant.PARAM_TYPE_JENIS_KELAMIN:
				result = parameterDAO.getAllJenisKelamin();
				break;
			case Mdk3Constant.PARAM_TYPE_KABUPATEN:
				result = parameterDAO.getAllKabupaten();
				break;
			case Mdk3Constant.PARAM_TYPE_KECAMATAN:
				result = parameterDAO.getAllKecamatan();
				break;
			case Mdk3Constant.PARAM_TYPE_PROVINSI:
				result = parameterDAO.getAllProvinsi();
				break;
			case Mdk3Constant.PARAM_TYPE_STATUS_KAWIN:
				result = parameterDAO.getAllStatusKawin();
				break;
		}
		
		return Response.ok(result).build();
	}
}
