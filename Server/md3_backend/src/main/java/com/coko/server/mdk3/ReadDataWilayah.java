package com.coko.server.mdk3;

import java.io.File;
import java.io.FileInputStream;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.coko.server.mdk3.helpers.NumberConversion;

public class ReadDataWilayah {
	
	private static String Regex_Provinsi = "[0-9]{2}+";
	private static String Insert_Query_Provinsi = "insert into mt_provinsi values ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
	
	private static String Regex_Kabupaten = "[0-9]{2}+\\.[0-9]{2}+";
	private static String Insert_Query_Kabupaten = "insert into mt_kabupaten values ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
	
	private static String Regex_Kecamatan = "[0-9]{2}+\\.[0-9]{2}+\\.[0-9]{2}+";
	private static String Insert_Query_Kecamatan = "insert into mt_kecamatan values ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
	
	private Pattern p;
	
	public static void main(String[] args) {
//		System.out.println("XXV == " + NumberConversion.romanToDecimal("XXV"));
//		System.out.println("3333 == " + NumberConversion.DecimalToRomawi(3333));
		new ReadDataWilayah().parseAllData();
	}
	
	void parseAllData() {
		try {
			FileInputStream file = new FileInputStream(new File("RawData/data_dan_wilayah_2013.xlsx"));

			// Create Workbook instance holding reference to .xlsx file
			XSSFWorkbook workbook = new XSSFWorkbook(file);

			// Get first/desired sheet from the workbook
			XSSFSheet sheet = workbook.getSheetAt(0);

			Iterator<Row> rowIterator;
			
			// Read Data Provinsi
			p = Pattern.compile(Regex_Provinsi);
			rowIterator = sheet.iterator();
			while (rowIterator.hasNext()) {
				ParseProvinsiData(rowIterator.next());
			}
			
			// Read Data Kabupaten
			p = Pattern.compile(Regex_Kabupaten);
			rowIterator = sheet.iterator();
			while (rowIterator.hasNext()) {
				ParseKabupatenData(rowIterator.next());
			}
			
			// Read Data Kelurahan
			p = Pattern.compile(Regex_Kecamatan);
			rowIterator = sheet.iterator();
			while (rowIterator.hasNext()) {
				ParseKecamatanData(rowIterator.next());
			}
			
			file.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void ParseProvinsiData(Row row) {
		String kodeWilayah =  ReadCellAsString(row.getCell(1), "");
		Matcher m = p.matcher(kodeWilayah);
				
		if(m.matches()) {
			
			int no = NumberConversion.romanToDecimal(ReadCellAsString(row.getCell(0), "0"));
			String code = ReadCellAsString(row.getCell(1), "");
			String index = ReadCellAsString(row.getCell(2), "0");
			String name = ReadCellAsString(row.getCell(3), "");
			String total_kab = ReadCellAsString(row.getCell(5), "0");
			String total_kota = ReadCellAsString(row.getCell(6), "0");
			String total_kec = ReadCellAsString(row.getCell(7), "0");
			String total_kel = ReadCellAsString(row.getCell(8), "0");
			String total_desa = ReadCellAsString(row.getCell(9), "0");
			String luas = ReadCellAsString(row.getCell(10), "0");
			String jumlah = ReadCellAsString(row.getCell(11), "0");
			String keterangan = ReadCellAsString(row.getCell(12), "");
			
			String insertSQL = String.format(Insert_Query_Provinsi, no, code, index, name, total_kab, total_kota, total_kec, total_kel, total_desa, luas, jumlah, keterangan);
			
			System.out.println(insertSQL);
		}
	}
	
	void ParseKabupatenData(Row row) {
		String kodeWilayah =  ReadCellAsString(row.getCell(1), "");
		Matcher m = p.matcher(kodeWilayah);
				
		if(m.matches()) {
			
			String no = ReadCellAsString(row.getCell(0), "0");
			String code = ReadCellAsString(row.getCell(1), "");
			String index = ReadCellAsString(row.getCell(2), "0");
			String name = ReadCellAsString(row.getCell(3), "");
			String total_kab = ReadCellAsString(row.getCell(5), "0");
			String total_kota = ReadCellAsString(row.getCell(6), "0");
			String total_kec = ReadCellAsString(row.getCell(7), "0");
			String total_kel = ReadCellAsString(row.getCell(8), "0");
			String total_desa = ReadCellAsString(row.getCell(9), "0");
			String luas = ReadCellAsString(row.getCell(10), "0");
			String jumlah = ReadCellAsString(row.getCell(11), "0");
			String keterangan = ReadCellAsString(row.getCell(12), "");
			
			String insertSQL = String.format(Insert_Query_Provinsi, no, code, index, name, total_kab, total_kota, total_kec, total_kel, total_desa, luas, jumlah, keterangan);
			
			System.out.println(insertSQL);
		}
	}
	
	void ParseKecamatanData(Row row) {
		String kodeWilayah =  ReadCellAsString(row.getCell(1), "");
		Matcher m = p.matcher(kodeWilayah);
				
		if(m.matches()) {
			
			String no = ReadCellAsString(row.getCell(0), "0");
			String code = ReadCellAsString(row.getCell(1), "");
			String index = ReadCellAsString(row.getCell(2), "0");
			String name = ReadCellAsString(row.getCell(3), "");
			String total_kab = ReadCellAsString(row.getCell(5), "0");
			String total_kota = ReadCellAsString(row.getCell(6), "0");
			String total_kec = ReadCellAsString(row.getCell(7), "0");
			String total_kel = ReadCellAsString(row.getCell(8), "0");
			String total_desa = ReadCellAsString(row.getCell(9), "0");
			String luas = ReadCellAsString(row.getCell(10), "0");
			String jumlah = ReadCellAsString(row.getCell(11), "0");
			String keterangan = ReadCellAsString(row.getCell(12), "");
			
			String insertSQL = String.format(Insert_Query_Provinsi, no, code, index, name, total_kab, total_kota, total_kec, total_kel, total_desa, luas, jumlah, keterangan);
			
			System.out.println(insertSQL);
		}
	}
	
	private String ReadCellAsString(Cell cell, String defaultValue) {
		String result = defaultValue;
		if(cell == null) return result;
		
		switch (cell.getCellType()) {
			case Cell.CELL_TYPE_NUMERIC:
				result = String.valueOf(cell.getNumericCellValue()).replace(".0", "");
				break;
			case Cell.CELL_TYPE_STRING:
				result = cell.getStringCellValue();
				break;
		}
		
		return result;
	}
}
