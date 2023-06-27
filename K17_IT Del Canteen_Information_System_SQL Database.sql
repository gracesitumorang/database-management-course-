--Creating and Maintaining Database
Create Database Basdat2022_Kelompok_17_S1_Sistem_Informasi
ON
Primary (NAME = CanteenIS,
				FILENAME = 'D:\SEMESTER 3\BASIS DATA\TUGAS BESAR\SQL.mdf',
				SIZE = 10 MB,
				MAXSIZE = 10000 MB,
				FILEGROWTH = 20%) ,
				(NAME = CanteenISSecondary,
				FILENAME = 'D:\SEMESTER 3\BASIS DATA\TUGAS BESAR\SQL.ndf' ,
				SIZE = 5 MB,
				MAXSIZE = 10000 MB,
				FILEGROWTH = 30%)
LOG ON 			
				(NAME = CanteenISLog,
				FILENAME = 'D:\SEMESTER 3\BASIS DATA\TUGAS BESAR\SQL.ldf',
				SIZE = 30 MB,
				MAXSIZE = 5000 MB,
				FILEGROWTH = 20%)
/*After Creating the President Database, view the Information (Metadata) of database to verify that the database was created.*/

sp_helpdb Basdat2022_Kelompok_17_S1_Sistem_Informasi

-- Creating Tabel Pembelajaran Kolaboratif
create table pembelajaran_kolaboratif(
    kode_pembelajaran varchar (40) not null,
    prodi varchar(40),
    angkatan varchar(40),
    primary key(kode_pembelajaran)
);

select * from pembelajaran_kolaboratif

insert into pembelajaran_kolaboratif (kode_pembelajaran,prodi,angkatan)
VALUES
('14S1A', 'S1 Teknik Elektro', 2020),
('11S1A', 'S1 Informatika', 2021),
('13S1A', 'D3 Teknologi Komputer', 2021),
('21S1A', 'S1 Manajemen Rekayasa', 2019),
('12S2A', 'S1 Sistem Informasi', 2021),
('113SA', 'D4 TRPL', 2021);

select * from pembelajaran_kolaboratif

-- Creating Tabel Ruangan Kantin
create table ruangan_kantin(
    no_ruangan varchar(40) not null,
    jenis_ruangan varchar(40),
    kode_pembelajaran varchar(40),
    primary key (no_ruangan),
    foreign key (kode_pembelajaran) references pembelajaran_kolaboratif(kode_pembelajaran)
);

select * from ruangan_kantin

insert into ruangan_kantin(no_ruangan,jenis_ruangan,kode_pembelajaran)
VALUES
('KB1L1', 'Kantin Baru 1 Lantai 1', '14S1A'),
('KB2L1', 'Kantin Baru 2 Lantai 1',	'11S1A'),
('KL0L1', 'Kantin Lama Lantai 1', '13S1A'),
('KB2L2', 'Kantin Baru 2 Lantai 2', '21S1A'),
('KB1L2', 'Kantin Baru 1 Lantai 2', '12S2A'),
('KL0L2', 'Kantin Lama Lantai 2', '113SA');

select * from ruangan_kantin

-- Creating Tabel Identitas mahasiswa
create table identitas_mahasiswa(
    id_mahasiswa varchar(40) not null,
    nama_depan varchar(40),
    nama_belakang varchar(40),
    prodi varchar(40),
    angkatan int,
    primary key(id_mahasiswa)
);

select * from identitas_mahasiswa

insert into identitas_mahasiswa(ID_mahasiswa, Nama_Depan, Nama_Belakang, prodi, Angkatan)
VALUES
('12S21058','Grace','Situmorang','Sistem Informasi',2021),
('14S20017','Dilan','Pasaribu','Teknik elektro',2020),
('11S22001','Bayu','Tampubolon','Teknik informatika',2020),
('21S19002','Putri','Simamora','Manajemen Rekayasa',2021),
('11421012','Marudut','Hutahuruk','TRPL',2021);

select * from identitas_mahasiswa

-- Creating Tabel Biodata mahasiswa
create table biodata_mahasiswa(
    id_mahasiswa varchar(40),
    tanggal_lahir date,
    usia int,
    jenis_kelamin varchar(40),
    no_telepon varchar(40),
    foreign key (id_mahasiswa) references identitas_mahasiswa(id_mahasiswa)
);

select * from biodata_mahasiswa

insert into biodata_mahasiswa(ID_mahasiswa, Tanggal_Lahir,	Usia, Jenis_Kelamin, No_Telepon)
VALUES
('12S21058', '2002-10-10', 20, 'Perempuan',	'085587430911'),
('14S20017', '2002-02-12', 20, 'Laki-laki',	'085230159022'),
('11S22001', '2002-04-20', 20, 'Laki-laki',	'089573210052'),
('21S19002', '2001-10-26', 21, 'Perempuan',	'087795871022'),
('11421012', '2003-01-12', 19, 'Laki-laki',	'085677819022');

select * from biodata_mahasiswa

-- Creating Tabel Pembagian Ruangan Kolaboratif
create table pembagian_ruangan_kolaboratif(
    kode_pembelajaran varchar(40),
    id_mahasiswa varchar(40),
    jenis_ruangan varchar(40),
    foreign key(kode_pembelajaran) references pembelajaran_kolaboratif(kode_pembelajaran),
    foreign key(id_mahasiswa) references identitas_mahasiswa(id_mahasiswa)
);

select * from pembagian_ruangan_kolaboratif

insert into pembagian_ruangan_kolaboratif(Kode_Pembelajaran, ID_mahasiswa, Jenis_Ruangan)
VALUES
('14S1A', '14S20017', 'Kantin Baru 1 Lantai 1'),
('11S1A', '11S22001', 'Kantin Baru 2 Lantai 1'),
('12S2A', '12S21058', 'Kantin Baru 1 Lantai 2'),
('21S1A', '21S19002', 'Kantin Baru 2 Lantai 2'),
('113SA', '11421012', 'Kantin Lama Lantai 1');

