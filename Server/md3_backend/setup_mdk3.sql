-- Query Setup Database MYSQL
CREATE DATABASE `mdk3db`;

CREATE USER 'mdk3user'@'localhost' IDENTIFIED BY 'mdk3password';
GRANT ALL ON mdk3db.* TO 'mdk3user'@'localhost';

USE `mdk3db`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

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

CREATE TABLE `log_nonfinancial_history` (
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

CREATE TABLE `log_user_history` (
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

CREATE TABLE `mt_agama` (
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

CREATE TABLE `mt_jenis_kelamin` (
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

--
-- Dumping data for table `mt_status_kawin`
--

INSERT INTO `mt_status_kawin` (`cd`, `name`, `keterangan`, `is_delete`, `created_dt`, `created_by`) VALUES
('duda/janda', 'duda/janda', 'duda/janda', 'N', '2015-11-24 00:00:00', 'system'),
('lajang', 'lajang', 'lajang', 'N', '2015-11-24 00:00:00', 'system'),
('menikah', 'menikah', 'menikah', 'N', '2015-11-24 00:00:00', 'system');

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

CREATE TABLE `sec_role` (
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

CREATE TABLE `sec_role_module` (
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

CREATE TABLE `sec_user` (
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

CREATE TABLE `sec_user_pass` (
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

CREATE TABLE `sec_user_role` (
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