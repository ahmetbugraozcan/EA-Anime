import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._init();

  SharedPreferences? _preferences;
  static CacheManager get instance => _instance;

  CacheManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static Future preferencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> removeKey(PreferencesKeys key) async {
    await instance._preferences!.remove(key.name.toString());
  }

  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  Future<void> clearAllSaveFirst() async {
    if (_preferences != null) {
      await _preferences!.clear();
      await setBoolValue(PreferencesKeys.IS_FIRST_APP, true);
    }
  }

  Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _preferences!.setString(key.name.toString(), value);
  }

  Future<void> setIntValue(PreferencesKeys key, int value) async {
    await _preferences!.setInt(key.name.toString(), value);
  }

  Future<void> setBoolValue(PreferencesKeys key, bool value) async {
    await _preferences!.setBool(key.name.toString(), value);
  }

  String getStringValue(PreferencesKeys key) =>
      _preferences?.getString(key.name.toString()) ?? '';

  int getIntValue(PreferencesKeys key) =>
      _preferences?.getInt(key.name.toString()) ?? 0;

  bool getBoolValue(PreferencesKeys key) =>
      _preferences!.getBool(key.name.toString()) ?? false;

  bool containsKey(PreferencesKeys key) =>
      _preferences!.containsKey(key.name.toString());
}
