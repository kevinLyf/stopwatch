import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.dark();
  ThemeData get theme => _theme;

  ThemeMode currentTheme() {
    final isDark = _theme == ThemeData.dark();
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    final isDark = _theme == ThemeData.dark();
    _theme = isDark ? ThemeData.light() : ThemeData.dark();
    notifyListeners();
  }
}
