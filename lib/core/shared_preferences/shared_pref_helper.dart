import 'package:nuntius/core/shared_preferences/shared_pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setUid({required String uId}) async {
    return await prefs!.setString(SharedPrefsKeys.uId, uId);
  }

  static Future<String?> getUid() async {
    return prefs!.getString(SharedPrefsKeys.uId);
  }
}
