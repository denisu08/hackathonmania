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
public class PublicResource {
	@Context
	UriInfo uri;
	
	private final ParameterDAO parameterDAO;
	private final Validator validator;
    public PublicResource(DBI jdbi, Validator validator) {
    	parameterDAO = jdbi.onDemand(ParameterDAO.class);
    	this.validator = validator;
    }
    
	@GET
	@Path("/param/{typeId}")
	public Response getParameter(@PathParam("typeId") int type) {

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
	
	@GET
	@Path("/validateNIK/{nik}")
	public Response validateNIK(@PathParam("nik") String nik) {
		/*
			Example: 35 02 04 47 02 90 0002
			1. Kode Propinsi : Dua digit pertama merupakan kode Propinsi.
			2. Kode Kabupaten/Kota : dua digit selanjutnya merupakan kode kabupaten atau kota madya.
			3. Kode Kecamatan : dua digit ketiga merupakan kode kecamatan. Anda bisa melihat daftar kode wilayah Propinsi, Kabupaten, dan Kecamatan melalui link http://www.kemendagri.go.id/pages/data-wilayah (http://www.kemendagri.go.id/pages/data-wilayah)
			4. Kode tanggal lahir : dua digit ke empat merupakan kode tanggal lahir. Untuk pria tanggal lahir di tulis dengan angka 01-31. Sedangkan untuk wanita tanggal lahir ditambah angka 40. Untuk contoh gambar di atas maka wanita tersebut lahir tanggal 7 (47-40).
			5. Kode bulan lahir : ditulis dengan angka 01-12.
			6. Kode tahun lahir : ditulis dua digit terakhir tahun lahir.
			7. Kode Nomor komputerisasi : dibuat secara random oleh komputer agar tidak sama dengan lainnya.
		 */
		
		
		return Response.ok("ok").build();
	}
}