select * from pembagian_ruangan_kolaboratif

-- Creating Tabel Kelompok Piket
create table kelompok_piket(
    id_kelompok varchar(40) not null,
    nama_kelompok varchar(40),
    id_desk varchar(40),
    primary key(id_kelompok)
);

select * from kelompok_piket

INSERT INTO kelompok_piket(ID_Kelompok, Nama_Kelompok, ID_Desk)
VALUES
('K2S2', 'Dua',	'B3P2'),
('K3S3', 'Tiga', 'B4P1'),
('K4S4', 'Empat', 'B2P7'),
('K5S5', 'Lima', 'B5P3');

select * from kelompok_piket

-- Creating Tabel Pembagian Kelompok Piket mahasiswa
create table pembagian_kelompok_piket_mahasiswa(
    id_kelompok varchar(40),
    id_mahasiswa varchar(40),
    foreign key(id_kelompok) references kelompok_piket(id_kelompok),
    foreign key(id_mahasiswa) references identitas_mahasiswa(id_mahasiswa)
);

select * from pembagian_kelompok_piket_mahasiswa

insert into pembagian_kelompok_piket_mahasiswa(ID_Kelompok,	ID_mahasiswa)
VALUES
('K2S2', '14S20017'),
('K3S3', '11S22001'),
('K4S4', '21S19002'),
('K5S5', '11421012');

select * from pembagian_kelompok_piket_mahasiswa

-- Creating Tabel Pembagian Jadwal Kelompok Piket
create table pembagian_jadwal_kelompok_piket(
    id_kelompok varchar(40),
    lokasi_kantin varchar(40),
    letak_lantai varchar(40),
    id_denahMakan varchar(40),
    id_JadwalPiket varchar(40),
    tanggal_piket date,
    foreign key (id_kelompok) references Kelompok_piket(id_kelompok)
);

select * from pembagian_jadwal_kelompok_piket

insert into pembagian_jadwal_kelompok_piket
VALUES
('K2S2','Kantin Baru','satu','12-D23','12-S23',	'2022-09-12'),
('K3S3','Kantin Baru','dua','12-D24','12-S24',	'2022-09-19'),
('K4S4','Kantin Lama','satu','12-D25','12-S25',	'2022-09-26'),
('K5S5','Kantin Lama','dua','12-D26','12-S26',	'2022-10-03');

select * from pembagian_jadwal_kelompok_piket

-- Creating Tabel Identitas Pihak Ketertiban
create table identitas_ketertiban(
    id_pihak_Ketertiban varchar(40) not null,
    nama_depan varchar(40),
    nama_belakang varchar(40),
    jenis_kelamin varchar(40),
    prodi varchar(40),
    angkatan int,
    no_telepon varchar(40),
    primary key(id_pihak_Ketertiban)
);

select * from identitas_ketertiban

insert into identitas_ketertiban(ID_Pihak_Ketertiban, Nama_Depan, Nama_Belakang, Jenis_Kelamin, prodi, Angkatan, No_Telepon)
VALUES
('12S20042', 'Sandro', 'Sinaga', 'Laki-laki', 'Sistem Informasi', 2020,	'085890123067'),
('11S20033', 'Anisa', 'Gultom', 'Perempuan', 'Teknik Informatika', 2020, '087753219022'),
('14S20021', 'Lidia', 'Pasaribu', 'Perempuan', 'Teknik Elektro', 2020, '089616314977'),
('12S20032', 'Yoga', 'Sihombing', 'Laki-laki', 'Sistem Informasi', 2020, '081479410932'),
('11420011', 'Natasha', 'Gabriela Sinaga', 'Perempuan',	'TRPL',	2020, '083342506887');

select * from identitas_ketertiban

-- Creating Tabel Kode Pihak Ketertiban
create table kode_pihak_ketertiban(
    kode_ketertiban varchar(40) not null,
    id_pihak_Ketertiban varchar(40),
    primary key (kode_ketertiban),
    foreign key (id_pihak_Ketertiban) references identitas_ketertiban(id_pihak_Ketertiban)
);

select * from kode_pihak_ketertiban

insert into Kode_Pihak_Ketertiban(Kode_Ketertiban, ID_Pihak_Ketertiban)
VALUES
('K01',	'12S20042'),
('K02',	'11S20033'),
('K05',	'14S20021'),
('K07',	'12S20032'),
('K10',	'11420011');

select * from kode_pihak_ketertiban

-- Creating Tabel Pengawas Kelompok Piket
create table pengawas_piket (
    id_kelompok varchar(40) not null,
    kode_ketertiban varchar(40),
    foreign key (id_kelompok) references Kelompok_piket(id_kelompok),
    foreign key (kode_ketertiban) references kode_pihak_ketertiban(kode_ketertiban)
);

select * from pengawas_piket 

insert into pengawas_piket(ID_Kelompok, Kode_Ketertiban)
VALUES
('K2S2', 'K02'),
('K3S3', 'K05'),
('K4S4', 'K07'),
('K5S5', 'K10');

select * from pengawas_piket 

-- Creating Tabel Identitas Staff
create table staff(
    id_staff varchar (40) not null,
    nama_depan varchar (50),
    nama_belakang varchar (50),
    tanggal_lahir date,
    usia int,
    jenis_kelamin varchar (40),
    no_telepon varchar (40),
    primary key(id_staff)
);

select * from staff

insert into Staff(id_staff,nama_depan,nama_belakang,tanggal_lahir,usia,jenis_kelamin,no_telepon)
VALUES
('K001', 'Owen', 'Sinaga', '2002-10-21', 20, 'Laki-laki', '081379048286'),
('K002', 'Theofil', 'Oktavia', '2002-02-12', 20, 'Perempuan',	'081264765520'),
('K010', 'Edward', 'Simorangkir', '2002-04-20', 20, 'Laki-laki', '081150482754'),
('K118', 'Katherine', 'Lestari', '2001-10-26', 21, 'Perempuan', '081036199988'),
('K0120', 'Monica',	'Pardede', '2003-01-12', 19, 'Perempuan', '080921917222'),
('K225', 'Maria', 'Lismawati', '2003-01-12', 19, 'Perempuan', '080807634456');

