import 'package:flutter/material.dart';
import '../services/dataset.dart';
import 'analysis_screen.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final List<String> _selectedSymptomIds = [];

  void _onSymptomSelected(String id, bool selected) {
    setState(() {
      if (selected) {
        _selectedSymptomIds.add(id);
      } else {
        _selectedSymptomIds.remove(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final symptomsByCategory = <String, List>{};
    for (var s in TobaccoDataset.symptoms) {
      symptomsByCategory.putIfAbsent(s.category, () => []).add(s);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konsultasi Gejala'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Konsultasi Tanaman Tembakau',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: const Border(left: BorderSide(color: Colors.green, width: 4)),
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                    ),
                    child: const Text(
                      'Sistem ini menggunakan metode Forward Chaining, sebuah teknik inferensi yang dimulai dari sekumpulan data (fakta) gejala yang Anda temukan.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...symptomsByCategory.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Gejala ${entry.key}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...entry.value.map((s) => _buildSymptomCard(s)),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          // Bottom Summary
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('FAKTA TERPILIH', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                      Text('${_selectedSymptomIds.length} Gejala Terdeteksi', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _selectedSymptomIds.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnalysisScreen(selectedSymptomIds: _selectedSymptomIds),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Proses Diagnosis'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomCard(dynamic s) {
    bool isSelected = _selectedSymptomIds.contains(s.id);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isSelected ? Colors.green : Colors.grey.shade300),
      ),
      color: isSelected ? Colors.green.shade50 : Colors.white,
      child: CheckboxListTile(
        value: isSelected,
        onChanged: (val) => _onSymptomSelected(s.id, val ?? false),
        title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(s.description, style: const TextStyle(fontSize: 12)),
        activeColor: Colors.green,
      ),
    );
  }
}
