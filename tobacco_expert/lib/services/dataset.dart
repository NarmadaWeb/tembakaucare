import '../models/models.dart';

class TobaccoDataset {
  static List<Symptom> symptoms = [
    // Daun
    Symptom(
        id: 'S01',
        name: 'Bercak bulat cokelat kelabu',
        description: 'Ditemukan pada daun bagian bawah tanaman.',
        category: 'Daun'),
    Symptom(
        id: 'S02',
        name: 'Pusat bercak berwarna putih',
        description: 'Terdapat lingkaran konsentris yang jelas di area infeksi.',
        category: 'Daun'),
    Symptom(
        id: 'S03',
        name: 'Bercak kuning tidak merata',
        description: 'Warna tidak merata pada helai daun.',
        category: 'Daun'),
    Symptom(
        id: 'S04',
        name: 'Daun keriting',
        description: 'Pinggiran daun menggulung ke atas.',
        category: 'Daun'),
    Symptom(
        id: 'S05',
        name: 'Layu mendadak',
        description: 'Daun lunglai meski tanah lembap.',
        category: 'Daun'),
    Symptom(
        id: 'S06',
        name: 'Pinggiran daun menguning',
        description: 'Pinggiran daun bawah menguning dan menggulung ke bawah.',
        category: 'Daun'),
    // Batang
    Symptom(
        id: 'S07',
        name: 'Batang membusuk',
        description: 'Warna coklat gelap kehitaman di pangkal.',
        category: 'Batang'),
    Symptom(
        id: 'S08',
        name: 'Pecah batang',
        description: 'Retakan vertikal pada jaringan luar.',
        category: 'Batang'),
    // Akar
    Symptom(
        id: 'S09',
        name: 'Akar membengkak',
        description: 'Benjolan tidak wajar pada serabut akar.',
        category: 'Akar'),
    Symptom(
        id: 'S10',
        name: 'Akar rapuh',
        description: 'Akar mudah patah dan berwarna gelap.',
        category: 'Akar'),
    // Lingkungan
    Symptom(
        id: 'S11',
        name: 'Kondisi lingkungan lembab',
        description: 'Curah hujan tinggi dalam 2 minggu terakhir.',
        category: 'Lingkungan'),
    Symptom(
        id: 'S12',
        name: 'Tanaman kerdil',
        description: 'Pertumbuhan terhambat secara signifikan dibandingkan tanaman sehat.',
        category: 'Umum'),
    Symptom(
        id: 'S13',
        name: 'Lendir pada batang',
        description: 'Cairan kental keluar dari bekas potongan batang.',
        category: 'Batang'),
    Symptom(
        id: 'S14',
        name: 'Daun berlubang',
        description: 'Terdapat bekas gigitan serangga pada helai daun.',
        category: 'Daun'),
    Symptom(
        id: 'S15',
        name: 'Hama kecil hijau/hitam',
        description: 'Terlihat koloni serangga kecil di bawah permukaan daun.',
        category: 'Hama'),
  ];

