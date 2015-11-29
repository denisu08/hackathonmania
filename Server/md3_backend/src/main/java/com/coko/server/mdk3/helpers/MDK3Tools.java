package com.coko.server.mdk3.helpers;

public class MDK3Tools {
	
	public static String DecimalToRomawi(int param) {
		RomanNumeral rn = new RomanNumeral(param);
		return rn.toString();
	}
	
	public static int romanToDecimal(String param) {
		RomanNumeral rn = new RomanNumeral(param);
		return rn.toInt();
	}
	
	public static boolean StringHasValue(String value) {
		if(value == null) return false;
		if(value.equals("")) return false;
		return true;
	}
}
