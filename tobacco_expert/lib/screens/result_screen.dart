import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/dataset.dart';
import '../services/inference_engine.dart';
import '../services/database_helper.dart';

class ResultScreen extends StatefulWidget {
  final List<Disease> results;
  final List<String> selectedSymptomIds;

  const ResultScreen({
    super.key,
    required this.results,
    required this.selectedSymptomIds,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    _saveHistory();
  }

  void _saveHistory() async {
    if (widget.results.isNotEmpty) {
      final bestResult = widget.results.first;
      final accuracy = InferenceEngine.calculateAccuracy(widget.selectedSymptomIds, bestResult.id);

      final history = History(
        diseaseName: bestResult.name,
        symptoms: widget.selectedSymptomIds.join(', '),
        accuracy: accuracy,
        date: DateTime.now(),
      );

      await DatabaseHelper().insertHistory(history);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.results.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Hasil Diagnosis')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_rounded, size: 80, color: Colors.orange),
                const SizedBox(height: 16),
                const Text('Tidak Ada Hasil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                  'Gejala yang Anda pilih tidak cocok dengan basis pengetahuan kami. Silakan konsultasikan dengan ahli agronomis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Kembali'),
                )
              ],
            ),
          ),
        ),
      );
    }

    final disease = widget.results.first;
    final accuracy = InferenceEngine.calculateAccuracy(widget.selectedSymptomIds, disease.id);
    final alternatives = widget.results.skip(1).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Diagnosis')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (accuracy < 100)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Tidak ditemukan kecocokan 100%. Menampilkan hasil dengan kemiripan tertinggi.',
                        style: TextStyle(fontSize: 13, color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            // Hero Result
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border(left: BorderSide(color: accuracy == 100 ? Colors.green : Colors.orange, width: 8)),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(accuracy == 100 ? Icons.verified : Icons.analytics, color: accuracy == 100 ? Colors.green : Colors.orange, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              accuracy == 100 ? 'HASIL DIAGNOSIS AKHIR' : 'KEMUNGKINAN TERBESAR',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: accuracy == 100 ? Colors.green : Colors.orange, letterSpacing: 1.2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(disease.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(disease.description, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (accuracy == 100 ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text('${accuracy.toInt()}%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: accuracy == 100 ? Colors.green : Colors.orange)),
                        Text('Akurasi', style: TextStyle(fontSize: 10, color: accuracy == 100 ? Colors.green : Colors.orange)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Gejala yang Terpenuhi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ..._buildMatchedSymptoms(disease.id),
            const SizedBox(height: 24),
            const Text('Rekomendasi Penanganan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildRecommendationCard('Metode Organik', disease.organicTreatment, Colors.green),
            const SizedBox(height: 12),
            _buildRecommendationCard('Metode Kimiawi', disease.chemicalTreatment, Colors.red),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.orange, size: 20),
                  const SizedBox(width: 12),
                  Expanded(child: Text(disease.warning, style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic))),
                ],
              ),
            ),

            if (alternatives.isNotEmpty) ...[
              const SizedBox(height: 32),
              const Text('Alternatif Diagnosis Lainnya', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...alternatives.map((alt) => _buildAlternativeCard(alt)),
            ],

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.refresh),
                label: const Text('Konsultasi Ulang'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMatchedSymptoms(String diseaseId) {
    final rule = TobaccoDataset.rules.firstWhere((r) => r.diseaseId == diseaseId);
    return rule.symptomIds.where((sid) => widget.selectedSymptomIds.contains(sid)).map((sid) {
      final symptom = TobaccoDataset.symptoms.firstWhere((s) => s.id == sid);
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(symptom.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(symptom.description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildRecommendationCard(String title, String content, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color, letterSpacing: 1.2)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildAlternativeCard(Disease disease) {
    final accuracy = InferenceEngine.calculateAccuracy(widget.selectedSymptomIds, disease.id);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        title: Text(disease.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text('${accuracy.toInt()}% Kecocokan', style: const TextStyle(fontSize: 12, color: Colors.green)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                results: [disease, ...widget.results.where((r) => r.id != disease.id)],
                selectedSymptomIds: widget.selectedSymptomIds,
              ),
            ),
          );
        },
      ),
    );
  }
}
