package com.coko.server.mdk3.dao;

import java.util.List;

import org.skife.jdbi.v2.sqlobject.Bind;
import org.skife.jdbi.v2.sqlobject.SqlQuery;
import org.skife.jdbi.v2.sqlobject.helpers.MapResultAsBean;

import com.coko.server.mdk3.representations.User;

public interface UserDAO {
	@MapResultAsBean
	@SqlQuery("select * from users where username = :username and password = :password")
	User getUser(@Bind("username") String username, @Bind("password") String password);
	
	@SqlQuery("select role from roles where username = :username")
	List<String> getRoles(@Bind("username") String username);
}
