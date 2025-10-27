import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../repositories/downtime_repository.dart';

class DowntimeController extends GetxController {
  final DowntimeRepository repository = DowntimeRepository();

  var selectedHours = 0.obs;
  var selectedMinutes = 0.obs;

  Timer? _timer;
  int _targetMinutes = 0;

  String get _nowFormatted => DateFormat('HH:mm:ss').format(DateTime.now());

  @override
  void onInit() {
    super.onInit();
    print('[DowntimeController $_nowFormatted] onInit called');
    loadTarget();
  }

  void setTarget(int hours, int minutes) async {
    selectedHours.value = hours;
    selectedMinutes.value = minutes;
    _targetMinutes = hours * 60 + minutes;

    print('[DowntimeController $_nowFormatted] setTarget: $hours h $minutes m ($_targetMinutes minutes)');
    await repository.saveTarget(hours, minutes);

    startMonitoring();
  }

  void loadTarget() async {
    final target = await repository.getTarget();
    selectedHours.value = target['hours'] ?? 0;
    selectedMinutes.value = target['minutes'] ?? 0;
    _targetMinutes = (selectedHours.value * 60) + selectedMinutes.value;

    print('[DowntimeController $_nowFormatted] loadTarget: $_targetMinutes minutes');

    startMonitoring();
  }

  void startMonitoring() {
    _timer?.cancel();
    if (_targetMinutes == 0) {
      print('[DowntimeController $_nowFormatted] Target 0, monitoring skipped');
      return;
    }

    print('[DowntimeController $_nowFormatted] startMonitoring, target $_targetMinutes minutes');

    _timer = Timer.periodic(const Duration(minutes: 1), (_) async {
      print('[DowntimeController $_nowFormatted] Timer tick...');
      int used = await repository.getUsedMinutes();
      print('[DowntimeController $_nowFormatted] Used minutes: $used');

      if (used >= _targetMinutes) {
        print('[DowntimeController $_nowFormatted] Target tercapai!');
        _timer?.cancel();
        Get.snackbar(
          'Downtime',
          'Target harian tercapai! Waktunya berhenti menggunakan device.',
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  @override
  void onClose() {
    print('[DowntimeController $_nowFormatted] onClose called, cancelling timer');
    _timer?.cancel();
    super.onClose();
  }
}
