package com.example.user.mdk3.model;

import java.util.Date;

/**
 * Created by User on 11/19/2015.
 */
public class User {
    public static String nik;
    public static String nama;
    public static String tempat;
    public static Date tanggalLahir;
    public static String gender;
    public static String alamat;
    public static String rtrw;
    public static String kelurahan;
    public static String kecamatan;

    public static void setNik(String nik) {
        User.nik = nik;
    }

    public static String getNik() {
        return nik;
    }
}
