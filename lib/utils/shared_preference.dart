import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  // Getter
  static bool? getBool(String key) => _instance.getBool(key);
  static String? getString(String key) => _instance.getString(key);

// Setter
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);

//contains
  static bool? contains(String key) => _instance.containsKey(key);

// list
  static List<String>? getList(String key) => _instance.getStringList(key);
}
