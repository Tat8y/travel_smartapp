import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_smartapp/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  SharedPreferences preferences;
  LocaleProvider(this.preferences);

  Locale? get locale => _pref();

  int get currentLocaleIndex {
    return L10n.all.indexOf(_pref() ?? const Locale('en'));
  }

  void setLocale(Locale locale) {
    _setPref(locale);
    notifyListeners();
  }

  Locale? _pref() {
    String? languageCode = preferences.getString('locale');
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return null;
  }

  _setPref(Locale locale) {
    preferences.setString('locale', locale.languageCode);
  }
}
