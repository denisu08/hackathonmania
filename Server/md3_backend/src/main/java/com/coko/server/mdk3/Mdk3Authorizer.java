package com.coko.server.mdk3;

import io.dropwizard.auth.Authorizer;

import com.coko.server.mdk3.representations.User;

public class Mdk3Authorizer implements Authorizer<User> {
	@Override
	public boolean authorize(User user, String role) {
		if(user != null && user.getRoles().contains(role)) {
			return true;
		}
		
		return false;
	}
}