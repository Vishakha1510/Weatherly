import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String savedCitiesKey = 'saved_cities';

  static Future<void> saveCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cities = await getSavedCities();
    if (!cities.contains(city)) {
      cities.add(city);
      await prefs.setStringList(savedCitiesKey, cities);
    }
  }

  static Future<List<String>> getSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(savedCitiesKey) ?? [];
  }

  static Future<void> removeCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cities = await getSavedCities();
    cities.remove(city);
    await prefs.setStringList(savedCitiesKey, cities);
  }

  static Future<void> clearSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(savedCitiesKey);
  }
}
