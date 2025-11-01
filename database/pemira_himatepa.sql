-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2025 at 02:41 AM
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
-- Database: `pemira_himatepa`
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
(5, 'voter', 1, '2021001', 'Login berhasil', '::1', '2025-10-27 01:36:09');

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
(1, 'admin', '$2y$10$9pJji3TVG7.b2C5sruEtpufUcoBC8RHs.LAq0rKmIYzxeULKi.2VG', 'Administrator Pemira', '2025-10-26 15:49:36');

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
(1, 'Ahmad Fauzi Nugroho', 'candidate1.jpg', 'kahim', 'VISI: Mewujudkan HIMATEP yang solid, progresif, dan berdaya saing tinggi dalam mengembangkan potensi mahasiswa Teknik Pertambangan.\n\nMISI:\n1. Meningkatkan kualitas SDM melalui pelatihan dan workshop\n2. Membangun networking dengan industri pertambangan\n3. Mengoptimalkan fasilitas dan sarana organisasi\n4. Menciptakan program kerja yang inovatif dan berkelanjutan', 'GRAND DESIGN:\n1. PENGEMBANGAN SDM: Program training, sertifikasi, dan soft skill development\n2. KERJASAMA INDUSTRI: MoU dengan perusahaan tambang, site visit, dan job fair\n3. KESEJAHTERAAN ANGGOTA: Beasiswa, bantuan akademik, dan pengembangan karir\n4. DIGITALISASI: Platform informasi digital dan sistem administrasi modern\n5. PRESTASI: Kompetisi nasional dan internasional di bidang pertambangan', 1, '2025-10-26 15:49:36'),
(2, 'Siti Rahma Dewi', 'candidate2.jpg', 'kahim', 'VISI: Membangun HIMATEP yang inklusif, inovatif, dan berintegritas untuk kemajuan mahasiswa Teknik Pertambangan.\n\nMISI:\n1. Memperkuat solidaritas dan kekeluargaan antar anggota\n2. Mengembangkan riset dan inovasi di bidang pertambangan\n3. Meningkatkan partisipasi mahasiswa dalam kegiatan organisasi\n4. Membangun citra positif HIMATEP di lingkungan kampus dan masyarakat', 'GRAND DESIGN:\n1. KADERISASI: Sistem mentoring dan leadership training berkelanjutan\n2. RISET & INOVASI: Penelitian, jurnal ilmiah, dan paten di bidang pertambangan\n3. PEMBERDAYAAN: Program entrepreneurship dan UMKM untuk mahasiswa\n4. LINGKUNGAN: Kampanye sustainable mining dan green campus\n5. KOMUNIKASI: Media center, publikasi, dan branding yang kuat', 2, '2025-10-26 15:49:36'),
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
(1, '2021001', '$2y$10$27Z3uFV8lnEXHATPuuXEu.8fz/gQb2Gwdj3KmyBW0n6aD70Lje9ei', 'Andi Prasetyo', '210010001', 'Teknik Pertambangan', 0, NULL, '2025-10-26 15:49:36'),
(2, '2021002', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Budi Setiawan', '210010002', 'Teknik Pertambangan', 0, NULL, '2025-10-26 15:49:36'),
(3, '2021003', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Citra Dewi', '210010003', 'Teknik Pertambangan', 0, NULL, '2025-10-26 15:49:36'),
(4, '2021004', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Dian Kusuma', '210010004', 'Teknik Pertambangan', 0, NULL, '2025-10-26 15:49:36'),
(5, '2021005', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Eko Prasetyo', '210010005', 'Teknik Pertambangan', 0, NULL, '2025-10-26 15:49:36');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
