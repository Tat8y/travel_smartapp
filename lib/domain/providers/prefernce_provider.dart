import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_smartapp/l10n/l10n.dart';

class PrefernceProvider extends ChangeNotifier {
  final String _keyDarkMode = 'darkMode';
  final String _keyLocale = 'locale';
  final String _keyFirstTime = 'firstTime';

  SharedPreferences preferences;
  PrefernceProvider(this.preferences);

  Locale? get locale => _getLocalePref();

  bool get darkMode => _getDarkModePref();
  set darkMode(bool state) => _setDarkModePref(state);

  bool get firstTime => _getFirstTimePref();
  set firstTime(bool state) => _setFirstTimePref(state);

  int get currentLocaleIndex {
    return L10n.all.indexOf(_getLocalePref() ?? const Locale('en'));
  }

  void setLocale(Locale locale) {
    _setLocalePref(locale);
    notifyListeners();
  }

  Locale? _getLocalePref() {
    String? languageCode = preferences.getString(_keyLocale);
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return null;
  }

  void _setLocalePref(Locale locale) {
    preferences.setString(_keyLocale, locale.languageCode);
  }

  bool _getDarkModePref() {
    return preferences.getBool(_keyDarkMode) ?? false;
  }

  void _setDarkModePref(bool state) {
    preferences.setBool(_keyDarkMode, state);
  }

  bool _getFirstTimePref() {
    return preferences.getBool(_keyFirstTime) ?? true;
  }

  void _setFirstTimePref(bool state) {
    preferences.setBool(_keyFirstTime, state);
  }

  void clear() async {
    await preferences.clear();
  }
}
