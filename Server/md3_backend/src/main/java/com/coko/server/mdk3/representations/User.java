package com.coko.server.mdk3.representations;

import java.security.Principal;
import java.sql.Timestamp;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

public class User implements Principal {
	@JsonIgnore
	private String id;
	private String NIK;
	@JsonIgnore
	private String is_login;
	@JsonIgnore
	private Timestamp created_dt;
	@JsonIgnore
	private String created_by;
	@JsonIgnore
	private Timestamp updated_dt;
	@JsonIgnore
	private String updated_by;

	@JsonIgnoreProperties
	private List<String> roles;
	
	@JsonIgnoreProperties
	private List<UserModule> modules;

	public List<String> getRoles() {
		return roles;
	}
	
	@Override
	public String getName() {
		return NIK;
	}

	public void setRoles(List<String> roles) {
		this.roles = roles;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNIK() {
		return NIK;
	}

	public void setNIK(String nIK) {
		NIK = nIK;
	}

	public String getIs_login() {
		return is_login;
	}

	public void setIs_login(String is_login) {
		this.is_login = is_login;
	}

	public Timestamp getCreated_dt() {
		return created_dt;
	}

	public void setCreated_dt(Timestamp created_dt) {
		this.created_dt = created_dt;
	}

	public String getCreated_by() {
		return created_by;
	}

	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}

	public Timestamp getUpdated_dt() {
		return updated_dt;
	}

	public void setUpdated_dt(Timestamp updated_dt) {
		this.updated_dt = updated_dt;
	}

	public String getUpdated_by() {
		return updated_by;
	}

	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	}

	public List<UserModule> getModules() {
		return modules;
	}

	public void setModules(List<UserModule> modules) {
		this.modules = modules;
	}

}
