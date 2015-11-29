package com.hackaton.md3;

import static org.fest.assertions.Assertions.assertThat;
import io.dropwizard.jdbi.DBIFactory;
import io.dropwizard.testing.junit.DropwizardAppRule;

import org.junit.Before;
import org.junit.ClassRule;
import org.junit.Test;
import org.skife.jdbi.v2.DBI;

import com.coko.server.mdk3.App;
import com.coko.server.mdk3.Mdk3Configuration;
import com.coko.server.mdk3.dao.ParameterDAO;
import com.coko.server.mdk3.representations.NIKObject;

public class ValidateNIKTest {
	
	ParameterDAO parameterDAO;
	
	@ClassRule
	public static final DropwizardAppRule<Mdk3Configuration> RULE = new DropwizardAppRule<Mdk3Configuration>(App.class, "config.yaml");
	
	@Before
	public void setUp() {
		DBIFactory factory = new DBIFactory();
		DBI jdbi = factory.build(RULE.getEnvironment(), RULE.getConfiguration().getDataSourceFactory(), "mysql");
		parameterDAO = jdbi.onDemand(ParameterDAO.class);
	}
	
	@Test
	public void validateNIK() {
		NIKObject nikRight = new NIKObject("3502044702900002", parameterDAO);
		assertThat(nikRight.getErrorMessages().isEmpty());
		
		NIKObject nikWrong = new NIKObject("12345", parameterDAO);
		assertThat(nikRight.getErrorMessages().isEmpty());
	}
}