select * from staff

-- Creating Tabel Identitas Kemahasiswaan
create table Kemahasiswaan(
    id_kemahasiswaan varchar (40) not null,
    nama_depan varchar (50),
    nama_belakang varchar (50),
    tanggal_lahir date,
    usia int,
    jenis_kelamin varchar (40),
    no_telepon varchar(40),
    primary key(id_kemahasiswaan)
);

select * from Kemahasiswaan

insert into Kemahasiswaan(ID_Kemahasiswaan, Nama_Depan, Nama_Belakang,	Tanggal_Lahir, 	Usia , Jenis_Kelamin, No_Telepon)
VALUES
('33K21', 'Yoke', 'Purba', '1994-10-14'	,28,	'Perempuan', '081264765520'),
('33K02', 'Monalisa', 'Pasaribu', '1991-10-20', 32, 'Perempuan', '085260889542'),
('31K01', 'Andrianto', 'Prihartatyo', '1993-05-27', 29, 'Laki-laki', '089257013564'),
('33K11', 'Johannes', 'Sianipar', '1987-06-17', 35, 'Laki-laki', '083253137586'),
('33k08', 'Eben', 'Haezer', '1989-08-17',	33,'Laki-laki',	'087249261608');

select * from Kemahasiswaan

-- Creating Tabel Jabatan Kemahasiswaan=
create table jabatan_kemahasiswaan(
    id_kemahasiswaan varchar(40),
    kepangkatan varchar(80),
    foreign key(id_kemahasiswaan) references Kemahasiswaan(id_kemahasiswaan)
);

select * from jabatan_kemahasiswaan

insert into Jabatan_Kemahasiswaan(ID_Kemahasiswaan,	Kepangkatan)
VALUES
('33K02', 'Direktur Pendidikan'),
('31K01', 'Koordinator Lembaga Kemahasiswaan'),
('33K11', 'Bidang Akademik dan Kemahasiswaan'),
('33k08', 'Bidang Perencanaan');

select * from jabatan_kemahasiswaan

-- Creating Tabel Identitas Wakil Rektor
create table identitas_Wakil_Rektor(
    id_WakilRektor varchar(40) not null,
    nama_depan varchar(40),
    nama_belakang varchar(40),
    tanggal_lahir date,
    usia int,
    jenis_kelamin varchar(40),
    primary key(id_WakilRektor)
);

select * from identitas_Wakil_Rektor

insert into Identitas_Wakil_Rektor(id_WakilRektor,	Nama_Depan,	Nama_Belakang, Tanggal_Lahir, Usia, Jenis_Kelamin)
VALUES
('12WR2', 'Arlinta', 'Barus', '1990-08-27', 32,	'Perempuan'),
('11WR1', 'Johannes', 'Sianipar', '1987-06-17', 35, 'Laki-laki'),
('11WR2', 'Yosef', 'Manik', '1995-01-09', 27, 'Laki-laki'),
('10WR1', 'Yunita', 'Lumbangaol', '1997-03-15', 25, 'Perempuan');

select * from identitas_Wakil_Rektor

-- Creating Tabel Jabatan Wakil Rektor
create table jabatan_Wakil_Rektor(
    id_WakilRektor varchar(40),
    kepangkatan varchar(80),
    foreign key(id_WakilRektor) references identitas_Wakil_Rektor(id_WakilRektor)
);

select * from jabatan_Wakil_Rektor

insert into jabatan_Wakil_Rektor(id_WakilRektor,Kepangkatan)
VALUES
('12WR2', 'Bidang Pendidikan, Karir, dan Alumni'),
('11WR1', 'Bidang Akademik dan Kemahasiswaan'),
('11WR2', 'Bidang Keuangan dan Sumber Daya'),
('10WR1', 'Bidang Perencanaan, Kerja Sama, dan Hubungan Masyarakat');

select * from jabatan_Wakil_Rektor

-- Creating Tabel Identitas Keasramaan
create table identitas_keasramaan(
    id_keasramaan varchar(40) not null,
    nama_depan varchar(40),
    nama_belakang varchar(40),
    tanggal_lahir date,
    usia int,
    jenis_kelamin varchar(40),
    primary key (id_keasramaan)
);

select * from identitas_keasramaan

insert into Identitas_Keasramaan(ID_Keasramaan, Nama_Depan,	Nama_Belakang, Tanggal_Lahir, Usia, Jenis_Kelamin)
VALUES
('12-KS32', 'Eska', 'Silitonga', '1990-10-16',	25,	'Perempuan'),
('14-KS47', 'Elsa',	'Panggabean', '1999-04-17',	23,	'Perempuan'),
('11-KS21', 'Begawan', 'Sitompul', '1998-11-21', 24, 'Laki-laki'),
('10-KS46',	'Joshua', 'Panggabean',	'1998-02-23' ,24, 'Laki-laki');

select * from identitas_keasramaan

-- Creating Tabel Identitas Pihak Kantin
create table pihak_kantin(
    id_pihak_kantin varchar(40) not null,
    nama_depan varchar(40),
    nama_belakang varchar(40),
    tanggal_lahir date,
    usia int,
    jenis_kelamin varchar(40),
	no_telepon varchar(40),
    primary key (id_pihak_kantin)
);

select * from pihak_kantin

insert into Pihak_Kantin(ID_Pihak_Kantin,Nama_Depan,Nama_Belakang,	Tanggal_Lahir, 	Usia, 	Jenis_Kelamin,	no_telepon)
VALUES
('18K1902',	'Samuel','Hutahuruk','1999-04-17',23,	'Laki-laki',	'215664687'),
('19K2131',	'Rahayu','Bintang',	'1998-11-21',24,'Perempuan','216172361'),
('21K1291',	'Surti',	'Girsang',	'1998-02-23',	24,	'Perempuan',	'212173181'),
('11K3103',	'Marthin',	'Garix',	'1999-03-30',23,	'Laki-laki',	'217462781'),
('12K2123',	'Bayu',	'Santoso',	'1998-10-21',	24,	'Laki-laki',	'217182372');

