import '../models/models.dart';
import 'dataset.dart';

class InferenceEngine {
  static List<Disease> diagnose(List<String> selectedSymptomIds) {
    List<MapEntry<Disease, double>> weightedResults = [];

    for (var rule in TobaccoDataset.rules) {
      int matchedCount = 0;
      for (var symptomId in rule.symptomIds) {
        if (selectedSymptomIds.contains(symptomId)) {
          matchedCount++;
        }
      }

      if (matchedCount > 0) {
        var disease = TobaccoDataset.diseases.firstWhere((d) => d.id == rule.diseaseId);
        double accuracy = (matchedCount / rule.symptomIds.length) * 100;

        int existingIndex = weightedResults.indexWhere((e) => e.key.id == disease.id);
        if (existingIndex != -1) {
          if (weightedResults[existingIndex].value < accuracy) {
            weightedResults[existingIndex] = MapEntry(disease, accuracy);
          }
        } else {
          weightedResults.add(MapEntry(disease, accuracy));
        }
      }
    }

    // Sort by accuracy descending
    weightedResults.sort((a, b) => b.value.compareTo(a.value));

    return weightedResults.map((e) => e.key).toList();
  }

  static double calculateAccuracy(List<String> selectedSymptomIds, String diseaseId) {
    var rule = TobaccoDataset.rules.firstWhere((r) => r.diseaseId == diseaseId);
    int totalSymptomsInRule = rule.symptomIds.length;
    int matchedSymptoms = 0;

    for (var sid in rule.symptomIds) {
      if (selectedSymptomIds.contains(sid)) {
        matchedSymptoms++;
      }
    }

    return (matchedSymptoms / totalSymptomsInRule) * 100;
  }
}
