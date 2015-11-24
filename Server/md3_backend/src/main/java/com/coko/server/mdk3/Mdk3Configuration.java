package com.coko.server.mdk3;

import io.dropwizard.Configuration;
import io.dropwizard.db.DataSourceFactory;

import javax.validation.constraints.Max;

import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.common.cache.CacheBuilderSpec;

public class Mdk3Configuration extends Configuration {

	// @JsonProperty("database")
	// private DatabaseConfiguration databaseConfiguration;
	//
	// public DatabaseConfiguration getDatabaseConfiguration() {
	// return databaseConfiguration;
	// }

	@JsonProperty
	private DataSourceFactory database = new DataSourceFactory();

	public DataSourceFactory getDataSourceFactory() {
		return database;
	}
	
	private CacheBuilderSpec authenticationCachePolicy; 
	public CacheBuilderSpec getAuthenticationCachePolicy() {
		return authenticationCachePolicy;
	}

	@JsonProperty
	@NotEmpty
	private String message;

	@JsonProperty
	@Max(10)
	private int messageRepetitions;

	@JsonProperty
	private String additionalMessage = "This is optional";

	public String getAdditionalMessage() {
		return additionalMessage;
	}

	public String getMessage() {
		return message;
	}

	public int getMessageRepetitions() {
		return messageRepetitions;
	}
}