select * from pihak_kantin

-- Creating Tabel Identitas Chef
create table chef(
    id_chef varchar(40) not null,
    nama_chef varchar(40),
    primary key(id_chef)
);

select * from chef

insert into Chef(ID_Chef,Nama_Chef)
VALUES
('CF-011','Daniel'),
('CF-022','Dhino'),
('CF-033','Budi'),
('CF-044','Michael'),
('CF-055','Everden');

select * from chef

-- Creating Tabel Identitas Pegawai Dapur
create table pegawai_dapur(
    id_pegawai_dapur varchar(40) not null,
    nama_pegawai_dapur varchar(40),
    primary key(id_pegawai_dapur)
);

select * from pegawai_dapur

insert into Pegawai_Dapur(ID_Pegawai_Dapur,	Nama_Pegawai_Dapur)
values
('DR-01','Siti'),
('DR-02','Willy'),
('DR-03','Hulu'),
('DR-04','Andre'),
('DR-05','Sule');

select * from pegawai_dapur

-- Creating Tabel Identitas Cleaning Service
create table cleaning_service(
	id_cleaning_service varchar(40),
    nama_cleaning_service varchar(40),
	primary key(id_cleaning_service)
);

select * from cleaning_service

insert into cleaning_service
values
('CS-01','Anto'),
('CS-02','Desta'),
('CS-03','Vincent'),
('CS-04','Ayub'),
('CS-05','Ayu');

select * from cleaning_service

-- Creating Tabel Kode Pekerja Kantin
create table kode_pekerja_kantin(
    id_pihak_kantin varchar(40),
    id_chef varchar(40),
    id_pegawai_dapur varchar(40),
	foreign key(id_pihak_kantin) references pihak_kantin(id_pihak_kantin),
    foreign key(id_chef) references chef(id_chef),
    foreign key(id_pegawai_dapur) references pegawai_dapur(id_pegawai_dapur)
);

select * from kode_pekerja_kantin

insert into kode_pekerja_kantin
values
	('18K1902','CF-011','DR-01'),
	('19K2131','CF-022','DR-02'),
	('21K1291','CF-033','DR-03'),
	('11K3103','CF-044','DR-04'),
	('12K2123','CF-055','DR-05');

select * from kode_pekerja_kantin

-- Creating Tabel Pengguna Kantin
create table pengguna_kantin(
    kode_kantin varchar(40) not null,
    id_mahasiswa varchar(40),
    id_staff varchar(40),
    kode_dosen varchar(40),
    id_keasramaan varchar(40),
    id_pihak_kantin varchar(40),
	primary key(kode_kantin),
	foreign key(id_mahasiswa) references identitas_mahasiswa(id_mahasiswa),
	foreign key(id_staff) references staff(id_staff),
	foreign key(id_keasramaan) references identitas_keasramaan(id_keasramaan),
	foreign key(id_pihak_kantin) references pihak_kantin(id_pihak_kantin)
);

select * from pengguna_kantin

insert into pengguna_kantin
values
('KL01','14S20017','K002','112D01','12-KS32','19K2131'),
('KB12','11S22001','K010','114D02','14-KS47','21K1291'),
('KL02','21S19002','K118','107D01','11-KS21','11K3103'),
('KB21','11421012','K0120','114D44','10-KS46','12K2123');

select * from pengguna_kantin


-- Creating Tabel Menu Makanan
create table menu_makanan(
    id_menu varchar(40) not null,
    nama_menu varchar(80),
    jumlah_menu int,
	primary key(id_menu)
);

select * from menu_makanan

insert into menu_makanan
values
    ('M-01', 'Nasi Teri kacang balado Kacang Balado', 1500),
    ('M-02', 'Nasi Ayam Andaliman dan Cah Tauge', 1500),
    ('M-03', 'Jahir Asam Manis dan Gulai Nangka', 1500),
    ('M-04', 'Lele Cabai Hijau  dan Sayur Urap', 1500),
    ('M-05', 'Nasi Ayam Rica-rica dan Cap-cay', 1500),
    ('M-06', 'Kembung Sambal Hijau dan  Terong Sambal',	1859),
    ('M-07', 'Jahir Pesmol Taucho, Terong dan Kacang Panjang',1978),
    ('M-08', 'Nasi Ayam Woku dan Tumis Sawi',1990),
    ('M-09', 'Dencis Sambal dan Cah Bayam Jagung',1952);

select * from menu_makanan

-- Creating Tabel Penyajian Menu Makanan
create table penyajian_menu(
    id_menu varchar(40),
    id_pihak_kantin varchar(40),
    foreign key(id_menu) references menu_makanan(id_menu),
    foreign key(id_pihak_kantin) references pihak_kantin(id_pihak_kantin)
);

select * from penyajian_menu

insert into penyajian_menu
values
	('M-01','18K1902'),
	('M-02','19K2131'),
	('M-03','21K1291'),
	('M-04','11K3103'),
	('M-05','12K2123'),
	('M-06','18K1902'),
	('M-07','19K2131'),
	('M-08','21K1291'),
	('M-09','12K2123');

select * from penyajian_menu

-- Creating Tabel Persetujuan Menu Makanan
create table persetujuan_menu(
    id_menu varchar(40),
    id_WakilRektor varchar(40),
    foreign key(id_menu) references menu_makanan(id_menu),
    foreign key(id_WakilRektor) references identitas_Wakil_Rektor(id_WakilRektor)
);

select * from persetujuan_menu

