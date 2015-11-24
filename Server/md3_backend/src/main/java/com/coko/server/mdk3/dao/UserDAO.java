package com.coko.server.mdk3.dao;

import java.util.List;

import org.skife.jdbi.v2.sqlobject.Bind;
import org.skife.jdbi.v2.sqlobject.SqlQuery;
import org.skife.jdbi.v2.sqlobject.helpers.MapResultAsBean;
import org.skife.jdbi.v2.sqlobject.stringtemplate.UseStringTemplate3StatementLocator;
import org.skife.jdbi.v2.unstable.BindIn;

import com.coko.server.mdk3.representations.User;
import com.coko.server.mdk3.representations.UserModule;
import com.google.common.collect.ImmutableSet;

@UseStringTemplate3StatementLocator
//@ExternalizedSqlViaStringTemplate3
//@RegisterContainerMapper(ImmutableSetContainerFactory.class)
public interface UserDAO {
	@MapResultAsBean
	@SqlQuery("select user.* from sec_user user inner join sec_user_pass pass on user.id = pass.userId where user.nik = :username and pass.passwd = :password")
	User getUser(@Bind("username") String username, @Bind("password") String password);
	
	@SqlQuery("select roleCode from sec_user_role where userId = :userId")
	List<String> getRoles(@Bind("userId") String userId);
	
	@MapResultAsBean
	@SqlQuery("select module.* from sec_module module inner join sec_role_module rolemodule on module.code = rolemodule.moduleCode where rolemodule.roleCode in (<nameList>)")
	List<UserModule> getModules(@BindIn("nameList") List<String> nameList);
}
