class Symptom {
  final String id;
  final String name;
  final String description;
  final String category; // e.g., 'Daun', 'Batang', 'Akar'

  Symptom({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });
}

class Disease {
  final String id;
  final String name;
  final String description;
  final String organicTreatment;
  final String chemicalTreatment;
  final String warning;

  Disease({
    required this.id,
    required this.name,
    required this.description,
    required this.organicTreatment,
    required this.chemicalTreatment,
    required this.warning,
  });
}

class Rule {
  final String id;
  final List<String> symptomIds;
  final String diseaseId;

  Rule({
    required this.id,
    required this.symptomIds,
    required this.diseaseId,
  });
}

class History {
  final int? id;
  final String diseaseName;
  final String symptoms; // JSON string or comma separated
  final double accuracy;
  final DateTime date;

  History({
    this.id,
    required this.diseaseName,
    required this.symptoms,
    required this.accuracy,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'disease_name': diseaseName,
      'symptoms': symptoms,
      'accuracy': accuracy,
      'date': date.toIso8601String(),
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'],
      diseaseName: map['disease_name'],
      symptoms: map['symptoms'],
      accuracy: map['accuracy'],
      date: DateTime.parse(map['date']),
    );
  }
}
