INSERT INTO `mt_agama` (`cd`, `name`, `keterangan`, `is_delete`, `created_dt`, `created_by`) VALUES
('budha', 'budha', 'budha', 'N', '2015-11-24 00:00:00', 'system'),
('hindu', 'hindu', 'hindu', 'N', '2015-11-24 00:00:00', 'system'),
('islam', 'islam', 'islam', 'N', '2015-11-24 00:00:00', 'system'),
('khatolik', 'khatolik', 'khatolik', 'N', '2015-11-24 00:00:00', 'system'),
('kristen', 'kristen', 'kristen', 'N', '2015-11-24 00:00:00', 'system');

INSERT INTO `mt_jenis_kelamin` (`cd`, `name`, `keterangan`, `is_delete`, `created_dt`, `created_by`) VALUES
('female', 'Perempuan', 'Perempuan', 'N', '2015-11-24 00:00:00', 'system'),
('male', 'Laki-Laki', 'Laki-Laki', 'N', '2015-11-24 00:00:00', 'system');

INSERT INTO `mt_status_kawin` (`cd`, `name`, `keterangan`, `is_delete`, `created_dt`, `created_by`) VALUES
('duda/janda', 'duda/janda', 'duda/janda', 'N', '2015-11-24 00:00:00', 'system'),
('lajang', 'lajang', 'lajang', 'N', '2015-11-24 00:00:00', 'system'),
('menikah', 'menikah', 'menikah', 'N', '2015-11-24 00:00:00', 'system');

INSERT INTO `sec_module` (`code`, `name`, `description`, `activityURL`, `created_dt`, `created_by`) VALUES
('keluhan_ktp', 'keluhan ktp', 'keluhan ktp', 'com.coko.mdk3.modules.keluhanktpActivity', '2015-11-24', 'system'),
('pemilu', 'pemilu', 'pemilu', 'com.coko.mdk3.modules.pemiluActivity', '2015-11-24', 'system'),
('pendingTask', 'Pending Task Module', 'Pending Task Module', 'com.coko.mdk3.modules.pendingTaskActivity', '2015-11-24', 'system'),
('userMaintance', 'userMaintance', 'userMaintance', 'com.coko.mdk3.modules.userMaintenanceAcitivy', '2015-11-24', 'system');

INSERT INTO `sec_role` (`code`, `name`, `description`, `created_dt`, `created_by`) VALUES
('admin', 'admin', 'admin', '2015-11-24', 'system'),
('staff', 'staff', 'staff', '2015-11-24', 'system'),
('user', 'user', 'user', '2015-11-24', 'system');

INSERT INTO `sec_role_module` (`id`, `roleCode`, `moduleCode`, `created_dt`, `created_by`) VALUES
('a1c71f58-92c8-11e5-b7ed-df75ad050f3c', 'admin', 'userMaintance', '2015-11-24', 'system'),
('a1c73402-92c8-11e5-b7ed-df75ad050f3c', 'staff', 'pendingTask', '2015-11-24', 'system'),
('afa099b0-92c8-11e5-b7ed-df75ad050f3c', 'user', 'keluhan_ktp', '2015-11-24', ''),
('afa0aae0-92c8-11e5-b7ed-df75ad050f3c', 'user', 'pemilu', '2015-11-24', 'system');

INSERT INTO `sec_user` (`id`, `NIK`, `is_login`, `created_dt`, `created_by`, `updated_dt`, `updated_by`) VALUES
('18aae9c6-92c7-11e5-b7ed-df75ad050f3c', '12345', 'N', '2015-11-24', 'system', NULL, NULL),
('1f337222-92c7-11e5-b7ed-df75ad050f3c', '123456', 'N', '2015-11-24', 'system', NULL, NULL);

INSERT INTO `sec_user_pass` (`userId`, `passwd`, `validUntil`, `created_dt`, `created_by`, `updated_dt`, `updated_by`) VALUES
('18aae9c6-92c7-11e5-b7ed-df75ad050f3c', 'password', '2016-12-31', '2015-11-24', 'system', '0000-00-00', ''),
('1f337222-92c7-11e5-b7ed-df75ad050f3c', 'password', '2016-12-31', '2015-11-24', 'system', '0000-00-00', '');

INSERT INTO `sec_user_role` (`id`, `userId`, `roleCode`, `created_dt`, `created_by`) VALUES
('1b7965e0-92d3-11e5-9742-5d0b21822c55', '18aae9c6-92c7-11e5-b7ed-df75ad050f3c', 'staff', '2015-11-25', 'system'),
('f745caa6-92d2-11e5-9742-5d0b21822c55', '1f337222-92c7-11e5-b7ed-df75ad050f3c', 'user', '2015-11-25', 'system'),
('f745f15c-92d2-11e5-9742-5d0b21822c55', '18aae9c6-92c7-11e5-b7ed-df75ad050f3c', 'admin', '2015-11-25', 'system');