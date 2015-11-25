package com.coko.server.mdk3.dao;

import java.util.List;

import org.skife.jdbi.v2.sqlobject.SqlQuery;
import org.skife.jdbi.v2.sqlobject.helpers.MapResultAsBean;

import com.coko.server.mdk3.representations.Parameter;

public interface ParameterDAO {
	@MapResultAsBean
	@SqlQuery("select cd, name from mt_agama where is_delete = 'N'")
	List<Parameter> getAllAgama();
	
	@MapResultAsBean
	@SqlQuery("select cd, name from mt_jenis_kelamin where is_delete = 'N'")
	List<Parameter> getAllJenisKelamin();
	
	@MapResultAsBean
	@SqlQuery("select cd, name from mt_kabupaten where is_delete = 'N'")
	List<Parameter> getAllKabupaten();
	
	@MapResultAsBean
	@SqlQuery("select cd, name from mt_kecamatan where is_delete = 'N'")
	List<Parameter> getAllKecamatan();
	
	@MapResultAsBean
	@SqlQuery("select cd, name from mt_provinsi where is_delete = 'N'")
	List<Parameter> getAllProvinsi();
	
	@MapResultAsBean
	@SqlQuery("select cd, name from mt_status_kawin where is_delete = 'N'")
	List<Parameter> getAllStatusKawin();
}