insert into persetujuan_menu
values
    ('M-01','12WR2'),
    ('M-02','12WR2'),
    ('M-03','12WR2'),
    ('M-04','11WR1'),
    ('M-05','11WR1'),
    ('M-06','11WR2'),
    ('M-07','11WR2'),
    ('M-08','10WR1'),
    ('M-09','10WR1');

select * from persetujuan_menu

-- Creating Tabel Bahan Makanan
create table bahan_makanan(
    kode_makanan varchar(40),
    nama_makanan varchar(40),
    jumlah_stok varchar(40),
    harga int,
    total_harga int,
    deskripsi varchar(40),
    primary key(kode_makanan)
);

select * from bahan_makanan

insert into bahan_makanan
values
    ('MK-01','Ikan Teri',50 ,40000,NULL,'Makan Siang'),
	('MK-02','Kacang',70,40000,NULL,'Makan Siang'),
	('MK-03','Cabai',30,100000,NULL,'Makan Siang'),
	('MK-04','Ayam',85,40000,NULL,'Makan Malam'),
	('MK-05','Tauge',30,15000,NULL,'Makan Malam'),
	('MK-06','Ikan Jahir',120,'30000',NULL,'Makan Siang'),
	('MK-07','Nenas',50,15000,NULL,'Makan Siang'),
	('MK-08','Nangka Muda',4,15000,NULL,'Makan Siang'),
	('MK-09','Lele',60,40000,NULL,'Makan Malam');

select * from bahan_makanan

-- Creating Tabel Identitas Supplier
create table supplier(
    id_supplier varchar(40),
    nama_supplier varchar(40),
    kode_makanan varchar(40),
	no_telepon varchar(40)
    primary key (id_supplier),
    foreign key (kode_makanan) references bahan_makanan(kode_makanan)
);

select * from supplier

insert into supplier
values
    ('P01','Pasar Silimbat','MK-01','89765230950'),
	('P02','Pasar Porsea','MK-02','852551976808'),
	('P03','Pasar Parsoburan','MK-03','852662108895'),
	('P04','Pasar Balige','MK-04','812117866767'),
	('P05','Pasar Laguboti','MK-05','815887098983'),
	('P06','Pasar Silaen','MK-06','823414543567'),
	('P07','Pasar Laguboti','MK-07','822654545090'),
	('P08','Pasar Balige','MK-08','851286756699'),
	('P09','Pasar Balige','MK-09','877645446510');

-- Creating Tabel Jadwal Input Bahan
create table Jadwal_input(
    id_supplier varchar(40),
    kode_makanan varchar(40),
    no_faktur varchar(40),
    tanggal_input date,
    foreign key(id_supplier) references supplier(id_supplier),
    foreign key (kode_makanan) references bahan_makanan(kode_makanan)
);

select * from Jadwal_input

insert into jadwal_input
values
    ('P01'	,'MK-01',	272	,'2022-09-01'),
	('P02'	,'MK-02',	204	,'2022-09-10'),
	('P03'	,'MK-03',	213	,'2022-12-09'),
	('P04'	,'MK-04',	230	,'2022-09-24'),
	('P05'	,'MK-05',	210	,'2022-10-01'),
	('P06'	,'MK-06',	298	,'2022-11-05'),
	('P05'	,'MK-07',	231	,'2022-11-05'),
	('P04'	,'MK-08',	221	,'2022-11-09'),
	('P04'	,'MK-09',	237	,'2022-11-15');

select * from Jadwal_input

-- Basic SQL 

/*1. Used to remove a table definition and all the data, indexes, triggers, constraints and permission specifications for employees and salary_grade table */
drop table supplier

SELECT * FROM supplier 

/* 2. Add a data manager according to the data shown. Then, show all data manage */
insert into bahan_makanan
values 
	('MK-10','Cabe',35,100000,NULL,'Makan Malam'),
	('MK-11','Kol',35,8000,NULL,'Makan Malam'),
	('MK-12','Kacang Panjang',20,15000,NULL,'Makan Malam'),
	('MK-13','Ayam',85,40000,NULL,'Makan Siang'),
	('MK-14','Kol',45,80000,NULL,'Makan Siang'),
	('MK-15','Wortel',20,150000,NULL,'Makan Siang'),
	('MK-16','Brokoli',50,30000,NULL,'Makan Siang'),
	('MK-17','Ikan Kembung',100,45000,NULL,'Makan Siang'),
	('MK-18','Cabai Rawit',10,4000,NULL,'Makan Siang'),
	('MK-19','Terong',45,15000,NULL,'Makan Siang'),
	('MK-20','Ikan Jahir',120,30000,NULL,'Makan Malam'),
	('MK-21','Terong',40,15000,NULL,'Makan Malam'),
	('MK-22','Ayam',85,40000,NULL,'Makan Siang'),
	('MK-23','Sawi',50,12000,NULL,'Makan Siang'),
	('MK-24','Dencis',50,45000,NULL,'Makan Malam'),
	('MK-25','Cabai Merah',30,100000,NULL,'Makan Malam'),
	('MK-26','Bayam',70,5000,NULL,'Makan Malam'),
	('MK-27','Jagung',80,15000,NULL,'Makan Malam');

SELECT * FROM bahan_makanan

/* 3. Change the identitAS_mahasiswa data which hAS ID_mahasiswa is 11421012! Show all of students identity in the identitAS_mahasiswa Table! */
UPDATE identitAS_mahasiswa
SET prodi = 'Teknologi RekayASa Perangkat Lunak'
WHERE ID_mahasiswa = '11421012'

SELECT * FROM identitAS_mahasiswa

/* 4. Show data food items who have amount above 1500 and have names that end in
with the letter "G" character! */
SELECT nama_menu, jumlah_menu
FROM menu_makanan
WHERE nama_menu LIKE '%G' AND jumlah_menu > 1500

/* 5. Change the identitAS_mahasiswa data which hAS ID_Kemahasiswaan is 33k08! Show all of kemahasiswaan identity in the jabatan_kemahasiswaan Table! */
UPDATE jabatan_kemahasiswaan
SET id_kemahasiswaan = '33K08'
WHERE id_kemahasiswaan = '33k08'

