package com.coko.server.mdk3.representations;

import java.security.Principal;
import java.util.List;

public class User implements Principal {
	private String username;
	private String password;
	private List<String> roles;

	public List<String> getRoles() {
		return roles;
	}
	
	@Override
	public String getName() {
		return username;
	}

	public void setRoles(List<String> roles) {
		this.roles = roles;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
