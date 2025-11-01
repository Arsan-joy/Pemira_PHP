-- Database: pemira_himatepa
-- Sistem Pemilihan Raya Himpunan Mahasiswa Teknik Pertambangan

CREATE DATABASE IF NOT EXISTS pemira_himatepa;
USE pemira_himatepa;

-- Tabel Admin
CREATE TABLE admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Pemilih
CREATE TABLE voters (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    nim VARCHAR(20) UNIQUE NOT NULL,
    prodi VARCHAR(100) DEFAULT 'Teknik Pertambangan',
    has_voted BOOLEAN DEFAULT FALSE,
    voted_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Kandidat
CREATE TABLE candidates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    foto VARCHAR(255) DEFAULT 'default.jpg',
    posisi ENUM('kahim', 'senat') NOT NULL,
    visi_misi TEXT NOT NULL,
    grand_design TEXT NOT NULL,
    nomor_urut INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Voting
CREATE TABLE votes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    voter_id INT NOT NULL,
    candidate_id INT NOT NULL,
    posisi ENUM('kahim', 'senat') NOT NULL,
    voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (voter_id) REFERENCES voters(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
);

-- Tabel Log Aktivitas
CREATE TABLE activity_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_type ENUM('voter', 'admin') NOT NULL,
    user_id INT NOT NULL,
    username VARCHAR(50) NOT NULL,
    activity TEXT NOT NULL,
    ip_address VARCHAR(45) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Data Admin (password: admin123)
INSERT INTO admin (username, password, nama) VALUES 
('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator Pemira');

-- Insert Data Kandidat Kepala Himpunan
INSERT INTO candidates (nama, foto, posisi, visi_misi, grand_design, nomor_urut) VALUES
('Ahmad Fauzi Nugroho', 'candidate1.jpg', 'kahim', 
'VISI: Mewujudkan HIMATEP yang solid, progresif, dan berdaya saing tinggi dalam mengembangkan potensi mahasiswa Teknik Pertambangan.\n\nMISI:\n1. Meningkatkan kualitas SDM melalui pelatihan dan workshop\n2. Membangun networking dengan industri pertambangan\n3. Mengoptimalkan fasilitas dan sarana organisasi\n4. Menciptakan program kerja yang inovatif dan berkelanjutan',
'GRAND DESIGN:\n1. PENGEMBANGAN SDM: Program training, sertifikasi, dan soft skill development\n2. KERJASAMA INDUSTRI: MoU dengan perusahaan tambang, site visit, dan job fair\n3. KESEJAHTERAAN ANGGOTA: Beasiswa, bantuan akademik, dan pengembangan karir\n4. DIGITALISASI: Platform informasi digital dan sistem administrasi modern\n5. PRESTASI: Kompetisi nasional dan internasional di bidang pertambangan',
1),

('Siti Rahma Dewi', 'candidate2.jpg', 'kahim',
'VISI: Membangun HIMATEP yang inklusif, inovatif, dan berintegritas untuk kemajuan mahasiswa Teknik Pertambangan.\n\nMISI:\n1. Memperkuat solidaritas dan kekeluargaan antar anggota\n2. Mengembangkan riset dan inovasi di bidang pertambangan\n3. Meningkatkan partisipasi mahasiswa dalam kegiatan organisasi\n4. Membangun citra positif HIMATEP di lingkungan kampus dan masyarakat',
'GRAND DESIGN:\n1. KADERISASI: Sistem mentoring dan leadership training berkelanjutan\n2. RISET & INOVASI: Penelitian, jurnal ilmiah, dan paten di bidang pertambangan\n3. PEMBERDAYAAN: Program entrepreneurship dan UMKM untuk mahasiswa\n4. LINGKUNGAN: Kampanye sustainable mining dan green campus\n5. KOMUNIKASI: Media center, publikasi, dan branding yang kuat',
2);

-- Insert Data Kandidat Senat
INSERT INTO candidates (nama, foto, posisi, visi_misi, grand_design, nomor_urut) VALUES
('Budi Santoso', 'senator1.jpg', 'senat',
'VISI: Menjadi Senator yang aspiratif dan responsif terhadap kebutuhan mahasiswa.\n\nMISI:\n1. Menyalurkan aspirasi mahasiswa ke pimpinan organisasi\n2. Mengawasi jalannya program kerja HIMATEP\n3. Membangun transparansi dan akuntabilitas organisasi',
'GRAND DESIGN:\n1. ASPIRASI: Kotak saran digital dan forum diskusi rutin\n2. PENGAWASAN: Evaluasi berkala program kerja dan keuangan\n3. TRANSPARANSI: Publikasi laporan pertanggungjawaban berkala',
1),

('Citra Wulandari', 'senator2.jpg', 'senat',
'VISI: Menghadirkan senat yang proaktif dalam memperjuangkan hak dan kesejahteraan mahasiswa.\n\nMISI:\n1. Menjadi jembatan komunikasi antara mahasiswa dan pengurus\n2. Mengadvokasi kebijakan yang pro-mahasiswa\n3. Mendorong partisipasi aktif mahasiswa dalam organisasi',
'GRAND DESIGN:\n1. ADVOKASI: Program konsultasi dan pendampingan mahasiswa\n2. PARTISIPASI: Inisiatif melibatkan mahasiswa dalam setiap kegiatan\n3. MONITORING: Sistem pelaporan dan feedback yang efektif',
2),

('Dimas Prasetyo', 'senator3.jpg', 'senat',
'VISI: Senat yang kritis dan konstruktif untuk kemajuan HIMATEP.\n\nMISI:\n1. Melakukan kontrol terhadap kebijakan organisasi\n2. Memberikan masukan strategis untuk pengembangan HIMATEP\n3. Menjaga check and balance dalam organisasi',
'GRAND DESIGN:\n1. KONTROL: Audit program dan anggaran secara berkala\n2. STRATEGIS: Think tank untuk perencanaan jangka panjang\n3. BALANCE: Mediasi konflik dan problem solving',
3),

('Eka Putri Lestari', 'senator4.jpg', 'senat',
'VISI: Mewujudkan senat yang peduli dan berpihak pada mahasiswa.\n\nMISI:\n1. Menampung dan memperjuangkan aspirasi mahasiswa\n2. Mengawal implementasi program kerja yang bermanfaat\n3. Memastikan transparansi pengelolaan organisasi',
'GRAND DESIGN:\n1. PEDULI: Program visit dan pendekatan personal ke mahasiswa\n2. PENGAWALAN: Task force untuk monitoring implementasi program\n3. TRANSPARANSI: Dashboard publik untuk info organisasi',
4),

('Fajar Ramadhan', 'senator5.jpg', 'senat',
'VISI: Senat yang inovatif dan solutif dalam mengatasi permasalahan mahasiswa.\n\nMISI:\n1. Menciptakan solusi kreatif untuk permasalahan mahasiswa\n2. Mendorong inovasi dalam setiap program kerja\n3. Membangun networking yang luas untuk kepentingan mahasiswa',
'GRAND DESIGN:\n1. INOVASI: Hackathon dan kompetisi ide untuk mahasiswa\n2. SOLUSI: Problem solving center untuk mahasiswa\n3. NETWORKING: Partnership dengan organisasi lain dan alumni',
5),

('Gita Maharani', 'senator6.jpg', 'senat',
'VISI: Menghadirkan senat yang aktif dan responsif terhadap dinamika mahasiswa.\n\nMISI:\n1. Merespons cepat setiap aspirasi dan keluhan mahasiswa\n2. Mengawasi kinerja pengurus dengan objektif\n3. Membangun kultur organisasi yang sehat dan produktif',
'GRAND DESIGN:\n1. RESPONSIF: Hotline dan customer service untuk mahasiswa\n2. OBJEKTIF: Standar penilaian kinerja yang terukur\n3. KULTUR: Team building dan capacity building rutin',
6),

('Hendra Wijaya', 'senator7.jpg', 'senat',
'VISI: Senat yang amanah dan professional dalam menjalankan tugas legislatif.\n\nMISI:\n1. Menjalankan fungsi legislasi dengan penuh tanggung jawab\n2. Mengawasi pelaksanaan AD/ART organisasi\n3. Menjaga integritas dan kredibilitas organisasi',
'GRAND DESIGN:\n1. LEGISLASI: Penyusunan peraturan organisasi yang modern\n2. PENGAWASAN: Compliance check terhadap AD/ART\n3. INTEGRITAS: Code of conduct dan ethics committee',
7);

-- Insert Data Pemilih Dummy (password: voter123)
INSERT INTO voters (username, password, nama_lengkap, nim) VALUES
('2021001', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Andi Prasetyo', '210010001'),
('2021002', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Budi Setiawan', '210010002'),
('2021003', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Citra Dewi', '210010003'),
('2021004', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Dian Kusuma', '210010004'),
('2021005', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Eko Prasetyo', '210010005');