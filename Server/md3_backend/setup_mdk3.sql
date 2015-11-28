-- Query Setup Database MYSQL

-- Setup Database & Security
CREATE DATABASE `mdk3db`;
CREATE USER 'mdk3user'@'localhost' IDENTIFIED BY 'mdk3password';
GRANT ALL ON mdk3db.* TO 'mdk3user'@'localhost';
USE `mdk3db`;

-- Setup Table and relation
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mdk3db` ;
CREATE SCHEMA IF NOT EXISTS `mdk3db` DEFAULT CHARACTER SET latin1 ;
USE `mdk3db` ;

-- -----------------------------------------------------
-- Table `mdk3db`.`mt_provinsi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`mt_provinsi` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`mt_provinsi` (
  `cd` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `keterangan` TEXT NOT NULL,
  `is_delete` VARCHAR(1) NOT NULL,
  `created_dt` VARCHAR(20) NOT NULL,
  `created_by` DATE NOT NULL,
  `tot_kabupaten` INT(11) NOT NULL,
  `tot_kota` INT(11) NOT NULL,
  `tot_kecamatan` INT(11) NOT NULL,
  `tot_kelurahan` INT(11) NOT NULL,
  `tot_desa` INT(11) NOT NULL,
  `luas` INT(11) NOT NULL,
  `jumlah_penduduk` INT(11) NOT NULL,
  PRIMARY KEY (`cd`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`mt_kabupaten`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`mt_kabupaten` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`mt_kabupaten` (
  `cd` VARCHAR(20) NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `keterangan` TEXT NOT NULL,
  `is_delete` VARCHAR(1) NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  `provinsi` VARCHAR(20) NOT NULL,
  `ibukota` VARCHAR(20) NOT NULL,
  `tot_kecamatan` INT(11) NOT NULL,
  `tot_desa` INT(11) NOT NULL,
  `luas` INT(11) NOT NULL,
  `jumlah_penduduk` INT(11) NOT NULL,
  PRIMARY KEY (`cd`),
  INDEX `fk_mt_kabupaten_mt_kecamatan1_idx` (`provinsi` ASC),
  CONSTRAINT `fk_mt_kabupaten_provinsi`
    FOREIGN KEY (`provinsi`)
    REFERENCES `mdk3db`.`mt_provinsi` (`cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`mt_kecamatan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`mt_kecamatan` ;

SET foreign_key_checks = 0;
DROP TABLE IF EXISTS `mdk3db`.`mt_kecamatan` ;
SET foreign_key_checks = 1;

--SET foreign_key_checks = 0;
--alter table mt_kecamatan add constraint fk_kecamatan_kabupaten foreign key(kabupaten) references mt_kabupaten (cd);
--SET foreign_key_checks = 1;

CREATE TABLE IF NOT EXISTS `mdk3db`.`mt_kecamatan` (
  `cd` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `keterangan` TEXT NOT NULL,
  `is_delete` VARCHAR(1) NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  `kabupaten` VARCHAR(20) NOT NULL,
  `tot_desa` INT(11) NOT NULL,
  PRIMARY KEY (`cd`)),
--  INDEX `fk_kecamatan_idx` (`kabupaten` ASC),
--  CONSTRAINT `fk_kecamatan`
--    FOREIGN KEY (`kabupaten`)
--    REFERENCES `mdk3db`.`mt_kabupaten` (`cd`)
--    ON DELETE NO ACTION
--    ON UPDATE NO ACTION)
--ENGINE = InnoDB
--DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`mt_status_kawin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`mt_status_kawin` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`mt_status_kawin` (
  `cd` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NULL,
  `keterangan` TEXT NULL,
  `is_delete` VARCHAR(1) NULL,
  `created_dt` DATETIME NULL,
  `created_by` VARCHAR(20) NULL,
  PRIMARY KEY (`cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdk3db`.`mt_jenis_kelamin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`mt_jenis_kelamin` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`mt_jenis_kelamin` (
  `cd` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NULL,
  `keterangan` TEXT NULL,
  `is_delete` VARCHAR(1) NULL,
  `created_dt` DATETIME NULL,
  `created_by` VARCHAR(20) NULL,
  PRIMARY KEY (`cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdk3db`.`mt_agama`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`mt_agama` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`mt_agama` (
  `cd` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NULL,
  `keterangan` TEXT NULL,
  `is_delete` VARCHAR(1) NULL,
  `created_dt` DATETIME NULL,
  `created_by` VARCHAR(20) NULL,
  PRIMARY KEY (`cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mdk3db`.`dat_ktp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`dat_ktp` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`dat_ktp` (
  `NIK` VARCHAR(16) NOT NULL,
  `Nama` VARCHAR(20) NOT NULL,
  `Tempat` VARCHAR(20) NOT NULL,
  `Tanggal_Lahir` DATE NOT NULL,
  `Jenis_Kelamin` VARCHAR(20) NOT NULL,
  `Alamat` TEXT NOT NULL,
  `RT_RW` VARCHAR(20) NOT NULL,
  `Desa_Kelurahan` VARCHAR(20) NOT NULL,
  `Kecamatan` VARCHAR(20) NOT NULL,
  `Agama` VARCHAR(20) NOT NULL,
  `Status_Kawin` VARCHAR(20) NOT NULL,
  `Pekerjaan` VARCHAR(100) NOT NULL,
  `Berlaku_Hingga` DATE NOT NULL,
  `Kewarganegaraan` VARCHAR(20) NOT NULL,
  `Foto` BLOB NOT NULL,
  `Tgl_Pengajuan` DATE NOT NULL,
  `Tgl_Dikeluarkan` DATE NOT NULL,
  `Tanda_Tangan` BLOB NOT NULL,
  PRIMARY KEY (`NIK`),
  INDEX `fk_ktp_kecamatan_idx` (`Kecamatan` ASC),
  INDEX `fk_ktp_jenis_kelamin_idx` (`Jenis_Kelamin` ASC),
  INDEX `fk_ktp_status_kawin_idx` (`Status_Kawin` ASC),
  INDEX `fk_ktp_agama_idx` (`Agama` ASC),
  CONSTRAINT `fk_ktp_kecamatan`
    FOREIGN KEY (`Kecamatan`)
    REFERENCES `mdk3db`.`mt_kecamatan` (`cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ktp_status_kawin`
    FOREIGN KEY (`Status_Kawin`)
    REFERENCES `mdk3db`.`mt_status_kawin` (`cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ktp_jenis_kelamin`
    FOREIGN KEY (`Jenis_Kelamin`)
    REFERENCES `mdk3db`.`mt_jenis_kelamin` (`cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ktp_agama`
    FOREIGN KEY (`Agama`)
    REFERENCES `mdk3db`.`mt_agama` (`cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`dat_balance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`dat_balance` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`dat_balance` (
  `NIK` VARCHAR(16) NOT NULL,
  `balance` BIGINT(100) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  `updated_dt` DATE NOT NULL,
  `updated_by` VARCHAR(20) NOT NULL,
  `is_delete` VARCHAR(1) NOT NULL,
  `dat_ktp_NIK` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`NIK`),
  CONSTRAINT `fk_dat_balance_dat_ktp1`
    FOREIGN KEY (`NIK`)
    REFERENCES `mdk3db`.`dat_ktp` (`NIK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`sec_module`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`sec_module` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`sec_module` (
  `code` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `activityURL` VARCHAR(100) NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`log_financial_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`log_financial_history` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`log_financial_history` (
  `id` VARCHAR(50) NOT NULL,
  `moduleCode` VARCHAR(20) NOT NULL,
  `ref_no` VARCHAR(20) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `log_val` TEXT NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_log_financial_module_idx` (`moduleCode` ASC),
  CONSTRAINT `fk_log_financial_module`
    FOREIGN KEY (`moduleCode`)
    REFERENCES `mdk3db`.`sec_module` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`log_nonfinancial_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`log_nonfinancial_history` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`log_nonfinancial_history` (
  `id` VARCHAR(50) NOT NULL,
  `moduleCode` VARCHAR(20) NOT NULL,
  `refNo` VARCHAR(20) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `log_val` TEXT NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nonfinancial_module_idx` (`moduleCode` ASC),
  CONSTRAINT `fk_nonfinancial_module`
    FOREIGN KEY (`moduleCode`)
    REFERENCES `mdk3db`.`sec_module` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`log_user_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`log_user_history` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`log_user_history` (
  `id` VARCHAR(50) NOT NULL,
  `userId` VARCHAR(50) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`sec_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`sec_role` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`sec_role` (
  `code` VARCHAR(20) NOT NULL,
  `name` INT(100) NOT NULL,
  `description` TEXT NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`sec_role_module`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`sec_role_module` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`sec_role_module` (
  `id` VARCHAR(20) NOT NULL,
  `roleCode` VARCHAR(20) NOT NULL,
  `moduleCode` VARCHAR(20) NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sec_role_module_sec_module1_idx` (`moduleCode` ASC),
  INDEX `fk_sec_role_module_sec_role1_idx` (`roleCode` ASC),
  CONSTRAINT `fk_sec_role_module_sec_module1`
    FOREIGN KEY (`moduleCode`)
    REFERENCES `mdk3db`.`sec_module` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sec_role_module_sec_role1`
    FOREIGN KEY (`roleCode`)
    REFERENCES `mdk3db`.`sec_role` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`sec_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`sec_user` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`sec_user` (
  `id` VARCHAR(20) NOT NULL,
  `NIK` VARCHAR(16) NOT NULL,
  `is_login` CHAR(1) NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  `updated_dt` DATE NULL DEFAULT NULL,
  `updated_by` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`sec_user_pass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`sec_user_pass` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`sec_user_pass` (
  `userId` VARCHAR(20) NOT NULL,
  `passwd` VARCHAR(50) NOT NULL,
  `validUntil` DATE NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(20) NOT NULL,
  `updated_dt` DATE NOT NULL,
  `updated_by` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `fk_sec_user_and_pass`
    FOREIGN KEY (`userId`)
    REFERENCES `mdk3db`.`sec_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`sec_user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`sec_user_role` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`sec_user_role` (
  `id` VARCHAR(50) NOT NULL,
  `userId` VARCHAR(20) NOT NULL,
  `roleCode` VARCHAR(100) NOT NULL,
  `created_dt` DATE NOT NULL,
  `created_by` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sec_user_role_sec_user1_idx` (`userId` ASC),
  INDEX `fk_sec_user_role_role_idx` (`roleCode` ASC),
  CONSTRAINT `fk_sec_user_role_user`
    FOREIGN KEY (`userId`)
    REFERENCES `mdk3db`.`sec_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sec_user_role_role`
    FOREIGN KEY (`roleCode`)
    REFERENCES `mdk3db`.`sec_role` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`pem_partai`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`pem_partai` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`pem_partai` (
  `id` VARCHAR(50) NOT NULL,
  `nama` VARCHAR(100) NOT NULL,
  `logo` BLOB NOT NULL,
  `profile` TEXT NOT NULL,
  `visimisi` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`pem_anggota_partai`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`pem_anggota_partai` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`pem_anggota_partai` (
  `id` VARCHAR(50) NOT NULL,
  `id_partai` VARCHAR(50) NOT NULL,
  `NIK` VARCHAR(16) NOT NULL,
  `nama` VARCHAR(100) NOT NULL,
  `jabatan` VARCHAR(100) NOT NULL,
  `masa_jabatan` DATETIME NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  `foto` BLOB NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_anggota_partai_ktp_idx` (`NIK` ASC),
  INDEX `fk_anggota_partai_partai_idx` (`id_partai` ASC),
  CONSTRAINT `fk_anggota_partai_ktp`
    FOREIGN KEY (`NIK`)
    REFERENCES `mdk3db`.`dat_ktp` (`NIK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_anggota_partai_partai`
    FOREIGN KEY (`id_partai`)
    REFERENCES `mdk3db`.`pem_partai` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`pem_jadwal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`pem_jadwal` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`pem_jadwal` (
  `id` VARCHAR(50) NOT NULL,
  `nama` TEXT NOT NULL,
  `tanggal_pelaksanaan` DATE NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`pem_tahap_pilihan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`pem_tahap_pilihan` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`pem_tahap_pilihan` (
  `id` VARCHAR(50) NOT NULL,
  `id_jadwal_pemilu` VARCHAR(50) NOT NULL,
  `nama` TEXT NOT NULL,
  `tahap` INT(2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tahap_jadwal_idx` (`id_jadwal_pemilu` ASC),
  CONSTRAINT `fk_tahap_jadwal`
    FOREIGN KEY (`id_jadwal_pemilu`)
    REFERENCES `mdk3db`.`pem_jadwal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`pem_caleg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`pem_caleg` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`pem_caleg` (
  `id` VARCHAR(50) NOT NULL,
  `id_partai` VARCHAR(50) NOT NULL,
  `NIK` VARCHAR(50) NOT NULL,
  `id_jadwal_pemilu` VARCHAR(50) NOT NULL,
  `id_tahap` VARCHAR(50) NOT NULL,
  `id_anggota_pemilu` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_caleg_nik_idx` (`NIK` ASC),
  INDEX `fk_caleg_jadwal_idx` (`id_jadwal_pemilu` ASC),
  INDEX `fk_caleg_partai_idx` (`id_partai` ASC),
  INDEX `fk_caleg_tahap_idx` (`id_tahap` ASC),
  INDEX `fk_caleg_anggota_idx` (`id_anggota_pemilu` ASC),
  CONSTRAINT `fk_caleg_nik`
    FOREIGN KEY (`NIK`)
    REFERENCES `mdk3db`.`dat_ktp` (`NIK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caleg_jadwal`
    FOREIGN KEY (`id_jadwal_pemilu`)
    REFERENCES `mdk3db`.`pem_jadwal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caleg_partai`
    FOREIGN KEY (`id_partai`)
    REFERENCES `mdk3db`.`pem_partai` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caleg_tahap`
    FOREIGN KEY (`id_tahap`)
    REFERENCES `mdk3db`.`pem_tahap_pilihan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caleg_anggota`
    FOREIGN KEY (`id_anggota_pemilu`)
    REFERENCES `mdk3db`.`pem_anggota_partai` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`pem_profile_anggota`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`pem_profile_anggota` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`pem_profile_anggota` (
  `id` VARCHAR(50) NOT NULL,
  `pendidikan` VARCHAR(255) NOT NULL,
  `organisasi` VARCHAR(255) NOT NULL,
  `deskripsi` TEXT NOT NULL,
  `id_anggota` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_profile_anggota_idx` (`id_anggota` ASC),
  CONSTRAINT `fk_profile_anggota`
    FOREIGN KEY (`id_anggota`)
    REFERENCES `mdk3db`.`pem_anggota_partai` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`pem_suara`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`pem_suara` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`pem_suara` (
  `id` VARCHAR(50) NOT NULL,
  `caleg_pilihan` VARCHAR(50) NOT NULL,
  `id_pemilih` VARCHAR(50) NOT NULL,
  `id_tahap` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_suara_calegpilihan_idx` (`caleg_pilihan` ASC),
  INDEX `fk_suara_pemilih_idx` (`id_pemilih` ASC),
  INDEX `fk_suara_tahap_idx` (`id_tahap` ASC),
  CONSTRAINT `fk_suara_calegpilihan`
    FOREIGN KEY (`caleg_pilihan`)
    REFERENCES `mdk3db`.`pem_caleg` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suara_pemilih`
    FOREIGN KEY (`id_pemilih`)
    REFERENCES `mdk3db`.`dat_ktp` (`NIK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suara_tahap`
    FOREIGN KEY (`id_tahap`)
    REFERENCES `mdk3db`.`pem_tahap_pilihan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mdk3db`.`pem_voter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mdk3db`.`pem_voter` ;

CREATE TABLE IF NOT EXISTS `mdk3db`.`pem_voter` (
  `id` VARCHAR(50) NOT NULL,
  `id_jadwal_pemilu` VARCHAR(50) NOT NULL,
  `NIK` VARCHAR(50) NOT NULL,
  `tps_no` INT(10) NOT NULL,
  `lokasi` TEXT NOT NULL,
  `provinsi_tps` VARCHAR(255) NOT NULL,
  `kota_tps` VARCHAR(255) NOT NULL,
  `alamat_tps` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_voter_jadwal_idx` (`id_jadwal_pemilu` ASC),
  INDEX `fk_voter_nik_idx` (`NIK` ASC),
  CONSTRAINT `fk_voter_jadwal`
    FOREIGN KEY (`id_jadwal_pemilu`)
    REFERENCES `mdk3db`.`pem_jadwal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_nik`
    FOREIGN KEY (`NIK`)
    REFERENCES `mdk3db`.`dat_ktp` (`NIK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
