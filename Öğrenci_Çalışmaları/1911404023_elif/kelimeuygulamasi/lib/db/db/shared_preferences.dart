import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<bool> write(String key, Object value) async {
    final SharedPreferences prefs = await _prefs;

    if (value is String) {
      return prefs.setString(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    }

    return prefs.setStringList(key, value as List<String>);
  }

  static Future<Object?> read(String key) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.get(key);
  }
}