SELECT * FROM jabatan_kemahasiswaan

/*6. Add status column to the supplier's table which hAS data type varchar */
ALTER TABLE supplier
ADD alamat_supp VARCHAR (50);

SELECT * FROM supplier

/*7. Deleting the status column in the supplier's table */

ALTER TABLE supplier
DROP COLUMN alamat_supp;

/*8. Used to perform operations such AS addition to Food Prices */
SELECT nama_makanan AS 'Nama Makanan', harga AS 'Harga Makanan', harga + 10000 AS 'Jumlah Harga'  
FROM bahan_makanan

/*9. Multiplication between the qty column and the price to get the total price*/
SELECT kode_makanan AS 'Kode Makanan', harga AS 'Harga Bahan Makanan', jumlah_stok AS 'KuantitAS Bahan Makanan', jumlah_stok*harga AS 'Total Price'
FROM bahan_makanan

/*10. Show id_keASramaan, nama_depan, nama_belakang, jenis_kelamin, and usia who have ages above 23 and gender contains the word man */
SELECT id_keASramaan AS 'NIP KeASramaan', nama_depan AS 'Nama Depan', nama_belakang AS 'Nama Belakang', jenis_kelamin AS 'Jenis Kelamin', usia AS 'Usia KeASramaan'
FROM identitAS_keASramaan
WHERE usia > 23 AND jenis_kelamin = 'Laki-laki'

/*11. Show id_menu and id_WakilRektor of persetujuan_menu. Sort data by
earliest id_WakilRektor! */
SELECT id_menu AS 'ID Menu', id_WakilRektor AS 'NIDN Wakil Rektor'
FROM persetujuan_menu
ORDER BY id_WakilRektor ASC

/*12. Replace a group of arguments using the <> (or !=) operator that are combined with an AND*/
SELECT id_kelompok AS 'No Kelompok', lokASi_kantin AS 'LokASi Kantin', letak_lantai AS 'No Lantai'
FROM pembagian_jadwal_kelompok_piket
WHERE lokASi_kantin NOT IN ('Kantin Baru')

/* 13. Retrieve Canteen Identification Code, Student ID, Staff ID, Lecturer Code, Dormitory ID, Canteen Party ID with all the data in the canteen user table.*/
SELECT kode_kantin AS 'Kode Kantin', id_mahasiswa AS 'ID mahasiswa', id_staff AS 'ID Staff', kode_dosen AS 'Kode Dosen', id_keASramaan AS 'ID KeASramaan', id_pihak_kantin AS 'ID Pihak Kantin'
FROM pengguna_kantin
WHERE id_mahasiswa LIKE '%2' AND id_pihak_kantin LIKE '%3'  
ORDER BY kode_kantin ASC;  

/*14. Show kode_makanan, nama_makanan, harga, total_harga FROM food materials who dont have a total price*/
SELECT kode_makanan AS 'Kode Bahan Makanan',  nama_makanan  AS 'Kode Makanan', harga AS 'Harga Bahan Makanan',total_harga AS 'Total Harga'
FROM bahan_makanan
WHERE total_harga IS NULL

/*Aggregate Function*/

/* 15. Display number of supplier (save AS “Jumlah Supplier”) by supplier name */
SELECT nama_supplier AS 'Nama Supplier', COUNT(nama_supplier) AS 'Jumlah Supplier'
FROM supplier
GROUP BY nama_supplier

/*16. Show average ages FROM Canteen's Side (saved AS “Rata-rata Usia Pekerja Kantin”) grouped by id_pihak_kantin, nama_depan, nama_belakang */
SELECT id_pihak_kantin AS ID Pihak Kantin, nama_depan AS 'Nama Depan', nama_belakang AS 'Nama Belakang', AVG(usia) AS 'Rata-rata Usia Pekerja Kantin'
FROM pihak_kantin
GROUP BY id_pihak_kantin, nama_depan, nama_belakang
ORDER BY id_pihak_kantin ASC

/* Querying Multiple Table */

/*1. Featuring unique foods along with foods names */
SELECT DISTINCT kode_makanan, nama_makanan
FROM bahan_makanan
SELECT * FROM supplier

/*2. This Statement Returns All ID Teams and state ID Students of All Picket Group*/
SELECT id_kelompok, id_mahasiswa
FROM pembagian_kelompok_piket_mahasiswa
ORDER BY id_kelompok, id_mahasiswa

/* 3. Statement Used The Combination of Values in Both ID Kelompok and LokASi Kantin Coloumns to Evaluate the Duplicate */
SELECT DISTINCT id_kelompok, lokASi_kantin
FROM pembagian_jadwal_kelompok_piket

/* 4. Featuring foods names along with foods material*/
SELECT DISTINCT nama_makanan
FROM bahan_makanan
GROUP BY nama_makanan

/* 5. Count Number of Unique Rows */
SELECT COUNT(DISTINCT jenis_ruangan)
FROM ruangan_kantin

/*6. SELECTs Unique Ages and Orders in Descending Order FROM the Students Bio*/
SELECT DISTINCT usia
FROM biodata_mahasiswa
ORDER BY usia DESC

/*7. Give Coloumns with A Temporary Name that Used to Identify The Coloumn or Table */
SELECT DISTINCT tanggal_input AS 'Tanggal Input Bahan Makanan'
FROM jadwal_input

/*8. Combine Data FROM Multiple Coloumns and Represent Data in A Single Coloumn. */
SELECT CONCAT (nama_depan, ' ', nama_belakang) AS 'Nama Lengkap'
FROM identitAS_mahasiswa

/*9. Show data for all students in Study Collaboration who do not have study program AS S1 Teknik Elektro, D3 Teknologi Komputer */
SELECT *
FROM pembelajaran_kolaboratif
WHERE prodi NOT IN ('S1 Teknik Elektro', 'D3 Teknologi Komputer')

