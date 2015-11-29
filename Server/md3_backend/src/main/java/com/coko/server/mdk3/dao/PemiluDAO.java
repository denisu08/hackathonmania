package com.coko.server.mdk3.dao;

import org.skife.jdbi.v2.sqlobject.Bind;
import org.skife.jdbi.v2.sqlobject.GetGeneratedKeys;
import org.skife.jdbi.v2.sqlobject.SqlQuery;
import org.skife.jdbi.v2.sqlobject.SqlUpdate;
import org.skife.jdbi.v2.sqlobject.helpers.MapResultAsBean;

import com.coko.server.mdk3.representations.DataPemilu;

public interface PemiluDAO {
	@MapResultAsBean
	@SqlQuery("select * from dat_ktp where id = :id")
	DataPemilu getContactById(@Bind("id") int id);
	
	@GetGeneratedKeys
    @SqlUpdate("insert into dat_ktp (id, firstName, lastName, phone) values (NULL, :firstName, :lastName, :phone)")
    int createContact(@Bind("firstName") String firstName, @Bind("lastName") String lastName, @Bind("phone") String phone);
	
	@SqlUpdate("update dat_ktp set firstName = :firstName, lastName = :lastName, phone = :phone where id = :id")
	void updateContact(@Bind("id") int id, @Bind("firstName") String firstName, @Bind("lastName") String lastName,@Bind("phone") String phone);
	
	@SqlUpdate("delete from dat_ktp where id = :id")
	void deleteContact(@Bind("id") int id);
}
