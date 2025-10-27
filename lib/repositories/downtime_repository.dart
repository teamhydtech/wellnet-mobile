import '../../core/utils/shared_prefs_helper.dart';
import '../services/downtime_service.dart';

class DowntimeRepository {
  Future<void> saveTarget(int hours, int minutes) async {
    print('[DowntimeRepository] saveTarget called: $hours h $minutes m');
    await SharedPrefsHelper.saveDowntimeTarget(hours, minutes);
    await DowntimeService.saveStartTime(); // simpan waktu mulai setiap kali set target
  }

  Future<Map<String, int>> getTarget() async {
    print('[DowntimeRepository] getTarget called');
    return await SharedPrefsHelper.getDowntimeTarget();
  }

  Future<int> getUsedMinutes() async {
    print('[DowntimeRepository] getUsedMinutes called');
    return await DowntimeService.getUsedMinutes();
  }
}
