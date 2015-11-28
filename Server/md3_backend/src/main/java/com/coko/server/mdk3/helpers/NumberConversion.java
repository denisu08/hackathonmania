package com.coko.server.mdk3.helpers;

public class NumberConversion {
	
	public static String DecimalToRomawi(int param) {
		RomanNumeral rn = new RomanNumeral(param);
		return rn.toString();
	}
	
	public static int romanToDecimal(String param) {
		RomanNumeral rn = new RomanNumeral(param);
		return rn.toInt();
	}
}
