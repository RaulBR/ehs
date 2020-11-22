import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future setToken(token) async {
    if (token == null) {
      return;
    }
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("jwt", token);
  }

  Future getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('jwt');
  }

  Future removeToken() async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.remove('jwt');
  }

  Future setRole(role) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("role", role);
  }

  Future removeRole() async {
    final SharedPreferences prefs = await _prefs;
    prefs.getString("role");
  }

  Future readWithKey(key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.getString(key);
  }
}
