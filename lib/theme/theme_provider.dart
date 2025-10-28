import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _prefKey = 'theme';

  ThemeMode _themeMode = ThemeMode.light;
  bool _isDarkMode = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _initialize();
  }

  void _initialize() {
    _loadThemePreference();
    // Listen to system theme changes
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = _handleSystemThemeChange;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
    super.dispose();
  }

  void _handleSystemThemeChange() {
    if (_themeMode == ThemeMode.system) {
      _checkSystemTheme();
      notifyListeners();
    }
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? theme = prefs.getString(_prefKey);

      if (theme == null) {
        await switchTheme(ThemeMode.light);
      } else {
        switch (theme) {
          case 'light':
            await switchTheme(ThemeMode.light);
            break;
          case 'dark':
            await switchTheme(ThemeMode.dark);
            break;
          case 'system':
            await switchTheme(ThemeMode.system);
            break;
          default:
            await switchTheme(ThemeMode.light);
        }
      }
    } catch (e) {
      await switchTheme(ThemeMode.light);
    }
  }

  void _checkSystemTheme() {
    final Brightness platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _isDarkMode = platformBrightness == Brightness.dark;
  }

  Future<void> switchTheme(ThemeMode mode) async {
    _themeMode = mode;

    if (mode == ThemeMode.light) {
      _isDarkMode = false;
    } else if (mode == ThemeMode.dark) {
      _isDarkMode = true;
    } else {
      _checkSystemTheme();
    }

    // Save preference
    final prefs = await SharedPreferences.getInstance();
    switch (mode) {
      case ThemeMode.light:
        await prefs.setString(_prefKey, 'light');
        break;
      case ThemeMode.dark:
        await prefs.setString(_prefKey, 'dark');
        break;
      case ThemeMode.system:
        await prefs.setString(_prefKey, 'system');
        break;
    }
    
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await switchTheme(ThemeMode.dark);
    } else {
      await switchTheme(ThemeMode.light);
    }
  }

  // Helper method for development testing
  Future<void> testSwitchTheme() async {
    if (_themeMode == ThemeMode.light) {
      await switchTheme(ThemeMode.dark);
    } else {
      await switchTheme(ThemeMode.light);
    }
  }

  // Additional convenience methods
  Future<void> setLightTheme() async => await switchTheme(ThemeMode.light);
  Future<void> setDarkTheme() async => await switchTheme(ThemeMode.dark);
  Future<void> setSystemTheme() async => await switchTheme(ThemeMode.system);
}