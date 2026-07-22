// lib/core/utils/app_preferences.dart

import 'package:shared_preferences/shared_preferences.dart';

import '../contents/enum.dart';

class AppPreferences {
  // Singleton pattern
  AppPreferences._();
  static final AppPreferences instance = AppPreferences._();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setString({
    required SharedPreferenceKey key,
    required String value,
  }) => _prefs.setString(key.name, value);

  String getString({
    required SharedPreferenceKey key,
    String defaultValue = '',
  }) => _prefs.getString(key.name) ?? defaultValue;

  Future<void> setBool({
    required SharedPreferenceKey key,
    required bool value,
  }) => _prefs.setBool(key.name, value);
  bool getBool({required SharedPreferenceKey key, bool defaultValue = false}) =>
      _prefs.getBool(key.name) ?? defaultValue;

  //*remove key
  Future<void> remove({required SharedPreferenceKey key}) =>
      _prefs.remove(key.name);
  //*clear all data
  Future<void> clear() => _prefs.clear();
}