  static List<Disease> diseases = [
    Disease(
        id: 'D01',
        name: 'Bercak Daun (Cercospora nicotianae)',
        description:
            'Infeksi jamur yang umum menyerang tanaman tembakau, terutama pada kondisi kelembaban tinggi. Penyakit ini dapat menurunkan kualitas daun secara signifikan jika tidak ditangani dengan tepat.',
        organicTreatment:
            'Semprotkan larutan ekstrak daun mimba (Azadirachta indica) setiap 3 hari pada sore hari untuk menghambat spora jamur.',
        chemicalTreatment:
            'Gunakan fungisida berbahan aktif Mankozeb atau Karbendazim sesuai dosis yang tertera pada label produk.',
        warning: 'Pastikan drainase lahan diperbaiki untuk mengurangi kelembaban di sekitar akar.'),
    Disease(
        id: 'D02',
        name: 'Tobacco Mosaic Virus (TMV)',
        description: 'Virus yang menyebabkan pola mosaik kuning-hijau pada daun dan pertumbuhan terhambat.',
        organicTreatment: 'Cabut dan bakar tanaman yang terinfeksi, cuci tangan dengan sabun setelah memegang tanaman sakit.',
        chemicalTreatment: 'Tidak ada obat kimia untuk virus, fokus pada pengendalian vektor (serangga).',
        warning: 'Hindari merokok di dekat kebun karena virus dapat menular melalui tembakau rokok.'),
    Disease(
        id: 'D03',
        name: 'Black Shank (Phytophthora nicotianae)',
        description: 'Penyakit tular tanah yang menyebabkan busuk pangkal batang dan layu cepat.',
        organicTreatment: 'Gunakan varietas tahan dan pergiliran tanaman dengan tanaman non-inang.',
        chemicalTreatment: 'Aplikasi fungisida berbahan aktif metalaksil pada tanah.',
        warning: 'Penyakit ini sangat merusak pada kondisi tanah basah.'),
    Disease(
        id: 'D04',
        name: 'Kekurangan Kalium',
        description: 'Defisiensi nutrisi yang mengganggu metabolisme air dan kualitas daun.',
        organicTreatment: 'Tambahkan abu kayu atau pupuk kandang yang kaya kalium.',
        chemicalTreatment: 'Aplikasi pupuk KCL atau ZK sesuai dosis.',
        warning: 'Sering terjadi pada tanah berpasir dengan curah hujan tinggi.'),
    Disease(
        id: 'D05',
        name: 'Layu Bakteri (Ralstonia solanacearum)',
        description: 'Penyakit mematikan yang menyerang sistem pembuluh tanaman, menyebabkan layu permanen.',
        organicTreatment: 'Gunakan bakteri antagonis seperti Pseudomonas fluorescens pada lubang tanam.',
        chemicalTreatment: 'Gunakan bakterisida berbahan aktif streptomisin sulfat.',
        warning: 'Sangat mudah menular melalui air irigasi dan alat pertanian.'),
    Disease(
        id: 'D06',
        name: 'Nematoda Bengkak Akar',
        description: 'Cacing mikroskopis yang menyerang akar dan menghambat penyerapan nutrisi.',
        organicTreatment: 'Tanam tanaman perangkap seperti Marigold (Tagetes) di sela tanaman tembakau.',
        chemicalTreatment: 'Aplikasi nematisida berbahan aktif Karbofuran sesuai dosis.',
        warning: 'Rotasi tanaman dengan tanaman yang bukan inang nematoda sangat dianjurkan.'),
    Disease(
        id: 'D07',
        name: 'Ulat Grayak (Spodoptera litura)',
        description: 'Hama pemakan daun yang dapat menghabiskan helai daun dalam waktu singkat.',
        organicTreatment: 'Gunakan bioinsektisida berbahan aktif Bacillus thuringiensis.',
        chemicalTreatment: 'Semprot insektisida berbahan aktif Deltametrin atau Sipermetrin.',
        warning: 'Lakukan pengamatan rutin pada malam hari saat ulat aktif makan.'),
    Disease(
        id: 'D08',
        name: 'Kutu Daun (Myzus persicae)',
        description: 'Serangga kecil yang mengisap cairan daun dan menjadi vektor berbagai penyakit virus.',
        organicTreatment: 'Semprotkan larutan sabun atau minyak nabati untuk menutupi pori-pori napas serangga.',
        chemicalTreatment: 'Insektisida sistemik berbahan aktif Imidakloprid.',
        warning: 'Populasi yang tinggi dapat menyebabkan embun jelaga pada daun.'),
  ];

  static List<Rule> rules = [
    Rule(id: 'R01', symptomIds: ['S01', 'S02', 'S11'], diseaseId: 'D01'),
    Rule(id: 'R02', symptomIds: ['S03', 'S04'], diseaseId: 'D02'),
    Rule(id: 'R03', symptomIds: ['S05', 'S07', 'S11'], diseaseId: 'D03'),
    Rule(id: 'R04', symptomIds: ['S06'], diseaseId: 'D04'),
    Rule(id: 'R05', symptomIds: ['S05', 'S13'], diseaseId: 'D05'),
    Rule(id: 'R06', symptomIds: ['S09', 'S10', 'S12'], diseaseId: 'D06'),
    Rule(id: 'R07', symptomIds: ['S14', 'S08'], diseaseId: 'D07'),
    Rule(id: 'R08', symptomIds: ['S15', 'S03', 'S04'], diseaseId: 'D08'),
  ];
}
