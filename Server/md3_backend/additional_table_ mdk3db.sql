-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 25, 2015 at 05:20 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `mdk3db`
--

-- --------------------------------------------------------

--
-- Table structure for table `dat_balance`
--

CREATE TABLE IF NOT EXISTS `dat_balance` (
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

CREATE TABLE IF NOT EXISTS `dat_ktp` (
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

CREATE TABLE IF NOT EXISTS `log_financial_history` (
  `id` varchar(20) NOT NULL,
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

CREATE TABLE IF NOT EXISTS `log_nonfinancial_history` (
  `id` varchar(20) NOT NULL,
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

CREATE TABLE IF NOT EXISTS `log_user_history` (
  `id` varchar(20) NOT NULL,
  `userId` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mt_agama`
--

CREATE TABLE IF NOT EXISTS `mt_agama` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `is_delete` varchar(1) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mt_agama`
--

INSERT INTO `mt_agama` (`cd`, `name`, `keterangan`, `is_delete`, `created_dt`, `created_by`) VALUES
('budha', 'budha', 'budha', 'N', '2015-11-24 00:00:00', 'system'),
('hindu', 'hindu', 'hindu', 'N', '2015-11-24 00:00:00', 'system'),
('islam', 'islam', 'islam', 'N', '2015-11-24 00:00:00', 'system'),
('khatolik', 'khatolik', 'khatolik', 'N', '2015-11-24 00:00:00', 'system'),
('kristen', 'kristen', 'kristen', 'N', '2015-11-24 00:00:00', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `mt_jenis_kelamin`
--

CREATE TABLE IF NOT EXISTS `mt_jenis_kelamin` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `is_delete` varchar(1) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mt_jenis_kelamin`
--

INSERT INTO `mt_jenis_kelamin` (`cd`, `name`, `keterangan`, `is_delete`, `created_dt`, `created_by`) VALUES
('female', 'Perempuan', 'Perempuan', 'N', '2015-11-24 00:00:00', 'system'),
('male', 'Laki-Laki', 'Laki-Laki', 'N', '2015-11-24 00:00:00', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `mt_kabupaten`
--

CREATE TABLE IF NOT EXISTS `mt_kabupaten` (
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

CREATE TABLE IF NOT EXISTS `mt_kecamatan` (
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

CREATE TABLE IF NOT EXISTS `mt_provinsi` (
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

CREATE TABLE IF NOT EXISTS `mt_status_kawin` (
  `cd` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `is_delete` varchar(1) DEFAULT NULL,
  `created_dt` datetime DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mt_status_kawin`
--

INSERT INTO `mt_status_kawin` (`cd`, `name`, `keterangan`, `is_delete`, `created_dt`, `created_by`) VALUES
('duda/janda', 'duda/janda', 'duda/janda', 'N', '2015-11-24 00:00:00', 'system'),
('lajang', 'lajang', 'lajang', 'N', '2015-11-24 00:00:00', 'system'),
('menikah', 'menikah', 'menikah', 'N', '2015-11-24 00:00:00', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `pem_anggota_partai`
--

CREATE TABLE IF NOT EXISTS `pem_anggota_partai` (
  `id` int(10) NOT NULL,
  `id_partai` int(10) NOT NULL,
  `NIK` int(10) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jabatan` varchar(255) NOT NULL,
  `masa_jabatan` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `foto` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_caleg`
--

CREATE TABLE IF NOT EXISTS `pem_caleg` (
  `id` int(11) NOT NULL,
  `id_partai` int(10) NOT NULL,
  `NIK` int(10) NOT NULL,
  `id_jadwal_pemilu` int(10) NOT NULL,
  `id_tahap` int(10) NOT NULL,
  `id_anggota_pemilu` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_jadwal`
--

CREATE TABLE IF NOT EXISTS `pem_jadwal` (
  `id` int(10) NOT NULL,
  `nama` text NOT NULL,
  `tanggal_pelaksanaan` date NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_partai`
--

CREATE TABLE IF NOT EXISTS `pem_partai` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `profile` text NOT NULL,
  `visimisi` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pem_profile_anggota`
--

CREATE TABLE IF NOT EXISTS `pem_profile_anggota` (
  `id` int(10) NOT NULL,
  `pendidikan` varchar(255) NOT NULL,
  `organisasi` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `id_anggota` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_suara`
--

CREATE TABLE IF NOT EXISTS `pem_suara` (
  `id` int(10) NOT NULL,
  `caleg_pilihan` int(10) NOT NULL,
  `id_pemilih` int(10) NOT NULL,
  `id_tahap` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_tahap_pilihan`
--

CREATE TABLE IF NOT EXISTS `pem_tahap_pilihan` (
  `id` int(10) NOT NULL,
  `id_jadwal_pemilu` int(10) NOT NULL,
  `nama` text NOT NULL,
  `tahap` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pem_voter`
--

CREATE TABLE IF NOT EXISTS `pem_voter` (
  `id` int(10) NOT NULL,
  `id_jadwal_pemilu` int(10) NOT NULL,
  `NIK` int(10) NOT NULL,
  `tps_no` int(10) NOT NULL,
  `lokasi` text NOT NULL,
  `provinsi_tps` varchar(255) NOT NULL,
  `kota_tps` varchar(255) NOT NULL,
  `alamat_tps` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sec_module`
--

CREATE TABLE IF NOT EXISTS `sec_module` (
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `activityURL` varchar(100) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_module`
--

INSERT INTO `sec_module` (`code`, `name`, `description`, `activityURL`, `created_dt`, `created_by`) VALUES
('keluhan_ktp', 'keluhan ktp', 'keluhan ktp', 'com.coko.mdk3.modules.keluhanktpActivity', '2015-11-24', 'system'),
('pemilu', 'pemilu', 'pemilu', 'com.coko.mdk3.modules.pemiluActivity', '2015-11-24', 'system'),
('pendingTask', 'Pending Task Module', 'Pending Task Module', 'com.coko.mdk3.modules.pendingTaskActivity', '2015-11-24', 'system'),
('userMaintance', 'userMaintance', 'userMaintance', 'com.coko.mdk3.modules.userMaintenanceAcitivy', '2015-11-24', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `sec_role`
--

CREATE TABLE IF NOT EXISTS `sec_role` (
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_role`
--

INSERT INTO `sec_role` (`code`, `name`, `description`, `created_dt`, `created_by`) VALUES
('admin', 'admin', 'admin', '2015-11-24', 'system'),
('staff', 'staff', 'staff', '2015-11-24', 'system'),
('user', 'user', 'user', '2015-11-24', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `sec_role_module`
--

CREATE TABLE IF NOT EXISTS `sec_role_module` (
  `id` varchar(50) NOT NULL,
  `roleCode` varchar(20) NOT NULL,
  `moduleCode` varchar(20) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sec_role_module_sec_module1_idx` (`moduleCode`),
  KEY `fk_sec_role_module_sec_role1_idx` (`roleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_role_module`
--

INSERT INTO `sec_role_module` (`id`, `roleCode`, `moduleCode`, `created_dt`, `created_by`) VALUES
('a1c71f58-92c8-11e5-b7ed-df75ad050f3c', 'admin', 'userMaintance', '2015-11-24', 'system'),
('a1c73402-92c8-11e5-b7ed-df75ad050f3c', 'staff', 'pendingTask', '2015-11-24', 'system'),
('afa099b0-92c8-11e5-b7ed-df75ad050f3c', 'user', 'keluhan_ktp', '2015-11-24', ''),
('afa0aae0-92c8-11e5-b7ed-df75ad050f3c', 'user', 'pemilu', '2015-11-24', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `sec_user`
--

CREATE TABLE IF NOT EXISTS `sec_user` (
  `id` varchar(50) NOT NULL,
  `NIK` varchar(16) NOT NULL,
  `is_login` char(1) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `updated_dt` date DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_user`
--

INSERT INTO `sec_user` (`id`, `NIK`, `is_login`, `created_dt`, `created_by`, `updated_dt`, `updated_by`) VALUES
('18aae9c6-92c7-11e5-b7ed-df75ad050f3c', '12345', 'N', '2015-11-24', 'system', NULL, NULL),
('1f337222-92c7-11e5-b7ed-df75ad050f3c', '123456', 'N', '2015-11-24', 'system', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sec_user_pass`
--

CREATE TABLE IF NOT EXISTS `sec_user_pass` (
  `userId` varchar(50) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `validUntil` date NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `updated_dt` date NOT NULL,
  `updated_by` varchar(20) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_user_pass`
--

INSERT INTO `sec_user_pass` (`userId`, `passwd`, `validUntil`, `created_dt`, `created_by`, `updated_dt`, `updated_by`) VALUES
('18aae9c6-92c7-11e5-b7ed-df75ad050f3c', 'password', '2016-12-31', '2015-11-24', 'system', '0000-00-00', ''),
('1f337222-92c7-11e5-b7ed-df75ad050f3c', 'password', '2016-12-31', '2015-11-24', 'system', '0000-00-00', '');

-- --------------------------------------------------------

--
-- Table structure for table `sec_user_role`
--

CREATE TABLE IF NOT EXISTS `sec_user_role` (
  `id` varchar(50) NOT NULL,
  `userId` varchar(50) NOT NULL,
  `roleCode` varchar(100) NOT NULL,
  `created_dt` date NOT NULL,
  `created_by` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sec_user_role_sec_user1_idx` (`userId`),
  KEY `fk_sec_user_role_role_idx` (`roleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sec_user_role`
--

INSERT INTO `sec_user_role` (`id`, `userId`, `roleCode`, `created_dt`, `created_by`) VALUES
('1b7965e0-92d3-11e5-9742-5d0b21822c55', '18aae9c6-92c7-11e5-b7ed-df75ad050f3c', 'staff', '2015-11-25', 'system'),
('f745caa6-92d2-11e5-9742-5d0b21822c55', '1f337222-92c7-11e5-b7ed-df75ad050f3c', 'user', '2015-11-25', 'system'),
('f745f15c-92d2-11e5-9742-5d0b21822c55', '18aae9c6-92c7-11e5-b7ed-df75ad050f3c', 'admin', '2015-11-25', 'system');

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
  ADD CONSTRAINT `fk_ktp_agama` FOREIGN KEY (`Agama`) REFERENCES `mt_agama` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ktp_jenis_kelamin` FOREIGN KEY (`Jenis_Kelamin`) REFERENCES `mt_jenis_kelamin` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ktp_kecamatan` FOREIGN KEY (`Kecamatan`) REFERENCES `mt_kecamatan` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ktp_status_kawin` FOREIGN KEY (`Status_Kawin`) REFERENCES `mt_status_kawin` (`cd`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_sec_user_role_role` FOREIGN KEY (`roleCode`) REFERENCES `sec_role` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_sec_user_role_user` FOREIGN KEY (`userId`) REFERENCES `sec_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
