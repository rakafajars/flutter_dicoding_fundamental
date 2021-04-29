import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  static const DARK_THEME = 'DARK_THEME';

  // Fungsi membaca dari sharedpref
  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DARK_THEME) ?? false;
  }

  // menyimpan ddata dari sharedpref
  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DARK_THEME, value);
  }

  // untuk menyimpan scheduling daily news
  static const DAILY_NEWS = 'DAILY_NEWS';

  // membaca data dari daily news
  Future<bool> get isDailyNewsActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_NEWS) ?? false;
  }

  // menyimpan data dari dailynew
  void setDailyNews(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_NEWS, value);
  }
}