/*10. Show data for all no_ruangan, jenis_ruangan, kode_pembelajaran less than KB2L1 */
SELECT DISTINCT no_ruangan AS 'Nomor Ruangan', jenis_ruangan AS 'Jenis Ruangan', kode_pembelajaran AS 'Kode Pembelajaran'
FROM ruangan_kantin
WHERE no_ruangan > 'KB2L1'

-- Implementing Views
/* CREATE VIEW */

/* CREATE VIEW nama bahan makanan yang dimakan pada siang hari */
CREATE VIEW makansiang
AS
SELECT DISTINCT Nama_makanan, deskripsi 
FROM Bahan_makanan
WHERE deskripsi = 'Makan Siang'

SELECT * FROM makansiang

/* CREATE VIEW id kelompok yang piket di bulan 9 */
CREATE VIEW Piketbulan9
AS
SELECT id_kelompok, tanggal_piket FROM pembagian_jadwal_kelompok_piket
WHERE tanggal_piket LIKE '2022-09%'

SELECT * FROM Piketbulan9

/* CREATE VIEW nama makanan yang harganya di atAS 20 ribu*/
CREATE VIEW MakananMurah
AS
SELECT nama_makanan FROM Bahan_makanan
WHERE harga > 20000

SELECT * FROM MakananMurah

/* CREATE VIEW stock makanan terbesar pada menu makanan */
CREATE VIEW MaksimunStock
AS 
SELECT max (Jumlah_menu) AS stockTerbesar 
FROM Menu_makanan

SELECT * FROM MaksimunStock

/* CREATE VIEW nama pihak kantin yang umurnya 23 tahun */
CREATE VIEW Staff23Tahun
AS
SELECT (Nama_depan) AS nama FROM pihak_kantin
WHERE usia like '23'

SELECT * FROM Staff23Tahun

/* Nested Subqueries */

--Set Membership -in (enumerated set)

/* 1.Find all id_menu that are not approved in '10WR1', '11WR2', '12WR2'!*/
SELECT * 
FROM persetujuan_menu
WHERE id_WakilRektor NOT IN ('10WR1', '11WR2', '12WR2')

/* 2. Find all students who have both a picket group and student identity  */
SELECT DISTINCT id_mahasiswa
FROM pembagian_kelompok_piket_mahasiswa
WHERE id_mahasiswa IN (SELECT id_mahasiswa FROM identitAS_mahasiswa);

/* 3. Find all students who have both but do not have student identity and a picket group */
SELECT DISTINCT id_mahasiswa
FROM identitAS_mahasiswa
WHERE id_mahasiswa NOT IN (SELECT id_mahasiswa FROM pembagian_kelompok_piket_mahasiswa);

/* 4. Find all material foods that have greater price than some food materials have description in 'Lunch'*/
SELECT DISTINCT nama_makanan AS 'Nama Makanan'
FROM bahan_makanan
WHERE harga > SOME (SELECT harga FROM bahan_makanan WHERE deskripsi = 'Makan Siang');

/* 5. Find all material foods that have greater equal price than some food materials have description in 'Lunch'*/
SELECT DISTINCT nama_makanan AS 'Nama Makanan'
FROM bahan_makanan
WHERE harga >= SOME (SELECT harga FROM bahan_makanan WHERE deskripsi = 'Makan Siang');

/* 6. Find the name of all material foods that have greater equal price than all food materials have description in 'Dinnner'*/
SELECT DISTINCT nama_makanan AS 'Nama Makanan'
FROM bahan_makanan
WHERE harga > ALL (SELECT harga FROM bahan_makanan WHERE deskripsi = 'Makan Malam');

/* 7. Displays All Food Materials Data BASed on the Highest Price*/
SELECT *
FROM bahan_makanan
WHERE harga IN (SELECT MIN(harga) FROM bahan_makanan)

/* 8. Display Food Names Who Is Taking Maximum of sum of menu*/
SELECT nama_menu
FROM menu_makanan
WHERE jumlah_menu IN (SELECT MAX(jumlah_menu) FROM menu_makanan)

/* Querying Multiple Table */

/*1. Featuring unique foods along with foods names */
SELECT DISTINCT kode_makanan, nama_makanan
FROM bahan_makanan
SELECT * FROM supplier

/*2. This Statement Returns All ID Teams and state ID Students of All Picket Group*/
SELECT id_kelompok, id_mahasiswa
FROM pembagian_kelompok_piket_mahasiswa
ORDER BY id_kelompok, id_mahasiswa

/* 3. Statement Used The Combination of Values in Both ID Kelompok and LokASi Kantin Coloumns to Evaluate the Duplicate */
SELECT DISTINCT id_kelompok, lokASi_kantin
FROM pembagian_jadwal_kelompok_piket

/* 4. Featuring foods names along with foods material*/
SELECT DISTINCT nama_makanan
FROM bahan_makanan
GROUP BY nama_makanan

/* 5. Count Number of Unique Rows */
SELECT COUNT(DISTINCT jenis_ruangan)
FROM ruangan_kantin

/*6. Selects Unique Ages and Orders in Descending Order FROM the Students Bio*/
SELECT DISTINCT usia
FROM biodata_mahasiswa
ORDER BY usia DESC

/*7. Give Coloumns with A Temporary Name that Used to Identify The Coloumn or Table */
SELECT DISTINCT tanggal_input AS 'Tanggal Input Bahan Makanan'
FROM jadwal_input

/*8. Combine Data FROM Multiple Coloumns and Represent Data in A Single Coloumn. */
SELECT CONCAT (nama_depan, ' ', nama_belakang) AS 'Nama Lengkap'
FROM identitAS_mahasiswa

/*9. Show data for all students in Study Collaboration who do not have study program AS S1 Teknik Elektro, D3 Teknologi Komputer */
SELECT *
FROM pembelajaran_kolaboratif
WHERE prodi NOT IN ('S1 Teknik Elektro', 'D3 Teknologi Komputer')

