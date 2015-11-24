package com.coko.server.mdk3.health;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.codahale.metrics.health.HealthCheck;
import com.coko.server.mdk3.representations.DataKTP;

public class Mdk3ServerHealthCheck extends HealthCheck {
	private final Client client;

	public Mdk3ServerHealthCheck(Client client) {
		super();
		this.client = client;
	}

	@Override
    protected Result check() throws Exception {
		WebTarget target = client.target("http://localhost:8080/contact");
		Response response = target.request().post(Entity.entity(new DataKTP(0, "Health Check First Name","Health Check Last Name", "00000000"), MediaType.APPLICATION_JSON));
		if (response.getStatus() == 201) {
			return Result.healthy();
		} else {
	 		return Result.unhealthy("New Contact cannot be created!");
 		}
    }
}
