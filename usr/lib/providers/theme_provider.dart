import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('dark_mode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', _isDarkMode);
    notifyListeners();
  }

  // Brand Color Palette
  Color get primaryColor => const Color(0xFF2196F3);
  Color get secondaryColor => const Color(0xFF64B5F6);
  Color get accentColor => const Color(0xFF1976D2);
  Color get backgroundColor => _isDarkMode ? const Color(0xFF121212) : Colors.white;
  Color get surfaceColor => _isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F7FA);
  Color get textColor => _isDarkMode ? Colors.white : const Color(0xFF212121);
  Color get secondaryTextColor => _isDarkMode ? Colors.white70 : const Color(0xFF757575);
  
  // Gradient Colors
  LinearGradient get primaryGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColor,
      secondaryColor,
    ],
  );

  LinearGradient get backgroundGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      _isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
      _isDarkMode ? const Color(0xFF16213E) : const Color(0xFFE3F2FD),
    ],
  );
}