/*10. Show data for all no_ruangan, jenis_ruangan, kode_pembelajaran less than KB2L1 */
SELECT DISTINCT no_ruangan AS 'Nomor Ruangan', jenis_ruangan AS 'Jenis Ruangan', kode_pembelajaran AS 'Kode Pembelajaran'
FROM ruangan_kantin
WHERE no_ruangan > 'KB2L1'


/* Join Table */

SELECT *
FROM pembelajaran_kolaboratif

SELECT *
FROM ruangan_kantin

--INNER JOIN
/* 1. Menampilkan Data pada Tabel Pembelajaran Kolaboratif dan Tabel Ruangan Kantin yang Keduanya
memiliki atribut yang sama yakni kode_pembelajaran pada tabel ruangan kantin dengan kode yang sama pada tabel Tabel Ruangan Kantin */
SELECT *
FROM pembelajaran_kolaboratif 
INNER JOIN ruangan_kantin
ON pembelajaran_kolaboratif.kode_pembelajaran=ruangan_kantin.kode_pembelajaran

-- LEFT JOIN
/* 2. Menampilkan Seluruh Data dari Tabel Pembelajaran Kolaboratif. Namun, hanya beberapa data yang memenuhi syarat dari Tabel Pembagian Ruangan Kolaboratif yang Muncul */
SELECT *
FROM pembelajaran_kolaboratif 
LEFT JOIN pembagian_ruangan_kolaboratif
ON pembelajaran_kolaboratif.kode_pembelajaran=pembagian_ruangan_kolaboratif.kode_pembelajaran

-- RIGHT JOIN
/* 3. Menampilkan Seluruh Data dari Tabel Pembagian Jadwal Kelompok Piket. Namun, hanya beberapa data yang memenuhi syarat dari Tabel Kelompok Piket yang Muncul*/
SELECT * 
FROM kelompok_piket
RIGHT JOIN pembagian_jadwal_kelompok_piket
ON kelompok_piket.id_kelompok=pembagian_jadwal_kelompok_piket.id_kelompok

-- OUTER JOIN
/* 4. Menampilkan Seluruh Data dengan Menggabungkan Data Tabel Menu dengan Tabel Penyajian Menu Makanan*/
SELECT *
FROM menu_makanan 
LEFT OUTER JOIN penyajian_menu
ON menu_makanan.id_menu=penyajian_menu.id_menu

-- CROSS JOIN
/* 5. Menampilkan KombinASi Semua Baris dalam Tabel Supplier dan Tabel Jadwal Input Makanan yang Digabungkan.*/
SELECT *
FROM supplier 
CROSS JOIN Jadwal_input

-- JOINING MORE THAN TWO VARIABLES
/* 6. Menampilkan Seluruh Data dengan Menggabungkan Tabel IdentitAS mahasiswa, Tabel Pembagian Ruangan Kolaboratif, dan Tabel Pengguna Kantin */
SELECT *
FROM identitAS_mahasiswa
JOIN pembagian_ruangan_kolaboratif
ON identitAS_mahasiswa.id_mahasiswa=pembagian_ruangan_kolaboratif.id_mahasiswa
JOIN pengguna_kantin
ON pembagian_ruangan_kolaboratif.id_mahasiswa=pengguna_kantin.id_mahasiswa

/* Function in SQL Server */

--/*Menampilkan Jumlah Program Studi mahasiswa */
create function tampil_prodi(@prodi varchar(40))
returns int
as
begin
declare @jumlah int;
select @jumlah = count(@prodi) from identitas_mahasiswa
where prodi=@prodi
return @jumlah;
end

select dbo.tampil_prodi('Sistem Informasi');

-------
/*Menampilkan Jumlah Menu Makanan yang Disajikan di Kantin */
create function tampil_menu(@nama_menu varchar(40))
returns int
as
begin
declare @jumlah int;
select @jumlah = count(@nama_menu) from menu_makanan
where nama_menu=@nama_menu
return @jumlah;
end


select dbo.tampil_menu('Lele Cabai Hijau  dan Sayur Urap');

/* Procedure in SQL Server */

---------
/* Menambahkan Data Supplier dalam Penginputan Bahan Makanan Kantin */
create procedure tambah_supplier(@id_supplier varchar(40),@nama_supplier varchar(40),
									@kode_makanan varchar(40), @no_telepon varchar(40)) -- Add the parameters for the stored procedure here

as

begin

insert into supplier(id_supplier,nama_supplier,kode_makanan,no_telepon)
values (@id_supplier,@nama_supplier,@kode_makanan,@no_telepon)

end

exec tambah_supplier 'P10','Pasar Balige','MK-09','81431527872';

select*from supplier

/* Menghapus Data Supplier yang Ditambahkan dalam Penginputan Bahan Makanan Kantin */
ALTER PROCEDURE tambah_supplier
	(
	@id_supplier varchar(40)
	)
AS
    BEGIN 
		SET NOCOUNT ON;
		DELETE FROM supplier WHERE id_supplier = 'P10'
		return 0;
	END

EXEC tambah_supplier 'P10'

SELECT * FROM supplier

/* Mengupdate Jumlah Stok Makanan dan Harga Makanan  */
CREATE PROCEDURE p_updateBMakanan(
	@kode_makanan varchar(40),
	@jumlah_stok varchar(40),
    @deskripsi varchar(40))
AS
	SET NOCOUNT ON -- When the SET NOCOUNT is ON, the count is not returned
	UPDATE bahan_makanan
	SET jumlah_stok = '100', deskripsi = 'Makan Siang'
	WHERE kode_makanan = 'MK-04'

EXEC p_updateBMakanan '100', 'Makan Siang', 'MK-04';

SELECT * FROM  bahan_makanan

/* Menampilkan Salah Satu Menu Makanan */
CREATE PROCEDURE stp_getmenubyID

 @id_menu varchar(40)
AS
BEGIN

 SET NOCOUNT ON;

 SELECT * from menu_makanan where id_menu=@id_menu
END
GO

EXEC stp_getmenubyID 'M-01';









