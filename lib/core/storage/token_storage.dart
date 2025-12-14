import 'package:shared_preferences/shared_preferences.dart';
import 'storage_keys.dart';

class TokenStorage {
  final SharedPreferences _prefs;
  const TokenStorage(this._prefs);

  Future<void> saveToken(String token) async {
    await _prefs.setString(StorageKeys.token, token);
  }

  Future<String?> getToken() async {
    return _prefs.getString(StorageKeys.token);
  }

  Future<void> clearToken() async {
    await _prefs.remove(StorageKeys.token);
  }
}
