import '../models/models.dart';
import 'dataset.dart';

class InferenceEngine {
  static List<Disease> diagnose(List<String> selectedSymptomIds) {
    List<Disease> results = [];

    for (var rule in TobaccoDataset.rules) {
      // Forward Chaining: Check if all symptoms of a rule are met
      bool match = true;
      int matchedCount = 0;

      for (var symptomId in rule.symptomIds) {
        if (selectedSymptomIds.contains(symptomId)) {
          matchedCount++;
        } else {
          match = false;
        }
      }

      // If all symptoms in a rule are present
      if (match) {
        var disease = TobaccoDataset.diseases.firstWhere((d) => d.id == rule.diseaseId);
        if (!results.any((r) => r.id == disease.id)) {
          results.add(disease);
        }
      } else if (matchedCount > 0 && (matchedCount / rule.symptomIds.length) >= 0.5) {
        // Partial match for fuzzy suggestion if no perfect match is found?
        // For strict forward chaining, we usually need full match,
        // but for a better UX we can consider diseases where most symptoms match.
        // Let's stick to full match for now as per standard forward chaining,
        // or we can sort by confidence.
      }
    }

    return results;
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
