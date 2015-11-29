package com.coko.server.mdk3.representations;

import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.coko.server.mdk3.dao.ParameterDAO;
import com.coko.server.mdk3.helpers.MDK3Tools;

public class NIKObject {
	/*
		Example: 35 02 04 47 02 90 0002
		1. Kode Propinsi : Dua digit pertama merupakan kode Propinsi.
		2. Kode Kabupaten/Kota : dua digit selanjutnya merupakan kode kabupaten atau kota madya.
		3. Kode Kecamatan : dua digit ketiga merupakan kode kecamatan. Anda bisa melihat daftar kode wilayah Propinsi, Kabupaten, dan Kecamatan melalui link http://www.kemendagri.go.id/pages/data-wilayah (http://www.kemendagri.go.id/pages/data-wilayah)
		4. Kode tanggal lahir : dua digit ke empat merupakan kode tanggal lahir. Untuk pria tanggal lahir di tulis dengan angka 01-31. Sedangkan untuk wanita tanggal lahir ditambah angka 40. Untuk contoh gambar di atas maka wanita tersebut lahir tanggal 7 (47-40).
		5. Kode bulan lahir : ditulis dengan angka 01-12.
		6. Kode tahun lahir : ditulis dua digit terakhir tahun lahir.
		7. Kode Nomor komputerisasi : dibuat secara random oleh komputer agar tidak sama dengan lainnya.
	*/
	
	private String PATTERN_NUMERIC = "[0-9]";
	
	private String ERROR_MESSAGE_EMPTY = "NIK( is empty";
	private String ERROR_MESSAGE_LENGTH = "NIK(%s) length must be %d";
	private String ERROR_MESSAGE_NOT_VALID = "NIK(%s) is not valid (%s)";
	
	private Pattern pattern = Pattern.compile(PATTERN_NUMERIC);
	
	public NIKObject(String nik, ParameterDAO paramDAO) {
		
		GenerateError(nik != null, ERROR_MESSAGE_EMPTY);
		GenerateError(nik.length() == 16, ERROR_MESSAGE_LENGTH, nik, 16);
		if(!validationMessages.isEmpty()) return;
		
		propinsi = nik.substring(0, 2);
		GenerateError(paramDAO.getProvinsiByCode(propinsi) == null, ERROR_MESSAGE_NOT_VALID, nik, "Propinsi");
		
		kabupaten = nik.substring(2, 4);
		GenerateError(paramDAO.getKabupatenByCode(kabupaten) == null, ERROR_MESSAGE_NOT_VALID, nik, "Kabupaten");
		
		kecamatan = nik.substring(4, 6);
		GenerateError(paramDAO.getKecamatanByCode(kecamatan) == null, ERROR_MESSAGE_NOT_VALID, nik, "Kecamatan");
		
		tanggalLahir = nik.substring(6, 8);
		GenerateError(pattern.matcher(tanggalLahir).matches(), ERROR_MESSAGE_NOT_VALID, nik, "Tanggal Lahir");
		GenerateError(Integer.parseInt(tanggalLahir) > 0 && Integer.parseInt(tanggalLahir) < 32, ERROR_MESSAGE_NOT_VALID, nik, "Tanggal Lahir");		
		
		bulanLahir = nik.substring(8, 10);
		GenerateError(pattern.matcher(tanggalLahir).matches(), ERROR_MESSAGE_NOT_VALID, nik, "Bulan Lahir");
		GenerateError(Integer.parseInt(tanggalLahir) > 0 && Integer.parseInt(bulanLahir) < 13, ERROR_MESSAGE_NOT_VALID, nik, "Bulan Lahir");
		
		tahunLahir = nik.substring(10, 12);
		GenerateError(pattern.matcher(tanggalLahir).matches(), ERROR_MESSAGE_NOT_VALID, nik, "Tahun Lahir");
		
		nomorKomputerisasi = nik.substring(12, 16);
	}

	private String propinsi;
	private String kabupaten;
	private String kecamatan;
	private String tanggalLahir;
	private String bulanLahir;
	private String tahunLahir;
	private String nomorKomputerisasi;
	
	private Set<String> validationMessages = new HashSet<String>();
	public Set<String> getErrorMessages() {
		return validationMessages;
	}
	
	public void GenerateError(boolean isValid, String messageError, Object... params) {
		if(!isValid) {
			String errorMessage = String.format(messageError, params);
			validationMessages.add(errorMessage);
			
			System.out.println("Error:: " + errorMessage);
		}
	}

	public String getPropinsi() {
		return propinsi;
	}

	public void setPropinsi(String propinsi) {
		this.propinsi = propinsi;
	}

	public String getKabupaten() {
		return kabupaten;
	}

	public void setKabupaten(String kabupaten) {
		this.kabupaten = kabupaten;
	}

	public String getKecamatan() {
		return kecamatan;
	}

	public void setKecamatan(String kecamatan) {
		this.kecamatan = kecamatan;
	}

	public String getTanggalLahir() {
		return tanggalLahir;
	}

	public void setTanggalLahir(String tanggalLahir) {
		this.tanggalLahir = tanggalLahir;
	}

	public String getBulanLahir() {
		return bulanLahir;
	}

	public void setBulanLahir(String bulanLahir) {
		this.bulanLahir = bulanLahir;
	}

	public String getTahunLahir() {
		return tahunLahir;
	}

	public void setTahunLahir(String tahunLahir) {
		this.tahunLahir = tahunLahir;
	}

	public String getNomorKomputerisasi() {
		return nomorKomputerisasi;
	}

	public void setNomorKomputerisasi(String nomorKomputerisasi) {
		this.nomorKomputerisasi = nomorKomputerisasi;
	}

	@Override
	public String toString() {
		return "NIKObject [propinsi=" + propinsi + ", kabupaten=" + kabupaten
				+ ", kecamatan=" + kecamatan + ", tanggalLahir=" + tanggalLahir
				+ ", bulanLahir=" + bulanLahir + ", tahunLahir=" + tahunLahir
				+ ", nomorKomputerisasi=" + nomorKomputerisasi + "]";
	}

}
