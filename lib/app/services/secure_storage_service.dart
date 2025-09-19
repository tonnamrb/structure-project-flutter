import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageService {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> write(String key, String value) async {
    await init();
    await _prefs!.setString(key, value);
  }

  Future<String?> read(String key) async {
    await init();
    return _prefs!.getString(key);
  }

  Future<void> remove(String key) async {
    await init();
    await _prefs!.remove(key);
  }
}
