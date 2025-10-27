import '../../core/utils/shared_prefs_helper.dart';

class DowntimeService {
  static const _keyStartTime = 'downtime_start_time';

  /// Simpan waktu mulai downtime (saat user set target)
  static Future<void> saveStartTime() async {
    final now = DateTime.now();
    await SharedPrefsHelper.saveString(_keyStartTime, now.toIso8601String());
    print('[DowntimeService] saveStartTime: $now');
  }

  /// Hitung berapa menit yang sudah digunakan sejak startTime
  static Future<int> getUsedMinutes() async {
    final startIso = await SharedPrefsHelper.getString(_keyStartTime);
    if (startIso == null) {
      print('[DowntimeService] getUsedMinutes: belum ada start time');
      return 0;
    }

    final start = DateTime.parse(startIso);
    final now = DateTime.now();
    final diff = now.difference(start).inMinutes;

    print('[DowntimeService] getUsedMinutes: $diff minutes (since $start)');
    return diff;
  }

  /// Reset waktu mulai (optional, bisa dipanggil jika user reset target)
  static Future<void> resetStartTime() async {
    await SharedPrefsHelper.remove(_keyStartTime);
    print('[DowntimeService] resetStartTime called');
  }
}
