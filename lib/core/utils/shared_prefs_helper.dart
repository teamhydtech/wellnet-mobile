import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const _keyTarget = 'downtime_target';

  /// Simpan target downtime (menit)
  static Future<void> saveDowntimeTarget(int hours, int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    final totalMinutes = hours * 60 + minutes;
    await prefs.setInt(_keyTarget, totalMinutes);
    print('[SharedPrefsHelper] Saved target: $totalMinutes minutes');
  }

  /// Ambil target downtime
  static Future<Map<String, int>> getDowntimeTarget() async {
    final prefs = await SharedPreferences.getInstance();
    final totalMinutes = prefs.getInt(_keyTarget) ?? 0;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    print('[SharedPrefsHelper] Loaded target: $hours h $minutes m');
    return {'hours': hours, 'minutes': minutes};
  }

  // ----------------------------
  // Tambahan utilitas umum
  // ----------------------------

  /// Simpan string (dipakai oleh DowntimeService)
  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    print('[SharedPrefsHelper] Saved string: $key = $value');
  }

  /// Ambil string berdasarkan key
  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    print('[SharedPrefsHelper] Get string: $key = $value');
    return value;
  }

  /// Hapus key tertentu (misalnya saat reset)
  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    print('[SharedPrefsHelper] Removed key: $key');
  }
}
