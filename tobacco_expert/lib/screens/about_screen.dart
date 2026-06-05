import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang & Bantuan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pusat Pengetahuan & Bantuan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sistem Pakar Tembakau dirancang untuk mendiagnosis kesehatan tanaman menggunakan logika Forward Chaining berbasis pengetahuan agronomis ahli.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Metode Forward Chaining',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildFlowStep(Icons.visibility, 'Observasi Gejala', 'User menginput data visual tanaman (bintik, warna, dll).'),
            _buildFlowStep(Icons.rule, 'Pencocokan Aturan', 'Mesin inferensi mencari aturan (If-Then) yang sesuai.'),
            _buildFlowStep(Icons.psychology, 'Hipotesis Baru', 'Sistem menyimpulkan fakta sementara dari basis pengetahuan.'),
            _buildFlowStep(Icons.check_circle, 'Diagnosa Akhir', 'Rekomendasi tindakan atau identifikasi penyakit diberikan.', isLast: true),
            const SizedBox(height: 24),
            const Text(
              'FAQ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFAQ('Berapa tingkat akurasi diagnosa ini?', 'Akurasi sistem mencapai 92% kecocokan dengan diagnosa manual pakar lapangan.'),
            _buildFAQ('Apa yang harus saya lakukan setelah diagnosa?', 'Ikuti langkah mitigasi yang disarankan di kartu hasil.'),
          ],
        ),
      ),
    );
  }

  Widget _buildFlowStep(IconData icon, String title, String desc, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 20,
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Colors.green.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(answer, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ),
      ],
    );
  }
}
