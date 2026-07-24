import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../models/models.dart';

class NaacState extends ChangeNotifier {
  String _selectedSchool = 'Infant Jesus';
  String _selectedYear = '2026-2027';
  Map<String, String?> _grades = {};
  Map<String, String?> _remarks = {};

  String get selectedSchool => _selectedSchool;
  String get selectedYear => _selectedYear;
  String? getGrade(String kiId) => _grades[kiId];
  String? getRemarks(String kiId) => _remarks[kiId];

  List<NaacSection> get sections => dataService.naacSections;

  void setSchool(String school) {
    _selectedSchool = school;
    notifyListeners();
  }

  void setYear(String year) {
    _selectedYear = year;
    notifyListeners();
  }

  void setGrade(String kiId, String? grade) {
    _grades[kiId] = grade;
    notifyListeners();
  }

  void setRemarks(String kiId, String? remarks) {
    _remarks[kiId] = remarks;
    notifyListeners();
  }

  void saveKi(String kiId) {
    // In real app, this would save to backend
    notifyListeners();
  }

  bool hasData() {
    return _grades.values.any((g) => g != null) || _remarks.values.any((r) => r != null && r.isNotEmpty);
  }
}
