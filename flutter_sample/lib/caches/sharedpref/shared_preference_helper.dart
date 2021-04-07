import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;
  static const String language_code = "language_code";

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Locale module
  Future<String> get appLocale {
    return _sharedPreference.then((prefs) {
      return prefs.getString(language_code) ?? null;
    });
  }

  Future<void> changeLanguage(String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(language_code, value);
    });
  }
}
