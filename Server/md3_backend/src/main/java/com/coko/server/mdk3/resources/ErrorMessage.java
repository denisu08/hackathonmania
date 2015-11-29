package com.coko.server.mdk3.resources;

public class ErrorMessage {

	public ErrorMessage(String errorCode, String errorMessage) {
		this.errorCode = errorCode;
		this.errorMessage = errorMessage;
	}

	private String errorCode;
	private String errorMessage;

	public String getErrorCode() {
		return errorCode;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	@Override
	public String toString() {
		return "ErrorMessage [errorCode=" + errorCode + ", errorMessage="
				+ errorMessage + "]";
	}

}
