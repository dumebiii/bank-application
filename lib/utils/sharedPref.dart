import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
