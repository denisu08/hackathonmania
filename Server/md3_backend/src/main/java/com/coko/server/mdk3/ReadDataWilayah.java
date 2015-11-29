package com.coko.server.mdk3;

import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.coko.server.mdk3.helpers.MDK3Tools;

public class ReadDataWilayah {
	
	private static String Regex_Provinsi = "[0-9]{2}+";
	private static String Insert_Query_Provinsi = "insert into mt_provinsi(cd, name, `index`, is_delete, created_dt, created_by, tot_kabupaten, tot_kota, tot_kecamatan, tot_kelurahan, tot_desa, luas, jumlah_penduduk, keterangan) "
			+ "values ('%s', '%s', %s, 'N', current_date, 'system', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');";
	
	private static String Regex_Kabupaten = "[0-9]{2}+\\.[0-9]{2}+";
	private static String Insert_Query_Kabupaten = "insert into mt_kabupaten(cd, name, keterangan, is_delete, created_dt, created_by, provinsi, ibukota, tot_kecamatan, tot_desa, luas, jumlah_penduduk) "
			+ "values ('%s', '%s', '%s','N', current_date, 'system' ,'%s', '%s', '%s', '%s', '%s', '%s');";
	
	private static String Regex_Kecamatan = "[0-9]{2}+\\.[0-9]{2}+\\.[0-9]{2}+";
	private static String Insert_Query_Kecamatan = "insert into mt_kecamatan(cd, name, keterangan, is_delete, created_dt, created_by, kabupaten, tot_desa) "
			+ " values ('%s', '%s', '%s', 'N', current_date, 'system', '%s', '%s');";
	
	private Pattern p;
	
	public static void main(String[] args) {
		new ReadDataWilayah().parseAllData();
	}
	
	void parseAllData() {
		try {
			System.out.println("Run Read Data Wilayah...");
			FileInputStream file = new FileInputStream(new File("RawData/data_dan_wilayah_2013.xlsx"));
			BufferedWriter bw = new BufferedWriter(new FileWriter(new File("RawData/data_dan_wilayah_2013.txt")));

			// Create Workbook instance holding reference to .xlsx file
			XSSFWorkbook workbook = new XSSFWorkbook(file);

			// Get first/desired sheet from the workbook
			XSSFSheet sheet = workbook.getSheetAt(0);

			Iterator<Row> rowIterator;
			System.out.println("Read and convert to insert sql provinsi...");
			// Read Data Provinsi
			p = Pattern.compile(Regex_Provinsi);
			rowIterator = sheet.iterator();
			bw.write("\n\n-- Insert Data MT_PROVINSI\n");
			while (rowIterator.hasNext()) {
				ParseProvinsiData(rowIterator.next(), bw);
			}
			
			System.out.println("Read and convert to insert sql kabupateni...");
			// Read Data Kabupaten
			p = Pattern.compile(Regex_Kabupaten);
			rowIterator = sheet.iterator();
			bw.write("\n\n-- Insert Data MT_KABUPATEN\n");
			while (rowIterator.hasNext()) {
				ParseKabupatenData(rowIterator.next(), bw);
			}
			
			System.out.println("Read and convert to insert sql kelurahan...");
			// Read Data Kelurahan
			p = Pattern.compile(Regex_Kecamatan);
			rowIterator = sheet.iterator();
			bw.write("\n\n-- Insert Data MT_KECAMATAN\n");
			while (rowIterator.hasNext()) {
				ParseKecamatanData(rowIterator.next(), bw);
			}
			
			System.out.println("Done create file...");
			
			file.close();
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void ParseProvinsiData(Row row, BufferedWriter bw) throws IOException {
		String kodeWilayah =  ReadCellAsString(row.getCell(1), "");
		Matcher m = p.matcher(kodeWilayah);
				
		if(m.matches()) {
			
			int no = MDK3Tools.romanToDecimal(ReadCellAsString(row.getCell(0), "0"));
			String code = ReadCellAsString(row.getCell(1), "");
			String name = ReadCellAsString(row.getCell(3), "");
			String total_kab = ReadCellAsString(row.getCell(5), "0");
			String total_kota = ReadCellAsString(row.getCell(6), "0");
			String total_kec = ReadCellAsString(row.getCell(7), "0");
			String total_kel = ReadCellAsString(row.getCell(8), "0");
			String total_desa = ReadCellAsString(row.getCell(9), "0");
			String luas = ReadCellAsString(row.getCell(10), "0");
			String jumlah = ReadCellAsString(row.getCell(11), "0");
			String keterangan = ReadCellAsString(row.getCell(12), "");
			
			String insertSQL = String.format(Insert_Query_Provinsi, code, name, no, total_kab, total_kota, total_kec, total_kel, total_desa, luas, jumlah, keterangan);
			
			// System.out.println(insertSQL);
			bw.write(insertSQL + "\n");
		}
	}
	
	void ParseKabupatenData(Row row, BufferedWriter bw) throws IOException {
		String kodeWilayah =  ReadCellAsString(row.getCell(1), "");
		Matcher m = p.matcher(kodeWilayah);
				
		if(m.matches()) {
			
			String code = ReadCellAsString(row.getCell(1), "");
			String name = ReadCellAsString(row.getCell(3), "");
			String ibukota = ReadCellAsString(row.getCell(4), "");
			String total_kec = ReadCellAsString(row.getCell(7), "0");
			String total_kel = ReadCellAsString(row.getCell(8), "0");
			String total_desa = ReadCellAsString(row.getCell(9), "0");
			String luas = ReadCellAsString(row.getCell(10), "0");
			String jumlah = ReadCellAsString(row.getCell(11), "0");
			String keterangan = ReadCellAsString(row.getCell(12), "");
			
			if(code.equals("")) return;
			String insertSQL = String.format(Insert_Query_Kabupaten, code, name, keterangan, code.split("\\.")[0], ibukota, total_kec, total_kel, total_desa, luas, jumlah);
			bw.write(insertSQL + "\n");
		}
	}
	
	void ParseKecamatanData(Row row, BufferedWriter bw) throws IOException {
		String kodeWilayah =  ReadCellAsString(row.getCell(1), "");
		Matcher m = p.matcher(kodeWilayah);
				
		if(m.matches()) {
			
			String code = ReadCellAsString(row.getCell(1), "");
			String name = ReadCellAsString(row.getCell(3), "");
			String total_desa = ReadCellAsString(row.getCell(9), "0");
			String keterangan = ReadCellAsString(row.getCell(12), "");
			
			if(code.equals("")) return;
			// "insert into mt_kecamatan(cd, name, keterangan, is_delete, created_dt, created_by, kabupaten, tot_desa) "
			String insertSQL = String.format(Insert_Query_Kecamatan, code, name, keterangan, code.split("\\.")[0] + "." + code.split("\\.")[1], total_desa);
			
			// System.out.println(insertSQL);
			bw.write(insertSQL + "\n");
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
