-- Query Setup Database MYSQL
CREATE DATABASE `mdk3db`;

CREATE USER 'mdk3user'@'localhost' IDENTIFIED BY 'mdk3password';
GRANT ALL ON mdk3db.* TO 'mdk3user'@'localhost';

USE `mdk3db`;

-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Nov 26, 2015 at 01:15 AM
-- Server version: 5.5.34
-- PHP Version: 5.5.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `mdk3db`
--

-- --------------------------------------------------------

--
-- Table structure for table `dat_balance`
--

CREATE TABLE `dat_balance` (
  `NIK` varchar(16) NOT NULL,
  `balance` bigint(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `updated_dt` date NOT NULL,
  `updated_by` varchar(20) NOT NULL,
  `is_delete` varchar(1) NOT NULL,
  `dat_ktp_NIK` varchar(16) NOT NULL,
  PRIMARY KEY (`NIK`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dat_ktp`
--

CREATE TABLE `dat_ktp` (
  `NIK` varchar(16) NOT NULL,
  `Nama` varchar(20) NOT NULL,
  `Tempat` varchar(20) NOT NULL,
  `Tanggal_Lahir` date NOT NULL,
  `Jenis_Kelamin` varchar(20) NOT NULL,
  `Alamat` text NOT NULL,
  `RT_RW` varchar(20) NOT NULL,
  `Desa_Kelurahan` varchar(20) NOT NULL,
  `Kecamatan` varchar(20) NOT NULL,
  `Agama` varchar(20) NOT NULL,
  `Status_Kawin` varchar(20) NOT NULL,
  `Pekerjaan` varchar(100) NOT NULL,
  `Berlaku_Hingga` date NOT NULL,
  `Kewarganegaraan` varchar(20) NOT NULL,
  `Foto` blob NOT NULL,
  `Tgl_Pengajuan` date NOT NULL,
  `Tgl_Dikeluarkan` date NOT NULL,
  `Tanda_Tangan` blob NOT NULL,
  PRIMARY KEY (`NIK`),
  KEY `fk_ktp_kecamatan_idx` (`Kecamatan`),
  KEY `fk_ktp_jenis_kelamin_idx` (`Jenis_Kelamin`),
  KEY `fk_ktp_status_kawin_idx` (`Status_Kawin`),
  KEY `fk_ktp_agama_idx` (`Agama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `log_financial_history`
--

CREATE TABLE `log_financial_history` (
  `id` varchar(50) NOT NULL,
  `moduleCode` varchar(20) NOT NULL,
  `ref_no` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `log_val` text NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_log_financial_module_idx` (`moduleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `log_nonfinancial_history`
--

CREATE TABLE `log_nonfinancial_history` (
  `id` varchar(50) NOT NULL,
  `moduleCode` varchar(20) NOT NULL,
  `refNo` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `log_val` text NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_nonfinancial_module_idx` (`moduleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `log_user_history`
--

CREATE TABLE `log_user_history` (
  `id` varchar(50) NOT NULL,
  `userId` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mt_agama`
--

CREATE TABLE `mt_agama` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `is_delete` varchar(1) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mt_jenis_kelamin`
--

CREATE TABLE `mt_jenis_kelamin` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `is_delete` varchar(1) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mt_kabupaten`
--

CREATE TABLE `mt_kabupaten` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `keterangan` text NOT NULL,
  `is_delete` varchar(1) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `provinsi` varchar(20) NOT NULL,
  `ibukota` varchar(20) NOT NULL,
  `tot_kecamatan` int(11) NOT NULL,
  `tot_desa` int(11) NOT NULL,
  `luas` int(11) NOT NULL,
  `jumlah_penduduk` int(11) NOT NULL,
  PRIMARY KEY (`cd`),
  KEY `fk_mt_kabupaten_mt_kecamatan1_idx` (`provinsi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mt_kecamatan`
--

CREATE TABLE `mt_kecamatan` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `keterangan` text NOT NULL,
  `is_delete` varchar(1) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `kabupaten` varchar(20) NOT NULL,
  `tot_desa` int(11) NOT NULL,
  PRIMARY KEY (`cd`),
  KEY `fk_kecamatan_idx` (`kabupaten`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mt_provinsi`
--

CREATE TABLE `mt_provinsi` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `keterangan` text NOT NULL,
  `is_delete` varchar(1) NOT NULL,
  `created_dt` varchar(20) NOT NULL,
  `created_by` date NOT NULL,
  `tot_kabupaten` int(11) NOT NULL,
  `tot_kota` int(11) NOT NULL,
  `tot_kecamatan` int(11) NOT NULL,
  `tot_kelurahan` int(11) NOT NULL,
  `tot_desa` int(11) NOT NULL,
  `luas` int(11) NOT NULL,
  `jumlah_penduduk` int(11) NOT NULL,
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mt_status_kawin`
--

CREATE TABLE `mt_status_kawin` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `is_delete` varchar(1) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_anggota_partai`
--

CREATE TABLE `pem_anggota_partai` (
  `id` varchar(50) NOT NULL,
  `id_partai` varchar(50) NOT NULL,
  `NIK` varchar(16) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jabatan` varchar(100) NOT NULL,
  `masa_jabatan` datetime NOT NULL,
  `status` varchar(100) NOT NULL,
  `foto` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_anggota_partai_ktp_idx` (`NIK`),
  KEY `fk_anggota_partai_partai_idx` (`id_partai`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_caleg`
--

CREATE TABLE `pem_caleg` (
  `id` varchar(50) NOT NULL,
  `id_partai` varchar(50) NOT NULL,
  `NIK` varchar(50) NOT NULL,
  `id_jadwal_pemilu` varchar(50) NOT NULL,
  `id_tahap` varchar(50) NOT NULL,
  `id_anggota_pemilu` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_caleg_nik_idx` (`NIK`),
  KEY `fk_caleg_jadwal_idx` (`id_jadwal_pemilu`),
  KEY `fk_caleg_partai_idx` (`id_partai`),
  KEY `fk_caleg_tahap_idx` (`id_tahap`),
  KEY `fk_caleg_anggota_idx` (`id_anggota_pemilu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_jadwal`
--

CREATE TABLE `pem_jadwal` (
  `id` varchar(50) NOT NULL,
  `nama` text NOT NULL,
  `tanggal_pelaksanaan` date NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_partai`
--

CREATE TABLE `pem_partai` (
  `id` varchar(50) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `logo` blob NOT NULL,
  `profile` text NOT NULL,
  `visimisi` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_profile_anggota`
--

CREATE TABLE `pem_profile_anggota` (
  `id` varchar(50) NOT NULL,
  `pendidikan` varchar(255) NOT NULL,
  `organisasi` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `id_anggota` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profile_anggota_idx` (`id_anggota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_suara`
--

CREATE TABLE `pem_suara` (
  `id` varchar(50) NOT NULL,
  `caleg_pilihan` varchar(50) NOT NULL,
  `id_pemilih` varchar(50) NOT NULL,
  `id_tahap` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_suara_calegpilihan_idx` (`caleg_pilihan`),
  KEY `fk_suara_pemilih_idx` (`id_pemilih`),
  KEY `fk_suara_tahap_idx` (`id_tahap`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_tahap_pilihan`
--

CREATE TABLE `pem_tahap_pilihan` (
  `id` varchar(50) NOT NULL,
  `id_jadwal_pemilu` varchar(50) NOT NULL,
  `nama` text NOT NULL,
  `tahap` int(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tahap_jadwal_idx` (`id_jadwal_pemilu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_voter`
--

CREATE TABLE `pem_voter` (
  `id` varchar(50) NOT NULL,
  `id_jadwal_pemilu` varchar(50) NOT NULL,
  `NIK` varchar(50) NOT NULL,
  `tps_no` int(10) NOT NULL,
  `lokasi` text NOT NULL,
  `provinsi_tps` varchar(255) NOT NULL,
  `kota_tps` varchar(255) NOT NULL,
  `alamat_tps` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voter_jadwal_idx` (`id_jadwal_pemilu`),
  KEY `fk_voter_nik_idx` (`NIK`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sec_module`
--

CREATE TABLE `sec_module` (
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `activityURL` varchar(100) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sec_role`
--

CREATE TABLE `sec_role` (
  `code` varchar(20) NOT NULL,
  `name` int(100) NOT NULL,
  `description` text NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sec_role_module`
--

CREATE TABLE `sec_role_module` (
  `id` varchar(20) NOT NULL,
  `roleCode` varchar(20) NOT NULL,
  `moduleCode` varchar(20) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sec_role_module_sec_module1_idx` (`moduleCode`),
  KEY `fk_sec_role_module_sec_role1_idx` (`roleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sec_user`
--

CREATE TABLE `sec_user` (
  `id` varchar(20) NOT NULL,
  `NIK` varchar(16) NOT NULL,
  `is_login` char(1) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `updated_dt` date DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sec_user_pass`
--

CREATE TABLE `sec_user_pass` (
  `userId` varchar(20) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `validUntil` date NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `updated_dt` date NOT NULL,
  `updated_by` varchar(20) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sec_user_role`
--

CREATE TABLE `sec_user_role` (
  `id` varchar(50) NOT NULL,
  `userId` varchar(20) NOT NULL,
  `roleCode` varchar(100) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sec_user_role_sec_user1_idx` (`userId`),
  KEY `fk_sec_user_role_role_idx` (`roleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dat_balance`
--
ALTER TABLE `dat_balance`
  ADD CONSTRAINT `fk_dat_balance_dat_ktp1` FOREIGN KEY (`NIK`) REFERENCES `dat_ktp` (`NIK`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `dat_ktp`
--
ALTER TABLE `dat_ktp`
  ADD CONSTRAINT `fk_ktp_kecamatan` FOREIGN KEY (`Kecamatan`) REFERENCES `mt_kecamatan` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ktp_status_kawin` FOREIGN KEY (`Status_Kawin`) REFERENCES `mt_status_kawin` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ktp_jenis_kelamin` FOREIGN KEY (`Jenis_Kelamin`) REFERENCES `mt_jenis_kelamin` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ktp_agama` FOREIGN KEY (`Agama`) REFERENCES `mt_agama` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `log_financial_history`
--
ALTER TABLE `log_financial_history`
  ADD CONSTRAINT `fk_log_financial_module` FOREIGN KEY (`moduleCode`) REFERENCES `sec_module` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `log_nonfinancial_history`
--
ALTER TABLE `log_nonfinancial_history`
  ADD CONSTRAINT `fk_nonfinancial_module` FOREIGN KEY (`moduleCode`) REFERENCES `sec_module` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mt_kabupaten`
--
ALTER TABLE `mt_kabupaten`
  ADD CONSTRAINT `fk_mt_kabupaten_provinsi` FOREIGN KEY (`provinsi`) REFERENCES `mt_provinsi` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mt_kecamatan`
--
ALTER TABLE `mt_kecamatan`
  ADD CONSTRAINT `fk_kecamatan` FOREIGN KEY (`kabupaten`) REFERENCES `mt_kabupaten` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pem_anggota_partai`
--
ALTER TABLE `pem_anggota_partai`
  ADD CONSTRAINT `fk_anggota_partai_ktp` FOREIGN KEY (`NIK`) REFERENCES `dat_ktp` (`NIK`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_anggota_partai_partai` FOREIGN KEY (`id_partai`) REFERENCES `pem_partai` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pem_caleg`
--
ALTER TABLE `pem_caleg`
  ADD CONSTRAINT `fk_caleg_nik` FOREIGN KEY (`NIK`) REFERENCES `dat_ktp` (`NIK`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_caleg_jadwal` FOREIGN KEY (`id_jadwal_pemilu`) REFERENCES `pem_jadwal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_caleg_partai` FOREIGN KEY (`id_partai`) REFERENCES `pem_partai` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_caleg_tahap` FOREIGN KEY (`id_tahap`) REFERENCES `pem_tahap_pilihan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_caleg_anggota` FOREIGN KEY (`id_anggota_pemilu`) REFERENCES `pem_anggota_partai` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pem_profile_anggota`
--
ALTER TABLE `pem_profile_anggota`
  ADD CONSTRAINT `fk_profile_anggota` FOREIGN KEY (`id_anggota`) REFERENCES `pem_anggota_partai` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pem_suara`
--
ALTER TABLE `pem_suara`
  ADD CONSTRAINT `fk_suara_calegpilihan` FOREIGN KEY (`caleg_pilihan`) REFERENCES `pem_caleg` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_suara_pemilih` FOREIGN KEY (`id_pemilih`) REFERENCES `dat_ktp` (`NIK`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_suara_tahap` FOREIGN KEY (`id_tahap`) REFERENCES `pem_tahap_pilihan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pem_tahap_pilihan`
--
ALTER TABLE `pem_tahap_pilihan`
  ADD CONSTRAINT `fk_tahap_jadwal` FOREIGN KEY (`id_jadwal_pemilu`) REFERENCES `pem_jadwal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pem_voter`
--
ALTER TABLE `pem_voter`
  ADD CONSTRAINT `fk_voter_jadwal` FOREIGN KEY (`id_jadwal_pemilu`) REFERENCES `pem_jadwal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_voter_nik` FOREIGN KEY (`NIK`) REFERENCES `dat_ktp` (`NIK`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sec_role_module`
--
ALTER TABLE `sec_role_module`
  ADD CONSTRAINT `fk_sec_role_module_sec_module1` FOREIGN KEY (`moduleCode`) REFERENCES `sec_module` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sec_role_module_sec_role1` FOREIGN KEY (`roleCode`) REFERENCES `sec_role` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sec_user_pass`
--
ALTER TABLE `sec_user_pass`
  ADD CONSTRAINT `fk_sec_user_and_pass` FOREIGN KEY (`userId`) REFERENCES `sec_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sec_user_role`
--
ALTER TABLE `sec_user_role`
  ADD CONSTRAINT `fk_sec_user_role_user` FOREIGN KEY (`userId`) REFERENCES `sec_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sec_user_role_role` FOREIGN KEY (`roleCode`) REFERENCES `sec_role` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION;
