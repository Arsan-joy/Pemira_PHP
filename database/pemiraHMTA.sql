-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2025 at 05:02 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pemira_hmta`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_type` enum('voter','admin') NOT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `activity` text NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_type`, `user_id`, `username`, `activity`, `ip_address`, `created_at`) VALUES
(1, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-27 01:15:14'),
(2, 'admin', 1, 'admin', 'Logout dari admin panel', '::1', '2025-10-27 01:21:29'),
(3, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-27 01:24:13'),
(4, 'admin', 1, 'admin', 'Mengupdate pemilih: Andi Prasetyo', '::1', '2025-10-27 01:36:01'),
(5, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-10-27 01:36:09'),
(6, 'voter', 1, '2021001', 'Logout', '::1', '2025-10-27 02:02:52'),
(7, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-27 03:07:08'),
(8, 'admin', 1, 'admin', 'Mengupdate pemilih: Andi Prasetyo', '::1', '2025-10-27 03:07:30'),
(9, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-10-27 03:08:02'),
(10, 'voter', 1, '2021001', 'Logout', '::1', '2025-10-27 03:08:51'),
(11, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-27 03:10:42'),
(12, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-10-27 09:53:04'),
(13, 'voter', 1, '2021001', 'Melakukan voting - Kahim: Ahmad Fauzi Nugroho, Senat: Hendra Wijaya', '::1', '2025-10-27 09:53:45'),
(14, 'voter', 1, '2021001', 'Logout', '::1', '2025-10-27 09:53:52'),
(15, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-27 09:54:02'),
(16, 'admin', 1, 'admin', 'Logout dari admin panel', '::1', '2025-10-27 09:54:51'),
(17, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-10-27 09:55:01'),
(18, 'voter', 1, '2021001', 'Logout', '::1', '2025-10-27 09:55:46'),
(19, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-27 09:56:05'),
(20, 'admin', 1, 'admin', 'Mengupdate pemilih: Budi Setiawan', '::1', '2025-10-27 09:56:48'),
(21, 'voter', 2, '123370095', 'Login berhasil', '::1', '2025-10-27 09:57:12'),
(22, 'admin', 1, 'admin', 'Reset status voting: Andi Prasetyo', '::1', '2025-10-27 09:59:10'),
(23, 'voter', 2, '123370095', 'Melakukan voting - Kahim: Siti Rahma Dewi, Senat: Dimas Prasetyo', '::1', '2025-10-27 09:59:51'),
(24, 'voter', 2, '123370095', 'Logout', '::1', '2025-10-27 10:02:23'),
(25, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-27 10:08:57'),
(26, 'admin', 1, 'admin', 'Reset status voting: Budi Setiawan', '::1', '2025-10-27 10:09:59'),
(27, 'admin', 1, 'admin', 'Menambah pemilih: Vawaz Zuhri Wavi', '::1', '2025-10-27 10:14:22'),
(28, 'voter', 6, '123370121', 'Login berhasil', '::1', '2025-10-27 10:14:56'),
(29, 'voter', 6, '123370121', 'Melakukan voting - Kahim: Ahmad Fauzi Nugroho, Senat: Citra Wulandari', '::1', '2025-10-27 10:15:27'),
(30, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-30 06:26:29'),
(31, 'admin', 1, 'admin', 'Logout dari admin panel', '::1', '2025-10-30 06:46:08'),
(32, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-30 06:46:15'),
(33, 'admin', 1, 'admin', 'Reset status voting: Vawaz Zuhri Wavi', '::1', '2025-10-30 08:20:35'),
(34, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-10-30 14:02:57'),
(35, 'voter', 1, '2021001', 'Melakukan voting - Kahim: Ahmad Fauzi Nugroho, Senat: Fajar Ramadhan', '::1', '2025-10-30 14:03:22'),
(36, 'voter', 1, '2021001', 'Logout', '::1', '2025-10-30 14:03:29'),
(37, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-30 14:03:41'),
(38, 'admin', 1, 'admin', 'Logout dari admin panel', '::1', '2025-10-30 14:06:33'),
(39, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-31 03:50:33'),
(40, 'admin', 1, 'admin', 'Reset status voting: Andi Prasetyo', '::1', '2025-10-31 03:50:55'),
(41, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-10-31 08:19:12'),
(42, 'voter', 1, '2021001', 'Logout', '::1', '2025-10-31 08:19:26'),
(43, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-10-31 08:19:37'),
(44, 'admin', 1, 'admin', 'Logout dari admin panel', '::1', '2025-10-31 08:19:47'),
(45, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-11-01 09:56:59'),
(46, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-11-02 02:24:26'),
(47, 'voter', 1, '2021001', 'Melakukan voting - Kahim: Ahmad Fauzi Nugroho, Senat: Fajar Ramadhan', '::1', '2025-11-02 02:25:05'),
(48, 'voter', 1, '2021001', 'Logout', '::1', '2025-11-02 02:25:12'),
(49, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-11-02 02:25:29'),
(50, 'admin', 1, 'admin', 'Reset status voting: Andi Prasetyo', '::1', '2025-11-02 03:15:42'),
(51, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-11-09 03:04:53'),
(52, 'admin', 1, 'admin', 'Logout dari admin panel', '::1', '2025-11-09 03:05:25'),
(53, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-11-09 03:05:44'),
(54, 'voter', 1, '2021001', 'Melakukan voting - Kahim: Siti Rahma Dewi, Senat: Citra Wulandari', '::1', '2025-11-09 03:06:14'),
(55, 'voter', 1, '2021001', 'Logout', '::1', '2025-11-09 03:06:25'),
(56, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-11-09 03:06:37'),
(57, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-11-09 09:21:00'),
(58, 'voter', 1, '2021001', 'Logout', '::1', '2025-11-09 09:21:10'),
(59, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-11-09 09:21:23'),
(60, 'admin', 1, 'admin', 'Reset status voting: Andi Prasetyo', '::1', '2025-11-09 09:21:42'),
(61, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-11-09 09:21:57'),
(62, 'voter', 1, '2021001', 'Melakukan voting - Kahim: Ahmad Fauzi Nugroho, Senat: Citra Wulandari', '::1', '2025-11-09 09:22:41'),
(63, 'admin', 1, 'admin', 'Mengupdate kandidat: Willy Alvares', '::1', '2025-11-09 09:24:37'),
(64, 'admin', 1, 'admin', 'Mengupdate kandidat: Abdurrahman Zidan', '::1', '2025-11-09 09:25:03'),
(65, 'admin', 1, 'admin', 'Mengupdate kandidat: Willy Alvares', '::1', '2025-11-09 09:25:12'),
(66, 'admin', 1, 'admin', 'Reset status voting: Andi Prasetyo', '::1', '2025-11-09 09:25:27'),
(67, 'admin', 1, 'admin', 'Reset status voting: Andi Prasetyo', '::1', '2025-11-09 09:27:06'),
(68, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-11-10 10:04:20'),
(69, 'voter', 1, '2021001', 'Logout', '::1', '2025-11-10 10:04:32'),
(70, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-11-10 10:04:40'),
(71, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-11-14 03:41:03'),
(72, 'voter', 1, '2021001', 'Logout', '::1', '2025-11-14 03:43:14'),
(73, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-11-14 03:45:11'),
(74, 'admin', 1, 'admin', 'Menghapus pemilih: Andi Prasetyo', '::1', '2025-11-14 14:30:32'),
(75, 'admin', 1, 'admin', 'Menghapus pemilih: Budi Setiawan', '::1', '2025-11-14 14:30:34'),
(76, 'admin', 1, 'admin', 'Menghapus pemilih: Citra Dewi', '::1', '2025-11-14 14:30:36'),
(77, 'admin', 1, 'admin', 'Menghapus pemilih: Dian Kusuma', '::1', '2025-11-14 14:30:37'),
(78, 'admin', 1, 'admin', 'Menghapus pemilih: Eko Prasetyo', '::1', '2025-11-14 14:30:39'),
(79, 'admin', 1, 'admin', 'Menghapus pemilih: Vawaz Zuhri Wavi', '::1', '2025-11-14 14:30:41'),
(80, 'admin', 1, 'admin', 'Logout dari admin panel', '::1', '2025-11-14 14:35:14'),
(81, 'admin', 1, 'admin', 'Login berhasil', '::1', '2025-11-14 14:35:20'),
(82, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 14:51:41'),
(83, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 14:52:18'),
(84, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 14:58:21'),
(85, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 14:58:43'),
(86, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 14:59:39'),
(87, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 15:02:08'),
(88, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 15:06:02'),
(89, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 15:06:06'),
(90, 'admin', 1, 'admin', 'Upload CSV voters - 0 ditambahkan, 994 terlewati', '::1', '2025-11-14 15:06:17'),
(91, 'admin', 1, 'admin', 'Upload CSV voters - 478 added, 0 updated, 0 skipped', '::1', '2025-11-14 15:21:23');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `nama`, `created_at`) VALUES
(1, 'admin', '$2y$10$gdJ073riI.qxIYtAqys7k.Rq4.rEVSCVl30IvhK5g9J6B.Zn6CKbW', 'Administrator Pemira', '2025-10-26 15:49:36');

-- --------------------------------------------------------

--
-- Table structure for table `candidates`
--

CREATE TABLE `candidates` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `foto` varchar(255) DEFAULT 'default.jpg',
  `posisi` enum('kahim','senat') NOT NULL,
  `visi_misi` text NOT NULL,
  `grand_design` text NOT NULL,
  `nomor_urut` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `candidates`
--

INSERT INTO `candidates` (`id`, `nama`, `foto`, `posisi`, `visi_misi`, `grand_design`, `nomor_urut`, `created_at`) VALUES
(1, 'Willy Alvares', 'candidate1.jpg', 'kahim', 'VISI: Mewujudkan HMTA yang solid, progresif, dan berdaya saing tinggi dalam mengembangkan potensi mahasiswa Teknik Pertambangan.\r\n\r\nMISI:\r\n1. Meningkatkan kualitas SDM melalui pelatihan dan workshop\r\n2. Membangun networking dengan industri pertambangan\r\n3. Mengoptimalkan fasilitas dan sarana organisasi\r\n4. Menciptakan program kerja yang inovatif dan berkelanjutan', 'GRAND DESIGN:\r\n1. PENGEMBANGAN SDM: Program training, sertifikasi, dan soft skill development\r\n2. KERJASAMA INDUSTRI: MoU dengan perusahaan tambang, site visit, dan job fair\r\n3. KESEJAHTERAAN ANGGOTA: Beasiswa, bantuan akademik, dan pengembangan karir\r\n4. DIGITALISASI: Platform informasi digital dan sistem administrasi modern\r\n5. PRESTASI: Kompetisi nasional dan internasional di bidang pertambangan', 1, '2025-10-26 15:49:36'),
(2, 'Abdurrahman Zidan', 'candidate2.jpg', 'kahim', 'VISI: Membangun HMTA yang inklusif, inovatif, dan berintegritas untuk kemajuan mahasiswa Teknik Pertambangan.\r\n\r\nMISI:\r\n1. Memperkuat solidaritas dan kekeluargaan antar anggota\r\n2. Mengembangkan riset dan inovasi di bidang pertambangan\r\n3. Meningkatkan partisipasi mahasiswa dalam kegiatan organisasi\r\n4. Membangun citra positif HIMATEP di lingkungan kampus dan masyarakat', 'GRAND DESIGN:\r\n1. KADERISASI: Sistem mentoring dan leadership training berkelanjutan\r\n2. RISET & INOVASI: Penelitian, jurnal ilmiah, dan paten di bidang pertambangan\r\n3. PEMBERDAYAAN: Program entrepreneurship dan UMKM untuk mahasiswa\r\n4. LINGKUNGAN: Kampanye sustainable mining dan green campus\r\n5. KOMUNIKASI: Media center, publikasi, dan branding yang kuat', 2, '2025-10-26 15:49:36'),
(3, 'Budi Santoso', 'senator1.jpg', 'senat', 'VISI: Menjadi Senator yang aspiratif dan responsif terhadap kebutuhan mahasiswa.\n\nMISI:\n1. Menyalurkan aspirasi mahasiswa ke pimpinan organisasi\n2. Mengawasi jalannya program kerja HIMATEP\n3. Membangun transparansi dan akuntabilitas organisasi', 'GRAND DESIGN:\n1. ASPIRASI: Kotak saran digital dan forum diskusi rutin\n2. PENGAWASAN: Evaluasi berkala program kerja dan keuangan\n3. TRANSPARANSI: Publikasi laporan pertanggungjawaban berkala', 1, '2025-10-26 15:49:36'),
(4, 'Citra Wulandari', 'senator2.jpg', 'senat', 'VISI: Menghadirkan senat yang proaktif dalam memperjuangkan hak dan kesejahteraan mahasiswa.\n\nMISI:\n1. Menjadi jembatan komunikasi antara mahasiswa dan pengurus\n2. Mengadvokasi kebijakan yang pro-mahasiswa\n3. Mendorong partisipasi aktif mahasiswa dalam organisasi', 'GRAND DESIGN:\n1. ADVOKASI: Program konsultasi dan pendampingan mahasiswa\n2. PARTISIPASI: Inisiatif melibatkan mahasiswa dalam setiap kegiatan\n3. MONITORING: Sistem pelaporan dan feedback yang efektif', 2, '2025-10-26 15:49:36'),
(5, 'Dimas Prasetyo', 'senator3.jpg', 'senat', 'VISI: Senat yang kritis dan konstruktif untuk kemajuan HIMATEP.\n\nMISI:\n1. Melakukan kontrol terhadap kebijakan organisasi\n2. Memberikan masukan strategis untuk pengembangan HIMATEP\n3. Menjaga check and balance dalam organisasi', 'GRAND DESIGN:\n1. KONTROL: Audit program dan anggaran secara berkala\n2. STRATEGIS: Think tank untuk perencanaan jangka panjang\n3. BALANCE: Mediasi konflik dan problem solving', 3, '2025-10-26 15:49:36'),
(6, 'Eka Putri Lestari', 'senator4.jpg', 'senat', 'VISI: Mewujudkan senat yang peduli dan berpihak pada mahasiswa.\n\nMISI:\n1. Menampung dan memperjuangkan aspirasi mahasiswa\n2. Mengawal implementasi program kerja yang bermanfaat\n3. Memastikan transparansi pengelolaan organisasi', 'GRAND DESIGN:\n1. PEDULI: Program visit dan pendekatan personal ke mahasiswa\n2. PENGAWALAN: Task force untuk monitoring implementasi program\n3. TRANSPARANSI: Dashboard publik untuk info organisasi', 4, '2025-10-26 15:49:36'),
(7, 'Fajar Ramadhan', 'senator5.jpg', 'senat', 'VISI: Senat yang inovatif dan solutif dalam mengatasi permasalahan mahasiswa.\n\nMISI:\n1. Menciptakan solusi kreatif untuk permasalahan mahasiswa\n2. Mendorong inovasi dalam setiap program kerja\n3. Membangun networking yang luas untuk kepentingan mahasiswa', 'GRAND DESIGN:\n1. INOVASI: Hackathon dan kompetisi ide untuk mahasiswa\n2. SOLUSI: Problem solving center untuk mahasiswa\n3. NETWORKING: Partnership dengan organisasi lain dan alumni', 5, '2025-10-26 15:49:36'),
(8, 'Gita Maharani', 'senator6.jpg', 'senat', 'VISI: Menghadirkan senat yang aktif dan responsif terhadap dinamika mahasiswa.\n\nMISI:\n1. Merespons cepat setiap aspirasi dan keluhan mahasiswa\n2. Mengawasi kinerja pengurus dengan objektif\n3. Membangun kultur organisasi yang sehat dan produktif', 'GRAND DESIGN:\n1. RESPONSIF: Hotline dan customer service untuk mahasiswa\n2. OBJEKTIF: Standar penilaian kinerja yang terukur\n3. KULTUR: Team building dan capacity building rutin', 6, '2025-10-26 15:49:36'),
(9, 'Hendra Wijaya', 'senator7.jpg', 'senat', 'VISI: Senat yang amanah dan professional dalam menjalankan tugas legislatif.\n\nMISI:\n1. Menjalankan fungsi legislasi dengan penuh tanggung jawab\n2. Mengawasi pelaksanaan AD/ART organisasi\n3. Menjaga integritas dan kredibilitas organisasi', 'GRAND DESIGN:\n1. LEGISLASI: Penyusunan peraturan organisasi yang modern\n2. PENGAWASAN: Compliance check terhadap AD/ART\n3. INTEGRITAS: Code of conduct dan ethics committee', 7, '2025-10-26 15:49:36');

-- --------------------------------------------------------

--
-- Table structure for table `voters`
--

CREATE TABLE `voters` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `nim` varchar(20) NOT NULL,
  `prodi` varchar(100) DEFAULT 'Teknik Pertambangan',
  `has_voted` tinyint(1) DEFAULT 0,
  `voted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voters`
--

INSERT INTO `voters` (`id`, `username`, `password`, `nama_lengkap`, `nim`, `prodi`, `has_voted`, `voted_at`, `created_at`) VALUES
(9, '119370004', '$2y$10$.v3hwl1A3Kb/PYeqWvzXyuxwLDAs2WxsYN9niX4635iKBYMpMef8i', 'Fadli Nur Alfariezky', '119370004', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:19'),
(10, '119370005', '$2y$10$UFdlldEZpYaCgzqRpg.paOiuJvJoAl8/v.nKwk5vWrbMjOFHy7SRO', 'MUHAMMAD RAMADHAN', '119370005', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:19'),
(11, '119370016', '$2y$10$ZMInRewk85sH.3/1hbgzz.k7wsLh.Jx1SUzBSvkakXZxyI5nRjl3i', 'M. Naufal Aziz Saputra', '119370016', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:19'),
(12, '119370037', '$2y$10$DGGAfHpdnDk/1cc/S6MmtOKctdqjI2oTsajk.DHcSLuAbYJ/kmnGu', 'Adrian', '119370037', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(13, '119370038', '$2y$10$xoWTtvV1tx0z4gYy4vh7o.5mgZ9pDFNoZ89Uo9JXWEaOO7egw4aWa', 'Danar Pradopo', '119370038', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(14, '119370041', '$2y$10$16Yp0ksYBG6xvcNsstpPue/JdqV6JZOTPsRPIxihu9eOYD2I92kiW', 'Aditya Ramadhan', '119370041', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(15, '119370058', '$2y$10$pKOJgMtEqbsMwhew4qWpYuvImVO3Oit.nSfITQ7XOd9cI4M2Nresa', 'SARWAN HERLANGGA', '119370058', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(16, '119370068', '$2y$10$vFOVAABUblMRUAKFw8Me2e/6pLD3ylCT6CaRGB3i6S.9TLdjUjZQ6', 'NURIYAH SAPUTRI', '119370068', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(17, '119370079', '$2y$10$Yf/Urivjw1byZXGSQtB3K.28QfqL8zku79ql0WK7ANI00arTL5JqW', 'M IKHSAN PRATAMA', '119370079', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(18, '119370090', '$2y$10$0wYmDlARG5wl0d47ibUD2.e6hNf6llOr647pXRJRFw88ykmci9WqS', 'SAHRUL ANWAR NASUTION', '119370090', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(19, '119370093', '$2y$10$or.VhfK.sLvH9WSW3a1/v.rm/uL3b4QiZQYV6f5vCEgYofrEgxOdW', 'Ido Ramdani', '119370093', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(20, '119370105', '$2y$10$pB9EGOAYKDsHqppmsfz9nuWPpF1aoEBqI1zAnhJxD.6U25QITNf9i', 'Awithio Nur Deriswansyah', '119370105', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:20'),
(21, '119370122', '$2y$10$jfzNtC1/lI6ed8zyzouVzuPEvteoGtqDONTDFpdq2HgfccrPN32Me', 'Satria prayoga', '119370122', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:21'),
(22, '120370005', '$2y$10$a.5EkPLjrK9a1Wmy3o9FFeu7ZCFX0pp67Mmhw3jYxe/.iR2eyZ9KS', 'Daniel Gomostua Sitohang', '120370005', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:21'),
(23, '120370013', '$2y$10$.4ofslXHDOsLc09jVLEHBuueXhCSzp3tpX2Psd20ttPHKWJx3JNNy', 'Hema Efrina Sihotang', '120370013', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:21'),
(24, '120370017', '$2y$10$scARb2KWAlGKeskzO8.pk.Sg66yHCAwwnIUy.JHKOBVFG2uLtME2a', 'Jonatan Parningotan Lumbantoruan', '120370017', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:21'),
(25, '120370025', '$2y$10$TV.Ta.Ue9pHdWQXiQUo57.t5TQHVJncCdBSVr3/uhDITsuIt.iKnC', 'Rama Ardi Wibowo', '120370025', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:21'),
(26, '120370029', '$2y$10$LNF/EAPQwDTpevMk11z7u.cRlA4JcdKe01eq2vTmIvmcrHnkOq7WK', 'Santa Maria Pandiangan', '120370029', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:21'),
(27, '120370031', '$2y$10$GUND6GJoYhjVJp1ZKbwGsOrFOjUAkmDBqUh5FV4fUWvjXClART25u', 'Mardiana', '120370031', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:22'),
(28, '120370032', '$2y$10$7zHmUKY4/ztJFctdN3VKeOvDfkEMHePR9j6RhckJ/c.xQn0xgA.7e', 'Sesilia Yuan Petriksia', '120370032', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:22'),
(29, '120370036', '$2y$10$itGBtByF9Gn25gcRCJM/zOFcnTXya7upv/7wnDNA1LbpkASi/CLfC', 'Ambarwati Yuweningtiyas Arum', '120370036', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:22'),
(30, '120370041', '$2y$10$0DGqib4.Q2l6Mn3uMlqbH.M9TR0XUUo.L8yiZxWGhrmQ67XXFAZm2', 'Tegar Setia Rahman', '120370041', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:22'),
(31, '120370048', '$2y$10$mzsjFuq35Ypa/.kZP2QuQ.fAecsvf2yQXmJRFKgmsvDg8GTEFt0RW', 'Muhammad Muklis Harahap', '120370048', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:22'),
(32, '120370060', '$2y$10$MNFH8w2ZXIHVezcLapVM5unOk1jir6FvqyfP.Z.IYJffKvLFr9zXy', 'Gunawan', '120370060', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:22'),
(33, '120370064', '$2y$10$8anC3jJbUHjjyWZUSAKteumbB.unmkj37Vu7j25bNAGzgKC2e3SQm', 'Duma Rotua Banjarnahor', '120370064', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:22'),
(34, '120370066', '$2y$10$rqtMVdhlv03VfCyZiIF6i.i/eMKeWSPoYs3iyQgA0q3L9LtLrwkiG', 'Lidya Veronika Nababan', '120370066', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:22'),
(35, '120370073', '$2y$10$vH9OA8YvNo5zYv6iQ.kV6.MGvF8WdFTF0fmAaOuZG1mKKQFxjYEdC', 'Ilham Hidayatullah', '120370073', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:23'),
(36, '120370074', '$2y$10$MvfW9/06HUmVAp4h7Nt7uuZAOo1V25Hk5TuTaKdAp7vDCW5DvN976', 'Reni', '120370074', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:23'),
(37, '120370077', '$2y$10$x3XFLKfbIbsROkhQIqY3D.gXIAxb5SSYwlkv8LrRrbLprQOTaZXPe', 'Abou Mosallem Al Ahly Herliana', '120370077', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:23'),
(38, '120370082', '$2y$10$gTJXfAEnmeLf15/YsR35Y.ToO/W3svKoplu7fNmB4fkqPFqLrZWWi', 'AHMAD AL BARNAS', '120370082', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:23'),
(39, '120370083', '$2y$10$29LWv5jwm.N3bnD4wokptuG64nZ6lHgx9LqzmGhUMcGf9W6fdZMYy', 'Hammam An Nashir', '120370083', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:23'),
(40, '120370087', '$2y$10$m2JQsmF9UGAJD8Kj5oWNH.KAkh4n.8vY5fDeb9daIm/UnjYRIjaRa', 'Abdul Jabbar M.', '120370087', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:23'),
(41, '120370090', '$2y$10$IXLuhXfe1ZtR/eaAGFd.Iu45OWb71NZRk8QlTQ7BM2/.AiTlRsRdu', 'ARIQ RAFLIANSYAH', '120370090', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:24'),
(42, '120370093', '$2y$10$STQNoH9aFPL15tVTQsDp/uK11.fn42NAiDTcWvnyQo39fvcPdWELC', 'M. RAIHAN S.', '120370093', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:24'),
(43, '120370097', '$2y$10$/j.oMru.7UzzbOZkeh6sb.0k4qH7Z8yZ5DrjeEemcf5sEWY/ydFQ6', 'Aji Nurcahya', '120370097', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:24'),
(44, '120370098', '$2y$10$lcgNBhyXglHALy.YlTvuZu0X95cb.e4E4ovrs3TB0gv09WWV/DnEO', 'AJENG WAHYU NINGSIH', '120370098', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:24'),
(45, '120370108', '$2y$10$1.HvJQ17pMBqa5xQBnQiX.0h8E/8SBT/XpVEPW0.iiVVmXehEIkDi', 'Yobel Raph Tambunan', '120370108', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:24'),
(46, '120370112', '$2y$10$rMwL.XcpvG9oNlQXY5MRm.zveiXMAZYUB1wwjlNwrUtDTqVgKLdta', 'DINO SATRIO', '120370112', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:24'),
(47, '120370114', '$2y$10$2d/53tpl3mcSAAenQMZ7UO7GVzqlUv/HNEhzb7uPO1mhQ9XpltFcq', 'ANANDA TEGAR IRAWAN', '120370114', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:24'),
(48, '120370121', '$2y$10$P6s3mlqQ6/nQlbPh2bgPluH7YWh38Dx7aW5ar7ZqdOn.6Kq2XKB1G', 'NOVID RONALJI', '120370121', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:24'),
(49, '120370129', '$2y$10$B8I.YI262mA.R3TR5t727esXwqi2uZDV66w7fmCAmrewSCeaZjm6G', 'AR RAAFI ZHUHRONI AHADA', '120370129', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:25'),
(50, '120370132', '$2y$10$uN2dYM4GxHSesNmxugcUcOoOVXWA2mUzQA.CDl5d9kmtbbRRjjsP6', 'Julius Steffanus', '120370132', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:25'),
(51, '120370135', '$2y$10$3jMrd2PyGm2f1IbUiIf3Le6CRTRi68.rvGnSShkMAqh2R.LvXhqiO', 'M.Refa Antariksawan', '120370135', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:25'),
(52, '120370137', '$2y$10$BkNq2JibLwf9/E07EpcQ2uLST9Du3TJSLEuaJT2fVI7JdyteW6BZ6', 'ADAM FEBRIAN HAJI', '120370137', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:25'),
(53, '120370147', '$2y$10$jCKohObHMxqyC.BGKKNqculMyABYY7kPgyp1zhfwzw6PTs7/l1gWm', 'DANIEL MANTEREJAN DONGORAN', '120370147', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:25'),
(54, '120370150', '$2y$10$NJWS5hS5IhZUdzFs5Ulc3e/NdgjmdLzj0g4d/6As0Q6zoUaoRySa2', 'CHRIS ELDAVID LASE', '120370150', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:25'),
(55, '120370151', '$2y$10$tgYQCad.jfddguXXWbRKXu8YNU0k0O7jwms65swqMjtoQ5Kbw0X76', 'VALENTINO DEFFTANAEL', '120370151', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:25'),
(56, '120370154', '$2y$10$Rt/P8v0erWTBwNrYkuJyq.klFDTJiQ1cMpJgZWDiXgN4mF9K3kVNa', 'DWIKO RIFKI NANDA', '120370154', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:25'),
(57, '120370161', '$2y$10$T.nREZ0h9klSplldenqfoe/tgiKRCSguUCjIChobicEKxeO5vpfHy', 'ANANTA ALFILLAH AKBAR', '120370161', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:26'),
(58, '120370162', '$2y$10$w2a2nEnUOCgvT.cO3Ffl3uo6kkmVwEdIr1pJY35P0bULO/fsKah1.', 'Muhammad Reyhan Syachdewa Alghiffari', '120370162', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:26'),
(59, '120370168', '$2y$10$UeO2aD.CyrM02e4j9/JK2ORnWjKQrHGAH8kO45LKT.A7cfCVAvHxK', 'Joshua Geraldin Silalahi', '120370168', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:26'),
(60, '120370169', '$2y$10$pLnRiPsMhcZGJh3t5zxMGu9R/Kmic/JKwpfesujoytEifh6ElIOga', 'CINDY CLARITA SIREGAR', '120370169', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:26'),
(61, '120370171', '$2y$10$UZU4HnqrPSXcFK0fi3hyH.nUC.NMAx9KznUHxT2W/Hb.sY8p3x.Qa', 'DELFI YANI TONDANG', '120370171', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:26'),
(62, '120370172', '$2y$10$6DtWqW0VKdAXglmzBdT4TeLlLi9XyXhytwWjJG/49w4SlgT8hmpXy', 'ARIAN DELE BONDAR', '120370172', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:26'),
(63, '120370173', '$2y$10$l6KkMFZ9KnS4r9bXk.CApueSFDA8JCB6W8xbTMAJ6U/51FUTWBO/W', 'MUHAMMAD MOZA FAQIH ANDALI', '120370173', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:26'),
(64, '120370175', '$2y$10$1Bnzl8zqSQf1TmxTwHwkDestZchzCkMVgFHf8ulEPo0pxuoN3KQ3S', 'PINKAN NABILA SAFITRI', '120370175', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:26'),
(65, '120370177', '$2y$10$.I.yaB26C7EIEvK.2QsndewUVsQQSEsd80IJlUbo8ao8rKZ8sJ1We', 'RAUL YODI SYAHPUTRA', '120370177', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:27'),
(66, '120370186', '$2y$10$/lrmKyiVDDilhz3K9TBuWern/3CifZ14JJAaA0Nl6FQ2YLFxq8FBe', 'MARWIN AZARYA', '120370186', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:27'),
(67, '120370190', '$2y$10$RcRRNcQtAwGBNMJqgfjvbecENnOY8qoDgVpyBMcaP6IAGqSYUgwly', 'MUHAMMAD ALAN ARRAFI', '120370190', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:27'),
(68, '120370191', '$2y$10$h26tu.SNmtr//uBXZBdWMO4b6n2sO0pLUoSetgxEtSxuJeKE6l9k2', 'M.RIZKY ISMALIANSYAH', '120370191', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:27'),
(69, '121370001', '$2y$10$TEMjYHZqJAA2y2iD1zMc0ua3ThS.SszUsxvCTiD4h8r486aN8bc4C', 'Kholida Sahlaisa', '121370001', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:27'),
(70, '121370003', '$2y$10$djssIBx.ABgJyRXgef5dxeTOJCJXAIkSwF/YEe3k9j.VZTBECObnK', 'Richat Ricardo Banjarnahor', '121370003', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:27'),
(71, '121370004', '$2y$10$acWNlpyiuOWH7dFs3u/8MuVOyoC7TtJJdthDdI1z9dB4LoMk/8efe', 'Immanuel Guluan Naibaho', '121370004', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:27'),
(72, '121370006', '$2y$10$2cJk35R7Yg2kJmt0M23L.uEJntT0x6f5RgGKg08zZqpKht/.w7kQa', 'Reza Aulia Sitompul', '121370006', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:27'),
(73, '121370007', '$2y$10$iuJ8E9mf1LVKbdbyydWX3.zAmCpwFASKGne1nYHVKNOIZHXsFzwE6', 'Judan Akbarialda', '121370007', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:28'),
(74, '121370008', '$2y$10$PZc1k9exMacDNT3W5p6bJeNPGwa4wXHBcO8Gif.XtIf0G.xOgMUVC', 'Ahmad Fadli', '121370008', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:28'),
(75, '121370009', '$2y$10$8YcPf9cWILVUs0ZfINHWreujOnoS/tFmfWoOidnCZIaW/jT9L7qJ2', 'Dola Monika Sianturi', '121370009', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:28'),
(76, '121370010', '$2y$10$xXGWQMk5iozR6utqsGhPx.5eIuY4/qIXNCTAZlIWD/xpuBNP0mpCq', 'Robby Poraga', '121370010', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:28'),
(77, '121370011', '$2y$10$ksaYeNF6o/icqbTcjsk.leeCWK1.i2kpi0BieeWse7j/Tx.cjsVVq', 'Kelvin Daniel Sitanggang', '121370011', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:28'),
(78, '121370013', '$2y$10$PeamFTMrYnqrFwopR3YzseXpw6VzeHWo.1cS44GaXC9CJs/L.qc.2', 'Destria Enjelika', '121370013', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:28'),
(79, '121370014', '$2y$10$6b0m3.NX8wE7bkVBUeVEqeY5pxhpRNbORUkvfpuC7HY/LC/DkaCo.', 'Citra Puspita Sari', '121370014', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:28'),
(80, '121370015', '$2y$10$WvDPJhkdLTze0BHcocG1hOh8V/iDB9rwfIkmDsD1VQ3IegIJHCXKK', 'Jeremia Hasoloan Mangunsong', '121370015', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:29'),
(81, '121370016', '$2y$10$d5Ae34jw2Ezn8YeLSQaVOOMJxgeFRWSgJCGb8J1jJ5gFBi392tC9q', 'Dicky Ardian Tarigan', '121370016', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:29'),
(82, '121370018', '$2y$10$2DVdrDzS.iF/VGi32/dw9.9C5RZP/5P/Q3u72RZNP8bviPTmO2Wj6', 'Sri Ayu Puspito Wati', '121370018', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:29'),
(83, '121370019', '$2y$10$.17wE5PQio9Ya7nacXhHu..MqZrEw3TyPmKCXe1jAaP8TtC7O3UCO', 'Yoan Azari', '121370019', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:29'),
(84, '121370020', '$2y$10$2HMzZNkIREU50nO7g9qUq.WipIb0azxsIwMNTvF5QU170pFcEA1LG', 'Immanuel Munthe', '121370020', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:29'),
(85, '121370023', '$2y$10$vu5sZH5nC7kQgivetXrOy.86ZlKemfcaB388omNP6V6T5wLYDoFs2', 'M. Izzan Raf`A Rizkyanto', '121370023', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:29'),
(86, '121370026', '$2y$10$yRv.NHoXPA1UbiqDtp801uuhVyEil4xZfaraspe.0YEmkUJ3ONtwC', 'Ikko Ahmad Zahwawi', '121370026', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:29'),
(87, '121370027', '$2y$10$FTQLBpZ54IsBVkrpZX/xRuLlFagz1vJOmz0zLb0yLf1LEtro8t5bS', 'Najwan Putra Ramadhan', '121370027', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:29'),
(88, '121370029', '$2y$10$X8f6HGTMg1CI6JgUtwfFS.MUA7TPfCQpNggXvuuFTVfa6WwpRuONq', 'Elda Amelia', '121370029', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:30'),
(89, '121370030', '$2y$10$565/IB/TRLOxEuGQsflUmOIsXrX0PWg/5ZGITA7RPwneV3MIkXbE6', 'Bonatua Sihombing', '121370030', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:30'),
(90, '121370031', '$2y$10$48HmvF/.YhXaU2BY5T6PEemEnei0qrQe53S/zrcPspQgOpEBL6UoG', 'Rizky Nofadillah', '121370031', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:30'),
(91, '121370032', '$2y$10$Xw.RUbt41U49WvMdQg.Mi./QCAvFoPvw1dVKRmXnysfKW7s176FOW', 'Taruna Bayu Aji', '121370032', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:30'),
(92, '121370033', '$2y$10$MzK9j7bDJsW0uk6hWnW5MO6Mo70RCWL0IvzD5j94rvRaO7LP3zTcC', 'Rivian Sandy Anarqi', '121370033', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:30'),
(93, '121370035', '$2y$10$4VdtBUXUcveUDkYPvSg1bulL0SeinXhgbG.fnADRLfLhfdTp6ON4C', 'Ryu Samudra', '121370035', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:30'),
(94, '121370037', '$2y$10$knGhkbPEYRt2dh9wffY2seGmfKIu0tblCvEfeC19zpsjIL3YiYUWe', 'Muhammad Hadi Wicaksono', '121370037', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:30'),
(95, '121370038', '$2y$10$QjPnrt3AJpbUw4ViY38boep7M6fn6V1/e9Vb3ULYUrNZNCDzEVDcS', 'Putu Rema Santi', '121370038', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:30'),
(96, '121370039', '$2y$10$LK5S.CdiQ47jaCO342.X9uF1xZrsfXAY5mhk8UMMDaihwN2IBntg6', 'Shalaisyah Dewi Anggraini', '121370039', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:31'),
(97, '121370040', '$2y$10$uG5O2OB4dt7Jve6Lznn0oudFVXKzGlNUa6JTmX/zLhB4WBqqEodl2', 'Andre Naibaho', '121370040', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:31'),
(98, '121370041', '$2y$10$rSGBIzcurOzrg/ygGSvtv.1po.qsTF3ixqMEgwZ3vJc5j5ePDdyQ.', 'Muhammad Yasril Jambak', '121370041', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:31'),
(99, '121370043', '$2y$10$D4a8xljulUerSBZuwWPG1ec8yIeWKFIzFzXG/BtHc.xPG3jEqt21q', 'David Dalius', '121370043', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:31'),
(100, '121370046', '$2y$10$8YfzixYaEM95VuAKXL0HTufeR3DiYQeISFPl2MhmHrUgKLccld.Nu', 'Sadianto', '121370046', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:31'),
(101, '121370048', '$2y$10$1q3Ezv8IdzK7FfYTzDbQ.uX5idMFWXCpA08CdUreARv06qaaNbOAG', 'Marsella Sirait', '121370048', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:31'),
(102, '121370050', '$2y$10$iWlFft38SItEqydewIbWGO2YCOFqZo53WJ90oUFkF2AEOT3SQ07Eu', 'Muhammad Nanang Prayoga', '121370050', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:31'),
(103, '121370052', '$2y$10$CJcmEtp9g.roLCxRluAWF.sFNlV4ZlCGCAJrjwjCuj7H6tagHkKOO', 'Michael Elbert Simanullang', '121370052', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:32'),
(104, '121370054', '$2y$10$NxEAfDjp0SwcKyWA60D8g.27pwBRCnis7RXP30rvdBrNBGCwoElVu', 'Raka Maulana Bayu Satria', '121370054', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:32'),
(105, '121370055', '$2y$10$2IZM6FA5vYtEzRvexk0TU.IIP3gRE/EINKhkF0C2PsOKpNZwZcc5K', 'Surya Sandi Anggara', '121370055', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:32'),
(106, '121370064', '$2y$10$IW2ntKCSc/MFQIWnjEyOv.eJ5oBSHHCZU/wGJtloTqmtxlJdBHhqq', 'Nur Aisyah Fatika Sari', '121370064', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:32'),
(107, '121370067', '$2y$10$LX0G3TnUGC8BZ7FsUf.vrOCRCgIs0bryCtjhvWTNXxZEP/H65s9Ni', 'Reinolf Martinus Pakpahan', '121370067', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:32'),
(108, '121370069', '$2y$10$YOM/BWYJ5rGEi3c3fwNGAebVQbwwh05Rl.kzC8xLnZfRstPkcJ7Ji', 'Ridho Wiranata', '121370069', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:32'),
(109, '121370072', '$2y$10$rCsbvDxY5XEKUuepyJpVHeQAKtR7IE2R81Eujw2kCNk4qD6WOWj1i', 'Jennifer Dwian Dachi', '121370072', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:32'),
(110, '121370073', '$2y$10$wXMHzN0Vx8Cbdu22.JQhI.7Dy/3C1NovkJLOKXPWrCjAL9lAuHarG', 'Sefti Wulandari', '121370073', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:32'),
(111, '121370075', '$2y$10$b4t.dbIUZkE7LESHLu2dMeMQjfzN5rOLyYWc/5iYUlEANe601WIwC', 'Veralina Jayanti', '121370075', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:33'),
(112, '121370077', '$2y$10$YlNJQYaq.0RZDwkkW60h.uTkf6.dBY5AeeI8qxVPPVrC9Xhxz.KQm', 'M.Bintang Satria Jaya', '121370077', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:33'),
(113, '121370078', '$2y$10$Xw/BOdLTaJb8QXJzFiGBXuYFo109VUp79J9MpIHWOlwUfIrd6sc4S', 'Tiara Anisa Yolanda', '121370078', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:33'),
(114, '121370079', '$2y$10$KU/0JqEZM1NbnfOgROle7Oh/BSe/sNBWo4D1rHxkknWgmwO5Ve1Km', 'Rahmadina Putri', '121370079', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:33'),
(115, '121370081', '$2y$10$R2DvxXkgfoTnBP9tLkVz/edJQcDPtIPSX86675ZCh7/tVmUXfxfou', 'Dimas Raufadi', '121370081', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:33'),
(116, '121370082', '$2y$10$mxwj32WLY8SodQn5Zbn4puXw1nb0mHHuNnful11D0KICW87Eokrye', 'Adinda M. N. Cahyani', '121370082', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:33'),
(117, '121370085', '$2y$10$G7zhDnE/3LRXMOj9R1yWluYcLIHfs/TgzD.7L/pE4opCGib9MxNg6', 'Pajar Witarto', '121370085', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:33'),
(118, '121370086', '$2y$10$BAe6SsHLZYTqETK4/5Fcoe9SdQiMvt/0zgOIuR7zkPpo2e90skBqO', 'Enzelina Audina', '121370086', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:33'),
(119, '121370088', '$2y$10$htz6zF8GzzDyp9CBm6ISYOAGXgGltyq0VDtwaI5hmmQYBgoiVs7dy', 'Michelle Petra H. Br. Sitepu', '121370088', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:34'),
(120, '121370091', '$2y$10$kQiEkfK/vt/0OHWnzk2xZOTqbeKH0JgaS5ACkScYDegOpKZZ4jygK', 'Agung Fadilah', '121370091', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:34'),
(121, '121370094', '$2y$10$smLzPTqqLcB1bomcKREv.OKEUBSki2YkEEKoZEnZIupxEdDJcGmlG', 'Arlin Diaz Miranda', '121370094', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:34'),
(122, '121370098', '$2y$10$x8l0G2oCJw/amrUqGOlIR.srzqR2GbXbjRFa4s9WK38KhB0ITZJaS', 'Aldi Amanda Putra', '121370098', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:34'),
(123, '121370099', '$2y$10$9VZlbM/joHNDB3KgKH2.Tuxe6aYwluV/FVBfn/ZplQT/tO0ZX9Epq', 'Martin Marco Pangaribuan', '121370099', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:34'),
(124, '121370100', '$2y$10$7VVMFwR2X8JNGD994ZMpDOaHJrzv4nK7e8qOE.APlhgY2kMOwbpnm', 'Mhd.Immamul Anbiya', '121370100', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:34'),
(125, '121370101', '$2y$10$HuPpjzT9BmeKeonHKCX7z.0cKMtXbKLm8U/f4UE6eES5r0uoaCRYS', 'Herodion Marbun', '121370101', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:34'),
(126, '121370104', '$2y$10$Y5M5rLfi.W2AM8BbFhsfNuV509W3Ou.SbloyGdeEQ9Mhg.5Ixazx6', 'Oscar Rahmat N. Pangaribuan', '121370104', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:34'),
(127, '121370106', '$2y$10$5jtjA9PcQbUrDf9YDzvFmOXsIWhNd7ZePvS73MW33HM3tV9YN/HyC', 'Choky Mulya G Lumban Tobing', '121370106', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:35'),
(128, '121370107', '$2y$10$Nuo21eKnbvvV2f8WlVkrmeDjbfdjf1AM2mpiz1I/XscilhlG4th0i', 'Nabil Zafran', '121370107', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:35'),
(129, '121370109', '$2y$10$aWFpYF6ov5/c0tWb5n8rz.EjQyxss3oBKxwBUJNg9mswSplwGcWWe', 'Mesra Fazila', '121370109', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:35'),
(130, '121370113', '$2y$10$BH/wnx5fh.qKokSfI0TkfeEFOfGLsk85B0luGmHkuOTaL8VJbceFy', 'Ghandy Alvian', '121370113', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:35'),
(131, '121370116', '$2y$10$daOF7RO0RptiW.IKG7HAmeAGjMHu/mKb6T4MPRawZh1/Fgh4cZ12S', 'Ahmad Fadel Rahemy', '121370116', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:35'),
(132, '121370117', '$2y$10$drhZ1fD6/QcOi/tlTTRdd.wjBJLWyzzeQG4nD9YNkSmWOF/6.PE1G', 'Alexander P Halomoan Siregar', '121370117', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:35'),
(133, '121370118', '$2y$10$DrdMw7.9HysRW2OPeUyw6.my1s3NdUbXUJGLsY5F.O.bcNgSVKlx.', 'Rizky Agustian Divano', '121370118', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:35'),
(134, '121370119', '$2y$10$G4aoZa.RNseNKt7ved2ew.t1OUiVO3HtYTZsYlmJBrSvnKxR/uzmi', 'Muhammad Afif Sanjaya', '121370119', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:35'),
(135, '121370124', '$2y$10$7PUfbEa89OZC09Tx17GUnuV7kx8nVE5CqYQ0qy.qwRUGjHhNO1MfC', 'Ade Amelia Ramadhani', '121370124', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:36'),
(136, '121370125', '$2y$10$U1f9aOEdQZf2uN9aBy9ZvuaiOg3eEspdwmeUYyeO15qhdddO24m2S', 'Josua Dwiki Arispan Sianipar', '121370125', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:36'),
(137, '121370127', '$2y$10$f5BJABG4igkGN6LH.aISfeEWr5QVwSf9C3xIkgrHe2bT9dqtxPava', 'Maulana Alif Al Hafiz', '121370127', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:36'),
(138, '121370129', '$2y$10$xEdhJim4IfGLN8J8XMaMnOjcBmnf4sUJcoK5EGMC51zgQYI7vpNPu', 'M. Fadhillah Hendika', '121370129', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:36'),
(139, '121370130', '$2y$10$qVyT5oyFhPPwZsBmSCABouYLEtAv6YQ28.NfHYHWMPVbV9PIVuf8i', 'Risman Ridho Hutapea', '121370130', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:36'),
(140, '121370131', '$2y$10$pwoix8Rg61A2O.llJfel..8MapogWxduAF2VfVCoulKA1fSOazdfS', 'Yohanes Genta Vernata', '121370131', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:36'),
(141, '121370132', '$2y$10$hw5eGaShu24hfMGPv05LsumjzhS6pIP5AwNIe8DDg4SEzBTi42ZZK', 'Alivia Nurul Husna', '121370132', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:36'),
(142, '121370133', '$2y$10$CkTHt5ymDi6.KOXMclFVBOWa4jpS07FJVRkX5eJriUcu5cfQ4sIaW', 'Mouza Robest Alponsi', '121370133', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:37'),
(143, '121370134', '$2y$10$Pi0mPQZZ5q7NDmJ36WEuh.S9hZpvKbmZiUpSUPNE7pV3Ix0BH/6qa', 'Jhon Antonius Simaremare', '121370134', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:37'),
(144, '121370137', '$2y$10$JKcPdQrqd7Hm2XKKiycpqurO0gNGYSuOuRde8sMj8HsVNwci1gY16', 'Rocky Sihaloho', '121370137', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:37'),
(145, '121370138', '$2y$10$sRBI2XyrBKr3Kiyw0i7uMeSqZT84Jf1BXxeOX25fwM3CGvP.GgaTi', 'Muhamad Bagas Suhada', '121370138', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:37'),
(146, '121370142', '$2y$10$NuJFpAkz0GA3YBByM04lcOZknSLuDvVT984Mp.Oc36H5qyBNiUdBS', 'Arya Kosy Pratama', '121370142', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:37'),
(147, '121370145', '$2y$10$2CVxZMzGioe30GuK6ZvaH.JJFOPuq1D2EdJlURwmQJ3IE2uLEe5rC', 'Irfan Surya Albariq', '121370145', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:37'),
(148, '121370146', '$2y$10$kHooawr8Nej6fVJpJWOtIea5o0PfYZIp27chS5nrxcXfY3wkf4Ggm', 'Faishol Alwi', '121370146', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:37'),
(149, '121370148', '$2y$10$94gmy09mu0W7dNPOVTr7TegwuwLMkVWPALNYnl3MxqEujIKnwF9Oy', 'Alfariz Bakhtari', '121370148', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:37'),
(150, '121370150', '$2y$10$MoC.ld7IhuYyCDMkm9e7Hu5uRy7LcdO9l35ONBenD2iRLpHYrurfS', 'Ardi Triamanda', '121370150', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:38'),
(151, '121370151', '$2y$10$LRKIc7fa8RI6GLG9Uel.zuliX3414cxTxox8ErDpbSMcAYwaC6ZCW', 'Rizki Okta Noor Patria', '121370151', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:38'),
(152, '121370152', '$2y$10$WL81o9PQb2QwRO587gu6EOic.wanHpEfLpYYbuN8Qh4Y7W84J4cGq', 'Chandra Setyawan Ginting', '121370152', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:38'),
(153, '121370154', '$2y$10$mZ0oObvNT6hNJi2appYxbOhy7F5vzob.wIR7z1nsk1DP1vM7igI4C', 'M. Rizki Darmawan', '121370154', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:38'),
(154, '121370155', '$2y$10$0Ihys2ZAqv6jNKlE9UJJE.kcO.uC6PTbxsETc51bewBAPO5hOPEK6', 'John Alpabet Situmorang', '121370155', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:38'),
(155, '121370157', '$2y$10$qFoHKN8nFnuWzeVRs./UaO.RhVGV3Lfu.ubx8bxRZ2d7cPe1uemDa', 'Erikson Pascal M. Lumbantobing', '121370157', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:38'),
(156, '121370161', '$2y$10$kDtJnyb1b8UI.sraBwWQIO.p1dWfOlXaHfTstVqEIDKL6d31F/A7W', 'Alexander Andika Hendranata', '121370161', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:38'),
(157, '121370167', '$2y$10$zrr9L9vpbtChzw/hMbEJkOS3ed1wVTsHhCC1ilkwypE8Wv4xZRJXy', 'Rizki Ahmad Setiawan', '121370167', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:38'),
(158, '121370168', '$2y$10$arO54G2gEwVXM1P673gp7u7qNTu15902KmVdv2xVBU96glWVaM4CO', 'Usmar Andoyo Sianturi', '121370168', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:39'),
(159, '121370169', '$2y$10$UeibsqJw0c47/omwr46U2OZuHiXDzPdjVxxfN3tvluGkbp8sQHgjq', 'Bintang Rafi Akbar', '121370169', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:39'),
(160, '121370173', '$2y$10$0xhrtONsJTkzgVm2z5ydkOA9iDfLUJkW0pfpx4Zi6kgIKy2VUFD/u', 'Galuh Futisari', '121370173', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:39'),
(161, '121370176', '$2y$10$aupC.46AXp.utBeU0KJ31e0nSl3tBuDKGfHKNTIaseE.8UOZCI43W', 'Muhammad Tristan Adrian', '121370176', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:39'),
(162, '121370177', '$2y$10$A5pW2C3C/IG3INWCn5YHMeCa1pp7SXZvdLdhY0Db0zzZsR101pe8S', 'Irfan Helmy Alfayed', '121370177', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:39'),
(163, '121370178', '$2y$10$ulFdCmwapBDd/W7QQP7PpOwmyapbmF9hvs9LHAPFxRopO/lXWJvhW', 'Nadia Putri Sonia', '121370178', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:39'),
(164, '121370179', '$2y$10$BgiIq2QHYDlqnLNWrKuM2.jt7hXJP3sC3pdxU32RPL6kuQIblvhhq', 'Muhammad Raja Nugraha', '121370179', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:39'),
(165, '121370183', '$2y$10$UzQEaH5sIg1.Kq6Kmtdsn.Yh.Bmy9sxvj9kSgpQ/uW0UKeyPQkoMW', 'Fadil Safrinanda', '121370183', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:40'),
(166, '121370185', '$2y$10$mjbJEtxCnHtiI3f0whreheBorx4DbZL.PGKooeX7mYgBnXnKg3pNu', 'Chalvin Ciputra G Marbun', '121370185', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:40'),
(167, '121370187', '$2y$10$QMaaEUbsLij.RoUEHISRteNCJVKTWVPWrtwN71qXDKfxFxWAZG032', 'Mhd Fajriansyah Zulwika', '121370187', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:40'),
(168, '121370188', '$2y$10$hsQKc8L9XBVmHFB3GnON..SEUnDfKERS8IcR3PpByhV6mv3PzXd2q', 'Nicholas Perrin Simanjuntak', '121370188', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:40'),
(169, '121370190', '$2y$10$7Y3p4W//ctcbtgZ1mMHqW.A1mRwWhag.6SNotKfjbOmZzYlArr5iG', 'Adji Maulana', '121370190', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:40'),
(170, '121370191', '$2y$10$prUx0.D7UWBa6M3wTZ/.d.FMtkDP.gtUUfchdp4zd5vRXzX4yPJmK', 'Gabriel Santorio Sinabutar', '121370191', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:40'),
(171, '121370195', '$2y$10$s6vVEyjzMrR2EwieDGNYvejyYG9B0PwpNnB10Sh8WsUOwyB5HyE7S', 'Jonathan Ruben B. Siregar', '121370195', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:40'),
(172, '121370198', '$2y$10$O3LmrjaZFS7HAAwjbSS4G.CANEX4CKyHVPi5h5VAlzaN0JwpNJSQy', 'Gabriel Reinhart Siregar', '121370198', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:41'),
(173, '121370199', '$2y$10$q6yG3akqZ1Xv0vfBej3YVuqypb4h1aI.Kw6zu17zLFLrsDCTCh6da', 'Michael Johan', '121370199', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:41'),
(174, '121370202', '$2y$10$ZpmcyE8RSsTbZDrOrcQSt.E9Aa1fS6bIe45ACLXcgh8sYiFdSTdNm', 'Muhamad Alan Zullizar', '121370202', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:41'),
(175, '121370203', '$2y$10$iVe3Ma/gTuTWSmE8efJkNefvTeABOhSaC0vMkoRd.xqMsMrF4r2ca', 'B. Febri Rian Putra', '121370203', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:41'),
(176, '121370204', '$2y$10$sknffxdzMcoBtEl9SmZ6J.wwmvofbvZPzi4VUR0WD9CGAuVYrjpq2', 'Hendra', '121370204', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:41'),
(177, '121370207', '$2y$10$uWvl/rFhdC6no2O7q6co7e7FOgtKXX5PEGu3q6CqdFOs1cS.WuHre', 'Danuartha Putra Pradana', '121370207', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:41'),
(178, '121370209', '$2y$10$tPYrwR2IO3egjlCnMdsRsuP9Sri1tpQZ6a7iJLAd5eNL3c/FbgMqK', 'Arif Ramadhan', '121370209', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:42'),
(179, '121370211', '$2y$10$wHG7WEM3y.5vRtXtp8FyhOcUpoPjzfX2ZcVi9VNJG0zrixz1jLL6S', 'Dimas Ega Syaputra', '121370211', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:42'),
(180, '122370001', '$2y$10$MOvSRwvjP2GeyLzWyawDdOn.PotSAHXAvmnZhPADF8fz0yOsfmN5W', 'Rodo Anggi Trisna Tambunan', '122370001', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:42'),
(181, '122370003', '$2y$10$PWMP4K20hAnr6l40IMpT3e.nnznOwpkqDmrBlyUCC67YHPMpoJL9y', 'Tuani Wijaya Hutapea', '122370003', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:42'),
(182, '122370004', '$2y$10$uEIh7wVruVu1/ctDlMh0ceV3QoJNIz.Xr0/xdH10Ug.ZsoKPh7Lwq', 'Fajar Rian Pratama', '122370004', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:42'),
(183, '122370005', '$2y$10$IGBIU0pl/LKtyO5XgUa2meAcowdSib3XlZFDTwnm9mJqMAJYsJ3au', 'Ramadhania Fitri', '122370005', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:42'),
(184, '122370006', '$2y$10$kpxGm5OSCncRZwc3Z6JkBulVycFcPlu.pdJQaYGakKsBNtNA6WK8i', 'Muhammad Adzlan Alfarizi', '122370006', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:42'),
(185, '122370007', '$2y$10$J.d6X3bPl9uq.LZvoVf17eH/pKOL1puduOg/Nf0Sigmv4fK.4ocLq', 'Azka Noval', '122370007', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:43'),
(186, '122370008', '$2y$10$VzY4h9hEBM.mEdTQosDqY.BHLiOXgKnNiRe1kf91/mmo3JorNIIEq', 'Friends El-Saday Br Tampubolon', '122370008', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:43'),
(187, '122370009', '$2y$10$Fs2KS6liDOkn6i6/z5pFc.Q7Rmell35xUU.qcndIBtUAb0PHFzwXe', 'Geraldo Putra Pratama', '122370009', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:43'),
(188, '122370010', '$2y$10$4AZNh1gQxg6Kk0WxccGVNeDBPqmDVIT/S3vZ16sJ8Sd/juVpg96E6', 'Gavecia Tio Ivada Ompusunggu', '122370010', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:43'),
(189, '122370011', '$2y$10$bBw0DCiop6Oy7i0cOi9CtO3rBBl8UfDCBdY8MMuEZGE3C4rIrAh7y', 'Berliana Eka Putri', '122370011', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:43'),
(190, '122370012', '$2y$10$EG6bn3CMQS7iG6aR36WeGO3tGSxmN9/M9DnWaPnja7365MRce1f66', 'Najwa Dwi Auliya', '122370012', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:43'),
(191, '122370013', '$2y$10$QnTTTpYVR1OknnTH59NB3O38F/iO4nKZ3KIsCp3f45Y0NeNBE/kSi', 'Muhammad Rayhan Widyanto', '122370013', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:43'),
(192, '122370015', '$2y$10$tp7J8DFefqonuvB6XZB43.ff/acrRGy4do7hcKErYJGDjkr3nBUwS', 'Melisa Nia Andriyani', '122370015', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:43'),
(193, '122370016', '$2y$10$6w9u4SpE.4FgobJGmZyEeOrRthA/wraHkZLZ.uvXdgP8hiPWsOV76', 'Indi Setia Rini', '122370016', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:44'),
(194, '122370017', '$2y$10$1rqx6zhoOHCEKItfXUYS9uCWUAPD2R3lJ9kkmBFlrtOcHzMQwa40C', 'Ni Putu Putri Widiari', '122370017', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:44'),
(195, '122370018', '$2y$10$Z59DCYAXC9DGdyairuBT6.7R6T/0U0x9sWbVeUcjPcHoinQNHekXy', 'Revi alfatir', '122370018', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:44'),
(196, '122370019', '$2y$10$DOwQcbGPhPlqjf/yWuC98ODDJ12Hux3WaVcR/vzGx1zv8Nc2Qx38q', 'Sabrina Saghnes Tarigan', '122370019', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:44'),
(197, '122370020', '$2y$10$84lHbUnS1D1MQC/7pd593OoIOWv14s.P.yUcdxl67XXU4UZCM.i46', 'Isnaini Putri Rahmawati', '122370020', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:44'),
(198, '122370023', '$2y$10$hGt8qhqE1CfmaVG.CpS.DOqoTHB0qmLl05kvdtr2B8XS9SeoetIWK', 'Hamidah Isnaeni Drajat', '122370023', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:44'),
(199, '122370024', '$2y$10$eMUVbDm1dw.uppisDRDXJeSPVnbbG6JZ/mYEPBO114SswTsK/N.iO', 'I Gede Radea', '122370024', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:45'),
(200, '122370025', '$2y$10$uAfzVu.92S39ZtBJL1y4AOdWb5RCzQ3Q5UIGOfTLdUdb.q2Nnxtzm', 'Muhamad Aliyandra Yuda Utama', '122370025', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:45'),
(201, '122370026', '$2y$10$HlxKrwRUaucgPPDuRan4hu6YVXvSV9y0mqFZOmVaztXqWsAVWQllO', 'Raja\' Albi', '122370026', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:45'),
(202, '122370027', '$2y$10$i6KNzibgU5ogRgdF3EVPOe.VosehwwU6ZqCbQN4vVQ1vUZNq7ML3m', 'Jesy Disyah Putri', '122370027', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:45'),
(203, '122370028', '$2y$10$2k2Y/NS/.1nJU00IjMbOfOsWhC24KLXIqoOsyfMvNhnJWSu5FL0/C', 'Muhammad Ramadhan', '122370028', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:45'),
(204, '122370029', '$2y$10$yfy1W8ABG7LRCjIlJ1SPxuqhGLy4GcwYOTOPu82oF4wH1xKZkLkKe', 'I Made Erick Dharmawan', '122370029', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:45'),
(205, '122370031', '$2y$10$e/0BH4PFtG35UOaBzNkMveHqwfhq4GnLE3T9hHiE.6XWgs0yg4.7W', 'Cicilia Novia Permatasari', '122370031', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:46'),
(206, '122370032', '$2y$10$iqQvSBFSysbzqsDyayuG3uIEFgx9U3tEz/j6LGyz8UQJ7KqzKtXei', 'Meilani Putri Elena Purba', '122370032', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:46'),
(207, '122370033', '$2y$10$7nZllC8BQ1h01i5FthlsP.IWSx1m.Wg0O7pCFfv1QS7e/kt0vKY3a', 'Anggi Christine Siregar', '122370033', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:46'),
(208, '122370034', '$2y$10$qsa4QIZuxWaCCJTBL7VO7ODdP5NaL3uihd0AcKl8.qKyGD05F0k.a', 'M. Ferry Setiawan', '122370034', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:46'),
(209, '122370035', '$2y$10$LCsRnhZAM09QdJCF0S1T9.SdhBsxXwY5uxv6N70FEiWaYRGQTEekG', 'Imam Waluya Indra Praja', '122370035', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:46'),
(210, '122370036', '$2y$10$I3QAQ8yVG8w0KDhrxPVuFeFhznZeu6sbepulEAPd9bW7YaGI2YJve', 'Syalaisya Fadilla Alfatihah', '122370036', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:46'),
(211, '122370037', '$2y$10$OUde7S03VhU/9MSMiwsXO.K14X2cNbbZPZrDDUMC7g3sYpvdeAuvW', 'Jamiilah Hardi', '122370037', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:47'),
(212, '122370038', '$2y$10$.w4BhruWTYkwrnkAE4zdIOf5gB88demv7ZkDzwHYdiF8y.JVP/z0q', 'Andreas Kelvin Sihombing', '122370038', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:47'),
(213, '122370039', '$2y$10$QIQJl3lTdVHWowOQp0WLF.8aVXUGphYkiwLVGm2icbtzrFEDzex.a', 'Ikhwan Ridho M', '122370039', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:47'),
(214, '122370040', '$2y$10$D0KxrYKoAz/02Sj/krSdDOY6MZg/BzxxkeermUtKeqSWIClen1cpW', 'Muhammad Septian Ramdhani', '122370040', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:47'),
(215, '122370041', '$2y$10$Rbn7UuAm031diDagPDb3OuyAwzjfSkoyU5a9iKPVLuYzzN.VmSida', 'Jeremia Uba Metanoia Silaban', '122370041', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:47'),
(216, '122370044', '$2y$10$xfk7Ak6aoUOo.emlnRD5MOxXa6I68fy14VpDxEm3r6Dp.L0FmH5fe', 'Fredrick Yoshua C.H. Saragih', '122370044', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:47'),
(217, '122370045', '$2y$10$Xz9siK9lTzvy9iLWdW3Xx.1n.DrEfo1Oq1x3TFae4CTOrxW80X4KS', 'Muhamad Rizky Saputra', '122370045', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:48'),
(218, '122370046', '$2y$10$Z6ACCg4WyjghRct.qDVrKulOeJQm8xz2oFKGv5qWglFsoy9EzzRsW', 'Azizul Qadhri Khairi', '122370046', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:48'),
(219, '122370050', '$2y$10$h1zn.Mh/bQLCVlqXojKV/er28QbtGvkkjpey9DMHD/Rw7gx2cUWby', 'Yuda Aidil Fiqri', '122370050', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:48'),
(220, '122370051', '$2y$10$fBbzfaZgroDm2ifZN2.C9erWEaTrKmaqoU09xvuf0AC4l4lzMnHK.', 'Chita Maulia Fadillah Rahman', '122370051', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:48'),
(221, '122370052', '$2y$10$BkpHN98qUlFe.9knYEA2yuCQGJDdZ4yEctfNclpdWR.GhlbCYsH3W', 'Cecep Amru Rohman Nugroho', '122370052', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:48'),
(222, '122370053', '$2y$10$dbZpehM8dfsWaKOC2xhE5uimWqF6GAjs.l8Z5SJi3dgLewPS86eYG', 'Hindra Rahmansyach Putra', '122370053', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:48'),
(223, '122370055', '$2y$10$uJbDuwWjWZmKBJZQMj9E1.E/hU8dmdd97k7nS58FYtSY4s4mJdZ5W', 'Natasha Salsabillah Andelin', '122370055', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:48'),
(224, '122370056', '$2y$10$bK5mntPFjiZf5jREW2lzhOlPkZfdfJez.ti9wb4aXen0j8GExzhvS', 'Christine Daniel Somara Simanjuntak', '122370056', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:48'),
(225, '122370057', '$2y$10$qdgETYTcuvimPPN2UaO8LOCEp/ZT59rGNDAK4nOQHGsLfSqsJQCKS', 'Gland Nuryanti', '122370057', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:49'),
(226, '122370058', '$2y$10$aAvBCCoWpW7/AR.CfWiozOJKWfjGFE2TGRSgXxbxWrcAFTzQlJsPG', 'Aliffiya Panatagari Irawan', '122370058', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:49'),
(227, '122370059', '$2y$10$o8sVQXDKX0srb7Vx9iYrBer.ZqTdloC6.QyBybJbgIuCNdiYBonb2', 'Putri Patricia Margaretta Sitio', '122370059', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:49'),
(228, '122370060', '$2y$10$X3aoavoxn2k9RsItS8zBg.R78oKpDrQyhnqDTNnC5dKVL/aNJe28q', 'Suryadi Akmal Wijaya', '122370060', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:49'),
(229, '122370061', '$2y$10$vcDSvj9gSr6G4i3MnUcOqepw6VV3E40cNAlLZF27QSQx01y1khWRq', 'Henry Fani Pratama . S', '122370061', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:49'),
(230, '122370062', '$2y$10$pD71zCXIV2AgLeJ75Ajg/e/mdCAQaFz1h5x5wIUM.QjE0TyhgWSLu', 'Farhan Tirta Amarta', '122370062', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:49'),
(231, '122370065', '$2y$10$hKpbyMpaTflBYi2EhxwK5.AHxbt/JYMcxfSGWrNe3fCHnU5xqtac6', 'Salsabila Arifah Suci', '122370065', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:49'),
(232, '122370066', '$2y$10$usi.imul75Iy5BERxsaDreZpuj3/AV0ab222pIzQoGycQQkndc1BW', 'Natasya Rizka Salsabila', '122370066', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:50'),
(233, '122370067', '$2y$10$kHKM0Zk4QPtfybr/fyoFau5pZnHl6cewQ69/HZzDeFheB5bdhF2dq', 'Kevin Alexander Chrisel', '122370067', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:50'),
(234, '122370068', '$2y$10$79J/AfRY3H85C6bwwEKeZeq6HCU0dMKvWHRGpxxGZ3AOHm5ljExQy', 'Rayhannah Shafa Mahirrah', '122370068', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:50'),
(235, '122370069', '$2y$10$E0QmVcbn.jBNXap6vlfFzeI.i3a/bTfbRaMtD5oHWCK8LCngaAU82', 'Ferdinan Lutfi Lazzo', '122370069', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:50'),
(236, '122370070', '$2y$10$sYeI0kH.0cn0vPjLEy132eWVkzJsAjIhdMlbpXd6xcs1nJS9gUEyi', 'Ferly Putra Zoelanda', '122370070', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:50'),
(237, '122370073', '$2y$10$yeKdMGtkuY6seU2W7URaaeCQjaDmYOdQ5pydh6/tY/Tb/Hp/3v13S', 'Syifa Fauziah', '122370073', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:50'),
(238, '122370074', '$2y$10$runfOo8m/ymTlTiaNzmM6eii2jiJJf5JOChqJEZp2wDeKwOghC/ge', 'Rizki Wibowo', '122370074', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:50'),
(239, '122370075', '$2y$10$al9U3YtXxnHfZ6dIM3Gu9uLq9jc7bYIVLLLqC8V/aWq.XhkFJBUva', 'Vidia Gus Aquary', '122370075', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:50'),
(240, '122370076', '$2y$10$O5RlmC0..R5hQD764KSmb.wzV77Kk06tTKpvPqzF3AOrK062a91pq', 'Maria Monica Marbun', '122370076', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:51'),
(241, '122370077', '$2y$10$mNPMqNNEYEfjk83JOQT24Ow5OWvhyzZwKue0/FecY.HiweCSJtlQy', 'Imam Santoso', '122370077', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:51'),
(242, '122370079', '$2y$10$5q.UaRFf9220EqcqS.pEKuD7kgrI6GbCDurHl4J7O4loP1FdVa6MO', 'Hafidzah Yuki Ramadani', '122370079', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:51'),
(243, '122370080', '$2y$10$HaP/dKxxkb6nmMw4jb0dBuRA.fUKbd30NPRB.QYEbPO2CeyRlAUa2', 'Nurwendra Fatiha', '122370080', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:51'),
(244, '122370082', '$2y$10$dimZDnTLUHNRVDlBhQrc5uQEp4zxd8qoK0gpJ0.zXTdbinBvsG0wW', 'Syaqila Maulidinita Zahra', '122370082', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:51'),
(245, '122370083', '$2y$10$weRQX48lmV7LhOMdyVm64uPdxVMswxEaWDneg/W3twF4IG9izqR52', 'Andika Lukianda', '122370083', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:51'),
(246, '122370084', '$2y$10$TkDBknyjoQMcf9g02G2qvO/vAFnGdlSZujjZbBQo/k9D7YlXCOVTy', 'Achmad Syahdian Harahap', '122370084', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:51'),
(247, '122370085', '$2y$10$LnBxFY54C/.x0Ix4MQt/oujEMWQmHIUnXPX5TpmXS3J5qX/H.ITCC', 'Muhammad Farich Fannani', '122370085', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(248, '122370086', '$2y$10$4QDQ6M4CCNfo9wgBn1QI4e.TLU1O2FHTQZAlQ8Ss.zkduLZX9IAaq', 'Raiyan Akbar Khoiri', '122370086', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(249, '122370088', '$2y$10$anK0uO.aYEudP4eaDxBItun.29omHTbhNQ7XE0tJYlNhZ4k0uhQj2', 'Muhammad Irfan', '122370088', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(250, '122370089', '$2y$10$5WfUdtoxgJxQpEKIPuQwfuevk5I5WHGTjfzslDZ0feq18TlowPen6', 'Zittiva Melliany Lorenza', '122370089', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(251, '122370090', '$2y$10$qPfNbEBWFQkbzCNkNman7eDR00EzpZD5tAB/xWoXlms/rzCK/wAaS', 'M Wildan Arrasyidi', '122370090', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(252, '122370091', '$2y$10$zycvCxq3mFbNMtzq6VA5l.wwWdxgl2vjIaFfwEvmobKVVOz5LEIP6', 'Khalid Rajataranggini', '122370091', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(253, '122370093', '$2y$10$Kf.5R0k9GTtkiIZBG6j8YewlCah4YAeKJPUf7zPVT0xLzjsk0NPsq', 'Nicholas Vito Pradipta W', '122370093', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(254, '122370095', '$2y$10$5pVuNwEbFjlXlJ.paV8ySOdoTmt19bECI9OJilGReVTw8LT9ZULaK', 'Nurhamijah Devi Tobing', '122370095', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(255, '122370096', '$2y$10$lJH4NHbtaApO7aZu0/FQaedWCmB37T8Eo5FiEHcsKWUN7CAaokOmu', 'Wilher Situngkir', '122370096', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:52'),
(256, '122370097', '$2y$10$Pts0lQivZrUulZQTTk7O7e1pzhtGjYAAQXPKGfb7kZUTehBGV5oi2', 'Fahmi Susilo', '122370097', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:53'),
(257, '122370098', '$2y$10$.u0B/qlwGpDkZqQCazn8OeqX8c1hx1mSGVovQayJ3pNOMu2GCTt..', 'Sheva Aurellia Puspita Pandu', '122370098', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:53'),
(258, '122370099', '$2y$10$P7.npypUWKkZX/jPXMZBd.FPUHoVTJBMN9UhcvbVShZB6Jaix511K', 'Panji Pratama Ginaldi', '122370099', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:53'),
(259, '122370101', '$2y$10$MZ7NGlzy4spaVUqgdyzPPu2E/PDOvi8XixSKw5DO0ivAhUeSmJUWm', 'Anggun Delfi Agustin', '122370101', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:53'),
(260, '122370102', '$2y$10$Kb0wDZjwQywcmY2PWIKnBeVanYdYpi6s79A4WVTrJJlDF4Fhf.WMa', 'Egatia Cifta julia', '122370102', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:53'),
(261, '122370103', '$2y$10$SZ4BY66kWS8csfgrv/Ui6.r21yjGGHZY.nMs6vAFbD1LfoG6YQHqG', 'Prinka Maiki Atma', '122370103', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:53'),
(262, '122370104', '$2y$10$HiA8IiscRKUp0nxkk54FJ.3aBvEnCkt3Dj8k9GCF0O8dn09XnH6iC', 'Ilyas Nurdin', '122370104', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:53'),
(263, '122370105', '$2y$10$u4OXSiPb6yXuGHfDgd.xeewj1R3SATq0nyGC9UlNhu5KByZnGGit.', 'Sovia Evadamayanti', '122370105', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(264, '122370106', '$2y$10$Qvg.HtW/UZHhhTusCAley..g9SKUxpuUHWUK1xtnEFvXESt8sW6TW', 'Nigel Novpean Bate\'e', '122370106', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(265, '122370108', '$2y$10$AQ/O3OLYZX/MV.aexh2x4OiTrzoXDczOshDY1O.OWYZap.Z3gxZ4m', 'Easter Dameria Silalahi', '122370108', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(266, '122370109', '$2y$10$pKoIXa8aOLK4LlHeiTy9KOsZOnPlwO14N0qZfgdSftBldunrCq5by', 'Danty Azzahra Zalfa', '122370109', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(267, '122370110', '$2y$10$.WytRghAGvM4Lky.fXty8.vd6I3lKSBQIjn7c2Kkf2wjrlvikq52S', 'Annisa Fitri Anggraini', '122370110', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(268, '122370111', '$2y$10$JXQzLG0f2ulA4iBs.wvySOBKBqwsoDtbk4ihLPbHRTbDBGnfCGO6q', 'Faradila Diva Oktasari', '122370111', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(269, '122370112', '$2y$10$DxNHg0ax0c8s101nc506y.f3E4CmjNkgzYsw1X5HpgkV/b0AubdSm', 'Novi Dwi Fitriani', '122370112', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(270, '122370114', '$2y$10$ZEtLE3mA1cF08bs36DqgH.7cFgz3himZ/UuZdVAjzg9DZDPOa5Omm', 'Muhammad Faqih Difanauval', '122370114', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(271, '122370118', '$2y$10$Gi.wWbJ9pVrSwLzMpfQ5MePRnjj./agMYaywFW3dE7kXozl2cHqiO', 'Togi Arifin Sinaga', '122370118', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:54'),
(272, '122370120', '$2y$10$oXdIq2LF1io2FHTaA559w.R8fGcT8jbLyQr8MjcFwPoqkXo4pQpRa', 'Dedy Davinci Hutabarat', '122370120', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:55'),
(273, '122370121', '$2y$10$OdrlrPXUbk3sxxZmaXZwYeUW2BEp2jl.qjGuWwneGWFfw3BEBGeLW', 'Michael Pardamean Hutabarat', '122370121', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:55'),
(274, '122370122', '$2y$10$QOrT0mspULzSsmcjBDhbAeDB/BJCbDvAs5sgb1kq.niWNX6g97Tam', 'Felisa Lestari', '122370122', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:55'),
(275, '122370123', '$2y$10$mh.Wqt4F4U0kkgzjAWzZmun.0DkL1wlgbWQ0jKJG5qA7PhtIsgXiS', 'Adhy Daffa Mahardika', '122370123', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:55'),
(276, '122370125', '$2y$10$HWjjPweNZ7AOp2J4jxZXTuetVrfnb0z4.dKrx6lMEy70ehgIMCtqu', 'Yuliana Muti Afifah', '122370125', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:55'),
(277, '122370126', '$2y$10$WEqxYcfKZ/iCgSPt7nlJzOELm.orZjM0dcLmcLlo3dhjmkUqQWgF6', 'Yohanna Tresna ia Sigiro', '122370126', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:55'),
(278, '122370127', '$2y$10$A/WeJFGCJtpWxrCYZLbLRenSNQZNMlf/Ch1Uz2alNFrEoEIPYPmRa', 'Emya Grace Hadasa Sitepu', '122370127', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:55'),
(279, '122370128', '$2y$10$urg7Tis7Adb.epTkjULAcePCQWsnxl2yySDyKAiWgZlMtRos9lFeu', 'Ahmad Hidayatullah', '122370128', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(280, '122370129', '$2y$10$If48wRGN.e0cBHrt19UpsO8sW.yfzB7lyGWZWtA.i0HOaojXzrt36', 'Kezia Kristiani Sirait', '122370129', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(281, '122370131', '$2y$10$7FZG/YLGn9Gj/ng.iLTKm.WSQ75RqWRKLyEh.mxthmynIvK9tnyKe', 'Alvian Putra Hanafi S.B', '122370131', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(282, '122370132', '$2y$10$MxfNn/sr8hO4e6W1vrz90O8KcBrfig5Zbpf6TZ7TJB2vNWgZUBWIq', 'Sardion Tampubolon', '122370132', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(283, '122370133', '$2y$10$AHM7gyBWzYETdSsjXhTRi.BJsb0C8jjkD.EGjv22.Gy6.pkBjI3pe', 'Rayhando Ermizal Putra', '122370133', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(284, '122370134', '$2y$10$Lyw9BojTbLTEdleBzELkmOC./GuFvTlm8dvy8235wsAnXjOaNB4Pe', 'Alvin Taufiqurrochman', '122370134', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(285, '122370136', '$2y$10$sz9i5nr37CsbT6iiN0bli.90IikWkyAykeI6pizi8L.JxqLU/l8BO', 'Anjas Jevi Surya', '122370136', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(286, '122370138', '$2y$10$539YbMrn1wdBfvkvaf2TjuBuugrwHXW1nDqh2oc2IGmlU9fiBUv/m', 'Amandha Febri Elsa Cahyani', '122370138', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(287, '122370139', '$2y$10$vRz3ufnAusQZ1e7f8J65CeVDUVoJDMt1Y8ZFubiXZQCf1w/ROCD2O', 'Muhammad Fahri Adi Pramudya', '122370139', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:56'),
(288, '122370140', '$2y$10$7INxtRvLL1bw6.Ba8A1jBOKNSFOy9/66Tw.VjZyIBDH4Zl9jRIub6', 'Althaf Anggaraksa', '122370140', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:57'),
(289, '122370143', '$2y$10$aCd9f7bmuQ18l39yDa/10.89vTxkUwjlgNpcP0WO8T3rC3vGPrqR2', 'Priskila Palumpun', '122370143', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:57'),
(290, '122370144', '$2y$10$K7Ypah9YU6ggp6txE1tNs.Jyzmk6l52yZOonA89Qo9TUiIQH2Fn.e', 'Ridho April Rian', '122370144', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:57'),
(291, '122370145', '$2y$10$nePhfF5Q4T1QUozarTvVc.93QyMwS0SaUUo45EaNl9w6jZ8kgrjXS', 'Mochamad Arby Turoby', '122370145', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:57'),
(292, '122370146', '$2y$10$FkF/UFxE0aQYuGHEGLTfG./RiGjCa7wKkNRjVQLMe3SPH.jQyF6qm', 'Daud Lodwyck Anderson Hutauruk', '122370146', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:57'),
(293, '122370147', '$2y$10$wZ.UADzn7ATSiknec5lVY.YqJ/AV.pmMKW6s8UdMS/bt6EDnADKEm', 'Kevin Graha Buana Persada', '122370147', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:57'),
(294, '122370148', '$2y$10$rEcQLz8kdoF7MKmBY70qj.sJqD65TUwS69sFxTdToVduaEJbad9AG', 'Dylan Azura', '122370148', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:57'),
(295, '122370149', '$2y$10$7rv/eWE0I8Coj6y/O5JJSegxa.WqIZmXC4I31THwkK/kzLM/yJRai', 'M. Fikri Saputra', '122370149', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58');
INSERT INTO `voters` (`id`, `username`, `password`, `nama_lengkap`, `nim`, `prodi`, `has_voted`, `voted_at`, `created_at`) VALUES
(296, '122370150', '$2y$10$/T65GVAy9EJj5PpuECBlkuQn2Td7zGPMDAKc/3o5mB.pcRARBCxo2', 'Martua Sonson Jeremia Samosir', '122370150', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58'),
(297, '122370152', '$2y$10$pNm6lw9vAbiQ/WrxrM7RseFaFFfzZXje0J35fXZQZVAetbLb8K1/W', 'Rafael Maruli Tua Naiborhu', '122370152', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58'),
(298, '122370155', '$2y$10$ALEnQAtOs9sEoN1BRAOfLuzelTCgK4aSYuLlW49./fP4y0j2CBdua', 'Tomi Hernawan Sitompul', '122370155', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58'),
(299, '122370156', '$2y$10$lxleiGIACISp/8jFvfMD5OtR02ZZaxKNOYIyIZnT0Ae7IcimWbqY2', 'M. Abdillah', '122370156', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58'),
(300, '122370157', '$2y$10$FzXMnYf6iaoOg31Bz3Cc/uNTOiFtXyaBREA0m55CQk5V.wmdeixva', 'Louis Y.H Simbolon', '122370157', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58'),
(301, '122370160', '$2y$10$YGGSZSEKe/4r0HsTc3QFtO98ciSyCPHBSSO4Z/aVIkCyTrhGHYqXS', 'Sesilia Doloksaribu', '122370160', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58'),
(302, '122370161', '$2y$10$Qq8EZMK5JatJE5aG0QeFpOxi8KOsSdyEhv15Ft/me6DpwEBqViUE.', 'Muhammad Alfayyadh Febrian', '122370161', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58'),
(303, '122370162', '$2y$10$TrkGdKeAoYBIjQI1pZpIX.90J/TQjlVqZmtiCZoIsIZxch3ldIwVO', 'Johan Hezekiel Marolop Ambarita', '122370162', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:58'),
(304, '122370163', '$2y$10$u/Clkq8ZU8SrB3v5A9lMyOcyMxKX/3i/ynVe4lWGTIaK3NmG337K6', 'Riski Setiawan', '122370163', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:59'),
(305, '122370164', '$2y$10$lgdlvboZ1XHwwsyVsLVZwe1cNyjjxTvBLWzdWiCjNpaexIKtzlPaS', 'Jery Gardiola', '122370164', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:59'),
(306, '122370165', '$2y$10$k0Tx1E2YPEls4bQ8YQd77OVJY9sDYV/K1YpEGLBbHmhTcQLH1tcSy', 'M.Kelvin Wijaya', '122370165', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:59'),
(307, '122370166', '$2y$10$7/swaQbQ3HZ9vRJz8VAi3O2s6xPJHOi9S1M5Akqn0vm4h7AaTmqRW', 'Alberth Mechanical S', '122370166', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:59'),
(308, '122370167', '$2y$10$QAit.dVTJ7WqypRuyw870eMOnei1ddhYfHkSPxqdmC6QdOh//RY4i', 'Nanda Alya Putri', '122370167', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:59'),
(309, '122370168', '$2y$10$RHeJK4gadznxM0lToidKL.pRzGj4lRH/PtUXp9atzt6dsvbbp23v.', 'Ripai Septian Turnip', '122370168', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:20:59'),
(310, '122370169', '$2y$10$AyYXhZn2acX3LcQ99OBCWuGze9OQNooSGXs1Wxi2yZ2fy5kqkAqZK', 'Muhsin Habibi', '122370169', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:00'),
(311, '122370171', '$2y$10$7Gi/DL1.rIUtXwkpD1GGce8N0JuPn0D7HMov.1w53Pej6TIc4Uo2e', 'Fernando Gideon Bulolo', '122370171', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:00'),
(312, '122370173', '$2y$10$JPxhtMJ.C473NnqKH76LueGzX33i50wNNZjDRMnPMTWI21ItLfxUq', 'Yoel Pasaribu', '122370173', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:00'),
(313, '122370174', '$2y$10$98m0wwWQDrpyeWoDiMtP2e4L.bsJ5cJ0GU9MZwYbEC9xel9R3VkdK', 'Difa Aisha Zalsabina', '122370174', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:00'),
(314, '122370175', '$2y$10$n3RcQrbWx4/zcXFtA8uBm.Iqzx3AKGF10LDK61J6x3XGeV1sBomrW', 'David Pandapotan Gordon Sianturi', '122370175', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:00'),
(315, '122370176', '$2y$10$tSTQSg7HhLejxeq6l3PM0OQaJLM0PREJGGJu43q0SboSYPWJ7.Apm', 'Zihar Azhara Ketaren', '122370176', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:00'),
(316, '122370177', '$2y$10$LAldS9lvmLbp0REyhdsFd.WmuGxiAxE8uqYm/JP53u1.aKWrtmEYS', 'Juan Hardiano Sirait', '122370177', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:00'),
(317, '122370178', '$2y$10$MZqijYQQ7oV3F4h7149dIOglbFt0nxEjb5cccd8L401j1ARtAZ8QO', 'Jason Stevian Chandra', '122370178', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:00'),
(318, '122370179', '$2y$10$ujbHdpmXZPkgysKr5NHw1O7tG5hFFchRhReV.HIIbKAmwxWMUUuIW', 'Ni Made Napratilova Ivada Nusantara', '122370179', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:01'),
(319, '122370180', '$2y$10$OIrSy6H5ygaVqYmIWklGIeM9gqXUQq5G.yheQouDyUWQYRIIZNwm2', 'Dzakwan nabhan', '122370180', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:01'),
(320, '122370183', '$2y$10$2/T0vEOqsURoV5JakZmVtel3mNXoHNoNiSY8jYt20GDWgpQ9S8F0y', 'Christian N.I. Naibaho', '122370183', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:01'),
(321, '122370184', '$2y$10$zV5bPqT3Z4UySaCd0r9FBO65rqHN9HcM4ytvlWiXlw1.kh29z7ZvC', 'Chellshe kikiana', '122370184', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:01'),
(322, '122370185', '$2y$10$CxM1zwDSldI9VVGrOZBUBeW1iOssC/1Gx3WKrY4pArvv7U/ErIzvm', 'Oktaviano Buana Putra', '122370185', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:01'),
(323, '122370187', '$2y$10$y8oqtShQdD5hKCXg8mGuoOavdZjj7OSWzEd9tbFfv0JiCpL9JDvZC', 'Insan Psdysha Hasibuan', '122370187', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:01'),
(324, '122370188', '$2y$10$Qpmu1HEAaLOd7JxxkPvhTeWVQswC/VdHmJXcace.lp6tlIIY6Rroq', 'Herta Sabilla', '122370188', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:01'),
(325, '122370189', '$2y$10$g3e6AKugUelkyBkyL56GWOX0WoDd0sMUA4QKpBOwy24nZk1trkthy', 'Astri Intan Nuraini', '122370189', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:02'),
(326, '122370190', '$2y$10$zjp6OpISc9MZrPd4H9r7z.AYRA5jEKl1pDNEuMJQ1oMsC5Y8Me9bW', 'Andrey Rabu Angga', '122370190', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:02'),
(327, '122370192', '$2y$10$.5mn45yeOTtg18ip3dcnwOUA/eiZaG.jflpCU8xb5VxOj46tTZlmm', 'Ernest Ephraim Halasan Siahaan', '122370192', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:02'),
(328, '122370193', '$2y$10$3vb7S16y.daf.zBJXB73pOUKYO4xR8lW.Elzecygdbk3mdYfbmYmy', 'Claudio Bintang Siboro', '122370193', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:02'),
(329, '122370194', '$2y$10$9eBM.MRJY3ygOm02D.NdnO4wU6BowTKG0dF6pB.QfTG11Wtw/jvLe', 'Elsa Yolanda Br Nababan', '122370194', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:02'),
(330, '122370195', '$2y$10$Y9hkzFVHqU7RvvGiS69SF.kviezeqwo/.S7IhqmJTmFkcGm8D19SW', 'Rayhan Farrel Ardan Harahap', '122370195', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:02'),
(331, '122370196', '$2y$10$.ICwAdE5Izd3Ei/eW6SIe.qD4pxdoAuulF.97MRSBNi2sEJHgjQeu', 'Ulfa Ramadhani', '122370196', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:02'),
(332, '122370198', '$2y$10$RnvWr35O3NEAla9yCC4bmOUS1hWuilmj3tVW4CHwNm7eSb7hb7MRC', 'Adhira Alfaiza Sibil Firdaus', '122370198', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:02'),
(333, '122370201', '$2y$10$fBBldUyWaPTlvCCV0s/Gh.gn9OCfZgIfyRVOIKRBRCt5dHC0u.bCe', 'Iqbal Yaafi Hanif', '122370201', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:03'),
(334, '122370202', '$2y$10$q0HqX4.MZGftI34ROLF2EOhGJlT2SfOjRcaUnOrMhpt/cScS9luja', 'Natanael Situmorang', '122370202', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:03'),
(335, '122370203', '$2y$10$bCoTNgBa0yFg0HY9xh8esOyDzwFv3RNzDxfnNfYVPiuRpKHiFkft6', 'Tegar Agung Jaya', '122370203', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:03'),
(336, '123370001', '$2y$10$P3kd0P8Y4YIF5puQSzDijOHYFg7QuUsOqoTi8OFgb2uCqzWi1e/Tm', 'M Devana Marlon Adirangga', '123370001', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:03'),
(337, '123370002', '$2y$10$RvATN8Pb6B/A2.DzGtMWIOnFTMfbXr79Phwt29QmXYEl6nclrkR.m', 'Kholisa Martin', '123370002', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:03'),
(338, '123370003', '$2y$10$NChhWYrHiiQkJTKp1Hmlxu7Sz95OYNQiYeDMKC6VeeWyV8F8A01i2', 'Miftahul Husna Nafi\'Ah', '123370003', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:03'),
(339, '123370004', '$2y$10$BYdxmkqUTsYG5EWIbA.e/.tbISZC6A3ugA1ktixSE79do63F1JsmS', 'David Prakusia', '123370004', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:03'),
(340, '123370005', '$2y$10$H72qKo4poGsKN8RYkewefuYsaMg2m0t1eFW4qKdbRAF0bs4Sc/Tbe', 'Zaky Musyaffa', '123370005', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:03'),
(341, '123370006', '$2y$10$WBAyzLOpISe1nXU7f7vUJeqEI8h.ZK3jv5kfM7MEqri3UYd81W.5y', 'Via Cinta Simamora', '123370006', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:04'),
(342, '123370007', '$2y$10$acfpyJTWvATvjwY.xrNqsuV7gHxXTPwUmnLPrpWH3A7YFY5vwEvRO', 'Niken Fransiska Putri', '123370007', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:04'),
(343, '123370008', '$2y$10$savSiOynQPbpX9IuA2RwTOKG83wG./2tlxOoNmfrSUPjjwfQZlMdm', 'Debora Apriani Manik', '123370008', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:04'),
(344, '123370009', '$2y$10$FNT81RkcmfHiQowCz6qLj.88Rc2HOjLSHmyssKmP7YqWT.6dMOf6u', 'Erga Wiradinati', '123370009', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:04'),
(345, '123370010', '$2y$10$OvrwBHWh6XVtwIFwYTNxMe1eL6W5Z/A.ObKqmFq2WEhBFnN6SphJm', 'Chester Yabes Aldrin Waruwu', '123370010', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:04'),
(346, '123370011', '$2y$10$ADaC0LuWjvtmnaIrgsCbGO52ob64Q9rKj51WXwFhbrojngpJsZNme', 'Yubima Lucia Sidauruk', '123370011', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:04'),
(347, '123370012', '$2y$10$1nfh67UogSqcOQz8yBms/uirYyP64iPmkrKAR4emcWPRX.Q6Chnx6', 'Adzikra As Shidqi Putra Ahyudin', '123370012', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:05'),
(348, '123370014', '$2y$10$asfl4Xela24opamEjllJOu.BJ7uvCay3A5iCV4jN93H2GAgwNymde', 'Grace Tamara Simbolon', '123370014', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:05'),
(349, '123370015', '$2y$10$EZvsC1nj9fruXV3r646i7uVZYjImqNEjycddiPInIjKqO0GW4aaDu', 'Divha Elvina', '123370015', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:05'),
(350, '123370016', '$2y$10$Bi9GE.A1hlwhVaxmzvQ5EuSjpsT72n0mym4ESG5ohm0pRSanpDSz2', 'Jihan Mutia A', '123370016', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:05'),
(351, '123370017', '$2y$10$23/2RTwMdEsOSxslN6JDaO/kxxBmtgsEUPma2NtK4J4XbV0BZfaV2', 'Didhi Prayoga Simanjuntak', '123370017', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:05'),
(352, '123370019', '$2y$10$/A9uM9LibF64RSM8z6otgOIRIpH0voATM5TaY3gjHKg1KDkh94JYq', 'Sherly Dwi Septikasari', '123370019', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:05'),
(353, '123370020', '$2y$10$9x.AdIIrTX2WsotBUmOse.0Icwm8scuzIFUiELknthnNfOrjrwD.C', 'Leo Gusti Randa Tarigan', '123370020', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:05'),
(354, '123370022', '$2y$10$STQP3w./VqH5vQFlLKkA0urXZQD9QN/yThkw9zM3FNCVv2N58HPq6', 'Yesika Julianti Tampubolon', '123370022', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:05'),
(355, '123370023', '$2y$10$Q/A5DnsRS7okk7OvmiU5zuimrKmuytpD8Z1sigUqpXyui9IyyCpym', 'Hanif Nur Alfian', '123370023', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:06'),
(356, '123370024', '$2y$10$1B6B6Xd6inxhOxAhMDZEseCKDVnefwC7lKokNT92ogPeDhYLJ420i', 'I Gede Eka Surya', '123370024', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:06'),
(357, '123370025', '$2y$10$dlV3spTQbLhyvLXstQV7B.Nb1uUyxYaKSWigY9goC/zQXS7rg3o0K', 'Tio Berta Br Sirait', '123370025', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:06'),
(358, '123370026', '$2y$10$7cIxE9lk82xK8b5z7EdcEecYcFSBkkRED7zzS4EIsu2qVKwcM5V4i', 'Teguh Divanda Putra', '123370026', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:06'),
(359, '123370027', '$2y$10$6rvOAH54Sc8k92vcdeiAv.hf67ipKZhXe5Ndg.sy4UWS3SRcNE8gm', 'Ammar Faishal', '123370027', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:06'),
(360, '123370028', '$2y$10$DFONlzasw79jUi3S55LEuu8YMk9KVXOn9fpaWFw8odxRmx.vvQUyW', 'Silsi Ramadhani', '123370028', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:06'),
(361, '123370029', '$2y$10$ds4W9ZvWGYy7oGzCCSdQBOz7x0TW40ZtiiZ.r0T5PcMOMOanji0Na', 'Zaki Ramadhan', '123370029', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:06'),
(362, '123370030', '$2y$10$4niB18Z0R965y9gXDao7kO9IkZeynnZmA0EsOwy8lu8A7ZXZj1YzG', 'Windry Meidi E Tinambunan', '123370030', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:07'),
(363, '123370031', '$2y$10$RNO1rtX.T/SFF2nH3h0.gu7KajRGBuToGfcaVHveh.fogdIYpzBca', 'Nasywa Azuhruf', '123370031', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:07'),
(364, '123370032', '$2y$10$2mOq.KIqe6O1x5kkLaajM.Tqu65tVau6qt2FbhpnBtuQ5GGi7.kqW', 'Reski Putra Liandra', '123370032', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:07'),
(365, '123370033', '$2y$10$KnitSNc0KdBsKhiRqsRJdOhtcoTQYbHelpXCCFqKqm.VYUAVTpa7y', 'Amanda Destiyarika', '123370033', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:07'),
(366, '123370034', '$2y$10$04aGXzhCJYIdLHGFHZfxheSxk.gZ7/y.Y7GikgaOfPECnjScbtLSm', 'Faqih Ananda Putra', '123370034', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:07'),
(367, '123370035', '$2y$10$9hz90qV3pBIf184zLx2iHuDggGNAfX.xwHJOj.hXYLyqx3Qq3SjFa', 'Ariel Azizul Hakim', '123370035', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(368, '123370037', '$2y$10$RtglFHcud64FWfqilrIRw.J/xt7zG2wpEHald2pU25RD/FkmxXTT2', 'Aeryn Lidya Sihaloho', '123370037', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(369, '123370039', '$2y$10$xqsYmvGkEqK9O5GXJ7ur4eP6H6zF19x6kuuRNZ2dmE0PKueh9rS1O', 'Selva Feprianti', '123370039', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(370, '123370041', '$2y$10$.QpijyROMTA..PmguUp7EeHIae7VJ58FmjkiMMWWXLeV0YWnF9rqK', 'Ryan Satrio Dewan Dono', '123370041', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(371, '123370042', '$2y$10$ovQjViFDlVpYsxLw.5XexOFvnQ.GGBgMJloHKgaR8KZVGJsYcfbDq', 'Dicky Ferdiansyah', '123370042', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(372, '123370043', '$2y$10$KGOgfwAKidpX3Z.EGIK68uQG.I1ZyrsW0iST2lOoJyLCQbgrCKvoC', 'Rifqi Kurniawan', '123370043', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(373, '123370044', '$2y$10$AdX1ipBew1FOV6uZmBAwIeI6vS.tzt2b2dsoQFB44e5jwAyjEFHtC', 'Diah Berthania', '123370044', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(374, '123370045', '$2y$10$dZLI7MI1WJiqDAolMlEFXOVhTXMjzifodHLsZ75o/6jzy3npLkUbS', 'Lukman Denni Geonando Pasaribu', '123370045', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(375, '123370046', '$2y$10$qg4miAaFbRd9co2H66GtruhVzP2OSJWBdDi8VIYKH/GL.fJHDH4YK', 'Johannes Sihombing', '123370046', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:08'),
(376, '123370047', '$2y$10$nX4dvpaA.G1syf6YB95wqerwHHkaxs..DPT8gmV3BawRomF3YC/Jm', 'Ikhwan Najwa Baidillah', '123370047', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(377, '123370048', '$2y$10$AxGUWhYERr7W2cDXa/Te0.4QwBgBDehylAGkTJEJJRcZn/CA6S1Qi', 'Martin Delon Nainggolan', '123370048', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(378, '123370049', '$2y$10$yyjm9RSc8Q/GMcc6b/NFRO9C4UHGTUyLItEqfKsIv23axI5P4iLrC', 'Vina Velisha Anjani', '123370049', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(379, '123370051', '$2y$10$ZhjphzQVek3tyUGmH5fdhuAuTr9dq.LRcmEmfPRtXJVPimXl.t2LO', 'Naomi Cecilia Anggraeni Manurung', '123370051', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(380, '123370053', '$2y$10$EG.m3y6m0Fnlt4xTB0IsX.cPrcB4DreB97lM06CgCmJ6DPs17rgim', 'Willy Alvares Lumbangaol', '123370053', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(381, '123370054', '$2y$10$fuOaDiaUmHRE99XcHhmMnedWU8/HuwPnOC1cL60wcf8bhES59Zamy', 'Masta Hendri Setiawan Lature', '123370054', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(382, '123370055', '$2y$10$gK0G7P6OLmnThEy/yFR2PuULuUy4OUw4woNQCyMuPTAbmVtvsZT7K', 'Rafi Arya Antawah Al Faturrachman', '123370055', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(383, '123370056', '$2y$10$X/v3JIYGpmouw068hhSA6eGyEEOFB5cvDIfPkqR6NqLKixmFpkIbO', 'Yopie Nathanael Sitohang', '123370056', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(384, '123370057', '$2y$10$tSj0yjAobPlzQd4oMXxiGehaM1EQW/8e2l9AR4iX41fET3h0naP6.', 'Dwy Hanna Manalu', '123370057', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:09'),
(385, '123370059', '$2y$10$5WNdVlot9YsQqbg7W8bQ0evLqtufvw2.fFDPioZJwOHbob.I3byDi', 'Raymond Panjaitan', '123370059', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(386, '123370060', '$2y$10$pdHuRFWoh1NbiCt5xDbEjeDwqKxJw3/y3wV9/BZLmyV/0rNrdoUxa', 'Rendy Jerika Putra', '123370060', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(387, '123370061', '$2y$10$wIze1KxG042YE47otkcaFutE/ZXRvfSSe9RBpvkPAqBdX2o4ecN.C', 'Wily Gray Theodorus Sidabariba', '123370061', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(388, '123370062', '$2y$10$N003OYLoNempoVRxhnrJX.9XT9yDXP8rF8pwoYMqKMcNdw/9a/1KO', 'Josua Lefrand Napitupulu', '123370062', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(389, '123370063', '$2y$10$w8IfXTDeX8Z2O1nyIZXstO5z0wBVEW9yLkShFL3uCkslVUbMy8ZhG', 'Jona Batu Tarigan', '123370063', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(390, '123370064', '$2y$10$LLb6KZWyjxr5z5kUyDDnMezZsfK3KM4WUJwRtqmMIjrtKgRcJBX1y', 'Christoper Sitepu', '123370064', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(391, '123370066', '$2y$10$sZaMBH.9xtLlbwHVf0qboe669jznvbwyRY/1KIbvuAZfvkRFk3.oa', 'Deslan Sihombing', '123370066', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(392, '123370067', '$2y$10$jXOqr6K/M.EAHBGxyXkyGe85uP78dDqsp572V9YOOSrJ0akkOguSW', 'Simeon Peres P Aruan', '123370067', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(393, '123370068', '$2y$10$z2xghSmigAcjJ3vyyUWRW.81q1te2aZfpAnoEbw5qXkf3ofSWw.DG', 'Putri Intan Ramsiah Simatupang', '123370068', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:10'),
(394, '123370069', '$2y$10$3SdvUQfnCxVkCQAdGaLds.Rgpw6im2pRGuvwfrCRUg1oym0tRmzQO', 'Raja Haposan Ami Naibaho', '123370069', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:11'),
(395, '123370070', '$2y$10$/lf68ooEWUKGufEfWEg7u.dSPzD4pgwGfFGBF9sc2A88x/ifWrpzS', 'Ade Ramadhani', '123370070', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:11'),
(396, '123370072', '$2y$10$DYl8pvb/FCeHej9Opq2i5.be683KtNzRrYZ8iN3NM.piRNkYBtvcS', 'Michael Putra Barus', '123370072', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:11'),
(397, '123370073', '$2y$10$QWO/JqCiUh5zC/n7jDw54.tiDnQZwPoRNFRvBtc73t7RcPrFaesmq', 'Patrick Purba', '123370073', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:11'),
(398, '123370074', '$2y$10$lgaD6w6bby9BQRwd4hYmYuBFmC9pWTHRJjRpM.HSwuyIgam/c9RhC', 'Reynaldy Ramadani', '123370074', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:11'),
(399, '123370075', '$2y$10$C0WzSmAdG.T3DRVC5XIJWe/vNqUYEM8gRgikytN4IpZ4XeIFoHTUu', 'Simon Petrus Hia', '123370075', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:11'),
(400, '123370079', '$2y$10$hg2kAj4ITjZA392mOVK66Oq7YZ8gL.xkCpz4EYllo8yXaoznXvTK6', 'Mesi Anggryani', '123370079', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:12'),
(401, '123370080', '$2y$10$BBu.EXgRrPeYzmNdhAHPT.q/YxUylzuvMS1N/1wAJSutx4MTnVl8m', 'Raja Putra Desriyan', '123370080', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:12'),
(402, '123370081', '$2y$10$iy2M6gl5n3IdsoxCgg0hGOKYeDIE2sVAjBHw1FI3ooNOKVPq9fsia', 'Kania Putri Maheswari', '123370081', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:12'),
(403, '123370082', '$2y$10$msaFcAqOIFtxJsdprIupOeaS/2OSc7Gww5taORfGuctd/wYaAt.yG', 'Moses Benediktus Sitompul', '123370082', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:12'),
(404, '123370083', '$2y$10$d0bw7ay5AqOi1XN8YCkGLOXku9rjglbdU35e5wpud.GxVFcLvNgDW', 'Aniskurlillah Putri Santoso', '123370083', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:12'),
(405, '123370084', '$2y$10$LnwYpINpOXU7/F306vA0ke8XIbihXzJwKF2WgcxHLc2R5IubLYeK6', 'Nabila Alya Salsabila', '123370084', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:12'),
(406, '123370086', '$2y$10$5o35lq46/Ri4rlrpScz4m.YnEOEKOYzuvBV6J5d.Uj2LZ6R4yNxm6', 'Fajar Dikara', '123370086', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:12'),
(407, '123370088', '$2y$10$4CXij2FPZm37LDPCQMzDgOBZ2Yg34afv7/Jb7hwu4U/vKMBGujaEi', 'Wayan Dicky Adiyaksa', '123370088', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:13'),
(408, '123370090', '$2y$10$zpYtyec/5RNceB5r47Uv3.is1.85XEDl1FtXhJv5xnWS2nFKQVmlO', 'Michael Jeremia Sitinjak', '123370090', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:13'),
(409, '123370092', '$2y$10$Y3/8b1wWLucrBH1GWb6lAOYodH2/8.Zv9quKvoAPHgcmH9Y9UYjwu', 'Angga Pratama Silaban', '123370092', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:13'),
(410, '123370093', '$2y$10$p2RJ5N0fvFEucaJcAnbyNuqOBhEz6Vy1FRjtCFmJzULyLRqQPsfaG', 'Muhammad Zizou Alfarisy', '123370093', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:13'),
(411, '123370094', '$2y$10$Gs.OUbU48xuNkM9G/7ARxuypfPEcGCFIpcAyUSN89f8rfZEGf7vBi', 'Hizkia Seven R M', '123370094', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:13'),
(412, '123370095', '$2y$10$3o2m7203HZIh2sXKeHqPPurFAtbHACcmXff7nw964j1ohDKJSJjTi', 'Muhammad Sanjaya Ardy Wibowo', '123370095', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:13'),
(413, '123370096', '$2y$10$a8qtcHzhjJyEDG9d998cGuORA.01t3cbfVzaxSd6RtdGbLRfTykya', 'Afif Rizki Hasibuan', '123370096', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:13'),
(414, '123370097', '$2y$10$fVZVmHI9ZDhU0qPRAQe7zeE4OoWGOzQSuU/HqP7bzD9OV2UqcpODi', 'Zetro Pangihutan Parlindungan Sinaga', '123370097', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:13'),
(415, '123370099', '$2y$10$drWHL7.mnbR6ZN3BhR36Yutz1ODgHQLozx8gfy5Y9ywMmZY6z04nC', 'Edo Junata Perangin Angin', '123370099', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:14'),
(416, '123370101', '$2y$10$QJ2cfV5YBLezEWEWe5eA0eqwR2MCXfRk5VMuE7xhSHmfucK8w/j7S', 'Asti Pricillia Safitri', '123370101', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:14'),
(417, '123370102', '$2y$10$iaRIKqapQ7Ar/lzO868Vfe.ZuRBkN0gWrMipD19VZqVyO2cLKQum6', 'Yoel Manaek Lumban Tobing', '123370102', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:14'),
(418, '123370103', '$2y$10$zRyB5ztFvYCFset/nb.bTuI0LfwppaZv.H5bsctJZhjRL6BauY4GW', 'Syakila Rahmadhina', '123370103', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:14'),
(419, '123370104', '$2y$10$rC1WruoAHQ2a/lTZDG5r2ODlyuX5sRoHmV73qqjkSAJa88VCa4Z0e', 'Bharadipa Wirapati Jimbaran', '123370104', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:14'),
(420, '123370105', '$2y$10$liOxarWiNagmhipqJx9laOFSDl0gQoCgIQF2syNbHRpYqhDc/7CYq', 'Jansen Imanuel Simanjuntak', '123370105', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:14'),
(421, '123370106', '$2y$10$6htcKWN1prhEj8gFMneTS.DwqvQreWYbltQPGefmQAZDWRKAzNTyC', 'Malka Ananda', '123370106', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:14'),
(422, '123370107', '$2y$10$G79yiov11kcFUtTZVSmjz.oalnlctP/VAA3UIbpB7vwp8b.WxW.By', 'Axl Phoenix', '123370107', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:15'),
(423, '123370108', '$2y$10$zx92d1pyGw0uOczCnYD8MeZneMHJH3GctN9IaERp1pwHbQ4s42Y8C', 'Helvran Angely', '123370108', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:15'),
(424, '123370110', '$2y$10$E8K0jt/ldAiR4U/d.hbtSObjCZwekWy.qIsuAvm0Vh1w7wqOf07ma', 'Santa Olivia Pardosi', '123370110', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:15'),
(425, '123370112', '$2y$10$iHABguYmzLqInPsJ66ICzeLoFfVSqHGwgU/0WGsCuCAoqtOqV3XDG', 'Rafli Nanang Firmansyah', '123370112', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:15'),
(426, '123370113', '$2y$10$aSuoxuaOPWPtzgxVbB4cvuOLnLP7qRvJ1I2yVf9LL3V.YnF/8kfsC', 'Adib Ramadhani', '123370113', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:15'),
(427, '123370115', '$2y$10$uVE1CQcsWEcMw0PxMBXpBOvikWoukz2Gp7Co./7hqIhMtuB9ml.we', 'Amelie Nabila Putri', '123370115', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:15'),
(428, '123370116', '$2y$10$VMI1nfmeL6RLiFDF5MZU3e1l9R306MgJ700RItUMudJNcUKXPmAEy', 'Yulia Mardiani Putri', '123370116', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:15'),
(429, '123370117', '$2y$10$swe5PINh7ADPRWSd5j6TYOx4sgO00c5kzjWDS0zowL.HpgnbPLuC.', 'Sulistio Cruz', '123370117', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:16'),
(430, '123370118', '$2y$10$r2JYoEf7xigwnkp3g79vXumj1rzY350NHUK1Jl8lzcXJzVTIRdAzi', 'Kefas Halomoan Sihombing', '123370118', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:16'),
(431, '123370119', '$2y$10$BEiYcKu8gTbCr7OR.T0fWeNt2oPQFtzhaCYDuB4WdP/fGwCrsN3yO', 'Anggi Anatasia Boru Silaban', '123370119', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:16'),
(432, '123370120', '$2y$10$qZA8HISTF6DFIj1AcL9tceORFcWBFqOn63F5kJffmWNH0ZvONSylu', 'Kuntum Khaira Ummah', '123370120', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:16'),
(433, '123370122', '$2y$10$7O6g/AivBJyDqMifXUxdtOEB5U8tsTOHfg1hlRz/TYqycI5C0IqPi', 'Rizqi Ramadhan Putra', '123370122', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:16'),
(434, '123370123', '$2y$10$nbNXJtPPKpH7EDAQKgTBg.phEXQZBVpwSONSjlLCG85qoEMa166oG', 'Muhammad Akbar Maulana', '123370123', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:16'),
(435, '123370124', '$2y$10$R8QS6gXD9q54NTRoGYifCeEsAJXOgIVcIdMf9x3DRIJ50PJRTopq.', 'Shintia Juliana Sihombing', '123370124', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:16'),
(436, '123370125', '$2y$10$hLsex0P4FPaiBzzZUw6VTeclPh1sMjJo.rs38ST6lSR.ofXbUASlO', 'Alessandro Delpiero', '123370125', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(437, '123370127', '$2y$10$JbkOGM3UqIOWEELpi9IFL.fC.BYPe.Rdp6uswVO8Qo9goQXYJTWjO', 'Wahyu Dwi Saputra', '123370127', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(438, '123370129', '$2y$10$p2HLKaob3/.vlTGWgWrwl.4Nr0PSk/1F6AMC8OK7tH5ZWolHRRcDy', 'Kiyan Sajid Ramadhan As', '123370129', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(439, '123370131', '$2y$10$c/Kk555h0n0..nwnIWIbrO6/KFgdx3ZN.3IifR.G9xmPh6mq1cREi', 'Allysia Arta Risqani Manurung', '123370131', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(440, '123370132', '$2y$10$u2RHduYnpvHrqO8QdVISbubeYuUjeu85mMJ9AqA5Tq295wmN53rnq', 'Ikhwan Ferdiansyah', '123370132', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(441, '123370133', '$2y$10$4s./GLK8gsxZqJxGN06Wu.xV10U6wNAbmHm14uMcHKeYKeK.klkGS', 'Zepora Vania', '123370133', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(442, '123370134', '$2y$10$EKL1SF1/bFcnUxPbwGc1telET7hGb10m6/OJ1JqVaJM4JOflI4lsS', 'Rifqa Amanda Roosmeilia', '123370134', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(443, '123370135', '$2y$10$Y3dsOQ029OUWHu3oJONwGe6H6H.VVi/T/n6NFQIDqsyUDdTYDaR2O', 'Brigita Zabrina Zefanya', '123370135', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(444, '123370136', '$2y$10$PZXPbZXHO.1hW1ErBVAYLuTYKxsBfsVyOpYrGvOfnPxyirBZ9vTQm', 'Abdurrahman Zidan Rizki', '123370136', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:17'),
(445, '123370137', '$2y$10$QEGFp5/4tPGhJP/vFiV6a.OK46UtuqI0u3bx48Wsf4q6G6HIw/exy', 'M. Nur Wahid R. Siradj', '123370137', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:18'),
(446, '123370138', '$2y$10$lpf2pS6bwiIrJY/DFtvdxe8y4vZxmOvBB3U1B2PFW1fhLbrdxpI0G', 'Adrian Reyvaldi', '123370138', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:18'),
(447, '123370139', '$2y$10$KHPGkJXH8J8IdK4vHehb3u2/tcza9IMr8Ky6YURW3faH6dpw7gV5C', 'Dwi Salsa Billah', '123370139', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:18'),
(448, '123370142', '$2y$10$cHXnPrHk2qsoW9j.vYD94.N1.0HXnK6yVEKSaL9dSlrUL.R2.Wi8y', 'Roy Martinus Sidabutar', '123370142', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:18'),
(449, '123370143', '$2y$10$yFI8F7AjauUM7iUdPYAtPuOxjMIHFvzInq6wbvwnGDcrF9EPWalAW', 'Habib Al Fadli', '123370143', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:18'),
(450, '123370144', '$2y$10$Sl/DydUFYr8PwYZS44t3l.QeBiKfwvTYpr60IP0rEVQ.1Ek5aPlxe', 'Muhammad Hikal Al Rosi', '123370144', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:18'),
(451, '123370145', '$2y$10$OdWzL8VocxkAaG5O5jZY8uD1Rc3Una56yRtUoq6Dy2ieJIcqXsFTG', 'Saddam Husein', '123370145', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:18'),
(452, '123370146', '$2y$10$2xr/HTfwSNcVPH6Dn43CMeIz8o5srEzvi35pEiYKHiMqUHjLIJPtK', 'Dimas Mahesa', '123370146', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:18'),
(453, '123370147', '$2y$10$dinGiGMTBVUyqDrQhJsMqe76.fNNBsVk8xKSnueG4/YslF99wRhvK', 'Amrizal Efendi', '123370147', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:19'),
(454, '123370148', '$2y$10$/VCI9ZygdwZtZ5oaWtOIp.FzNyoSEteryyxbFAVYswBFUgF.bCKFS', 'Muhammad Rollie Averill Widyawan', '123370148', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:19'),
(455, '123370149', '$2y$10$ALear9qkW63uriXDCMvnXet/s1iqCHml/b3xJ0S7v8HJLrB2RCilm', 'Bilqis Haafizhoh', '123370149', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:19'),
(456, '123370150', '$2y$10$eKupQwY0TeI8iDZA4KAqu.eXYJmHv.12/gGcQuJPgSRs2T41clVN6', 'Muhammad Ardiansyah', '123370150', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:19'),
(457, '123370151', '$2y$10$njyWtg6kooEXvhjPZknIS.au5ubEBVQpI73uB3uMmiH1JQHEAQUn.', 'Ikhwan Nawawi Ahmadi', '123370151', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:19'),
(458, '123370152', '$2y$10$4dAolOZ1DYIDqJcgu8Z15.vtunTq0OYvazbOU8LJ685GcEvarjNHW', 'Virgoes Yehezkiel Sibarani', '123370152', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:19'),
(459, '123370153', '$2y$10$VW7E2JvlO78O23VO.grVduznUvxs8kYgxcWdKlsNsx3H3C.vBkF6G', 'Monica Laraswaty', '123370153', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:19'),
(460, '123370155', '$2y$10$1x4ZwStXK9dZR5u5wW3T3u8sxzwOBxPzSOJ9fjdKMcsULe/Aae5SO', 'Jonatahan Christofel Siburian', '123370155', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:20'),
(461, '123370156', '$2y$10$cp8ipIJ8x/bA/vno3ixId.EdtfxaghCK/Wm4UBHcyXMBeLHZdioIW', 'Yosia Cendanawangi Putri Dwibiyanto', '123370156', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:20'),
(462, '123370157', '$2y$10$zdae93ajidPkgk3a4aNcPeeCQGiJy.szKbBN/Jp.murLX2.gVcqDm', 'Khezia Talita Maren', '123370157', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:20'),
(463, '123370158', '$2y$10$zp63f1ooX6ZeYnIOjPxhk.ubgse74sbiYrpPOMEt8lToskaCA3IG.', 'Falyas Pradana Yoe', '123370158', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:20'),
(464, '123370159', '$2y$10$YTYyPHnrv0ON2jWR4CU1b.OPs/LtekPQzb4T9CN9JBvWt56X..fOa', 'Faathir Raditya Hidayat', '123370159', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:20'),
(465, '123370161', '$2y$10$kWkGK6Z/fgVBv8vKo/Ig0OrhFitfjVPLzNWjRkLd6WXFdig2zcMI6', 'Ocha Naisa Ramadhany', '123370161', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:20'),
(466, '123370162', '$2y$10$7bpMVf9eC3TCO845nMLgF.xRAHtjWjl120X3tmq6Yhm7gUrx8Jhom', 'Yaffa Revadila', '123370162', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:20'),
(467, '123370163', '$2y$10$2M0RIViipa2yG.Dn/lRyUuPNuRYrEzFjZsKymwVCIzWaoJuf7Zq56', 'Fikri Muzzaki Al-Fathin', '123370163', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:20'),
(468, '123370164', '$2y$10$ehXLNLUJo/J6swzZwDZUoe9CYM9DjH9gBuF3qmfO62qXbQcaxzTnq', 'M.Rizki', '123370164', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:21'),
(469, '123370165', '$2y$10$v3dv2Jl2kI6fMrOeRT4TTOJokp5a0ucAA.uQzx9.aAULR.ReaOBxW', 'Mhd Rasyid Asshiddiqie', '123370165', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:21'),
(470, '123370166', '$2y$10$1gjpGE6ejdMUZD9y4zORsOOssXu02X0MJjrulRK1Z098XlJVqdAey', 'Duta Raditya Hani Hartono', '123370166', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:21'),
(471, '123370167', '$2y$10$QPRu1rBQ3D7ppw0qrnfiFOHsIqaLk52sRjo/7cHzBaDpk/bEcnVx6', 'Yongki Prayoga', '123370167', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:21'),
(472, '123370168', '$2y$10$YqWN5KwcicI1fxQuwnclOuQPQXV7vqqWIbGf22/G7bgdy9t0LtNea', 'Muhammad Fatir', '123370168', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:21'),
(473, '123370170', '$2y$10$dDbz1leESbqNbzbis2sVe.BZptfvrYRR4sVNPkuecNkXea9aBEvT2', 'M. Dany Nurdin', '123370170', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:21'),
(474, '123370171', '$2y$10$lNhlqGYBea7lYFbN14P.TO.NrYpRsLqewE3hasN9TyADgvp7u3uEW', 'Delima Romaito Sirait', '123370171', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:21'),
(475, '123370172', '$2y$10$I81Tbo9FE2gXKFoW8ydz9.qDLTpnYsCTCKapKfKOTL4Ctrh7H4vmK', 'Alifansyah Hashfi Albana', '123370172', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:21'),
(476, '123370174', '$2y$10$363Q5aLYNxROfcF092dXe.6Q4Dx95ztUw9ge4ADyPUk7OL8c2Pd02', 'Muhammad Fathurahman Mansiz', '123370174', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:22'),
(477, '123370175', '$2y$10$2tadbz2E7/IXuV5MnY/zROIIP74jTTKdTLSri1Sy2sF72uJlNU13.', 'R. Adam Zasya Yudho Ghiffari', '123370175', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:22'),
(478, '123370176', '$2y$10$mWLra.QMm9wYQAjd0dpfcOtIjNM8n5sgoWIDtN./sJQ9OiniD2x3S', 'Rizqi Aji Darmawan', '123370176', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:22'),
(479, '123370177', '$2y$10$Zd1JZJZ1jJvBOjufRbqLYOuGsQ.vEkIPyq94Uh6imBG0x5Mp2cxSS', 'Zidane Andariski Syah', '123370177', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:22'),
(480, '123370178', '$2y$10$7HQbLJNBx9ydN4cjU/hMuuTo5PhO8GgkJjeK6ItrgRxYZKHSs5oFe', 'Richter Abednego Nussy', '123370178', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:22'),
(481, '123370180', '$2y$10$/0PI91Rn9D/BpEALo5Imz.p.pcIiRTA0oZ.INNaF95mNH5wZBYXGe', 'Mikha Aditiya Saputra', '123370180', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:22'),
(482, '123370181', '$2y$10$Psr8ZiidzVTFGepae/cNAeTwjnxVvmK8mOwv7ue1le6I5wHNdOHVy', 'Mikhael Jason Simanjuntak', '123370181', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:22'),
(483, '123370182', '$2y$10$tmXnbmjQGYmWhPOcwusrTeH8p3eS2iiAC14vsc8cG8Qq9nb.PXcp2', 'Mario Siwomigo', '123370182', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:22'),
(484, '123370184', '$2y$10$Ol1gd/Ey91krBYNlz.ByPu.TsMLmYCH9iV1NUPU0yLq.ghpfxpudu', 'Asrofa Aziz', '123370184', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:23'),
(485, '123370185', '$2y$10$6RpibVWR7VGZ7oPdUvlvGu93cnXAsCrSA4.UlGJ0cFoszJpHD3bHi', 'M Rizky Putra Ramadhan', '123370185', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:23'),
(486, '123370186', '$2y$10$ZVFSSSlsst0fDtReQKoKYuZBcNVbndyXc2IEDXmfxzW0OAGa6Nvky', 'Nazwa Alya Albazami', '123370186', 'Teknik Pertambangan', 0, NULL, '2025-11-14 15:21:23');

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `id` int(11) NOT NULL,
  `voter_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `posisi` enum('kahim','senat') NOT NULL,
  `voted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `voters`
--
ALTER TABLE `voters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `nim` (`nim`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `voter_id` (`voter_id`),
  ADD KEY `candidate_id` (`candidate_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `candidates`
--
ALTER TABLE `candidates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `voters`
--
ALTER TABLE `voters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=487;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`voter_id`) REFERENCES `voters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
