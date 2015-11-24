package com.coko.server.mdk3.dao.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.skife.jdbi.v2.StatementContext;
import org.skife.jdbi.v2.tweak.ResultSetMapper;

import com.coko.server.mdk3.representations.DataKTP;

public class DataMapper implements ResultSetMapper<DataKTP> {
	
	public DataKTP map(int index, ResultSet r, StatementContext ctx) throws SQLException {
		return new DataKTP(
				r.getInt("id"), 
				r.getString("firstName"),
				r.getString("lastName"), 
				r.getString("phone"));
	}
}