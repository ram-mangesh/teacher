import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../services/data_service.dart';

class AppState extends ChangeNotifier {
  static const _favoritesKey = 'favorites';

  String _selectedAcademicYear = '2026-2027';
  String get selectedAcademicYear => _selectedAcademicYear;

  Map<String, bool> _favorites = {};
  bool _loaded = false;

  bool isFavorite(String key) => _favorites[key] ?? false;

  void toggleFavorite(String key) {
    _favorites[key] = !isFavorite(key);
    _saveFavorites();
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_favoritesKey);
    if (stored != null) {
      _favorites = {for (var k in stored) k: true};
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = _favorites.entries.where((e) => e.value).map((e) => e.key).toList();
    await prefs.setStringList(_favoritesKey, keys);
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  UserModel get currentUser => dataService.currentUser;

  void setAcademicYear(String year) {
    _selectedAcademicYear = year;
    notifyListeners();
  }
}
