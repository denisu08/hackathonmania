package com.coko.server.mdk3;

import org.hibernate.validator.internal.util.privilegedactions.GetResources;
import org.skife.jdbi.v2.DBI;

import io.dropwizard.auth.AuthenticationException;
import io.dropwizard.auth.Authenticator;
import io.dropwizard.auth.basic.BasicCredentials;

import com.coko.server.mdk3.dao.UserDAO;
import com.coko.server.mdk3.representations.User;
import com.google.common.base.Optional;
	
public class Mdk3Authenticator implements Authenticator<BasicCredentials, User> {
	
	private final UserDAO userDao;
	
	public Mdk3Authenticator(DBI jdbi) {
        userDao = jdbi.onDemand(UserDAO.class);
	}
	
	@Override
    public Optional<User> authenticate(BasicCredentials credentials) throws AuthenticationException {
		
		User validUser = userDao.getUser(credentials.getUsername(), credentials.getPassword());
		
		if(validUser != null) {
			validUser.setRoles(userDao.getRoles(validUser.getName()));
			return Optional.of(validUser);
		}
		
        return Optional.absent();
    }
}