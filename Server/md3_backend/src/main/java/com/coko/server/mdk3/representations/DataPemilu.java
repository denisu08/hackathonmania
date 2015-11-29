package com.coko.server.mdk3.representations;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

public class DataPemilu {
private int id;
	
	@NotBlank
    @Length(min=2, max=255)
	private String firstName;
	
	@NotBlank
    @Length(min=2, max=255)
	private String lastName;
	
	@NotBlank
    @Length(min=2, max=30)
	private String phone;

	public DataPemilu() {
		this.id = 0;
		this.firstName = null;
		this.lastName = null;
		this.phone = null;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public DataPemilu(int id, String firstName, String lastName, String phone) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.phone = phone;
	}

	public int getId() {
		return id;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getPhone() {
		return phone;
	}
}
