package com.coko.server.mdk3.views;

import com.coko.server.mdk3.representations.DataKTP;

import io.dropwizard.views.View;

public class DataEntryView extends View {
	private final DataKTP contact;

	public DataEntryView(DataKTP contact) {
		super("/views/dataKTPEntry.mustache");
		this.contact = contact;
	}

	public DataKTP getContact() {
		return contact;
	}
}