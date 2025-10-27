import 'package:get/get.dart';
import '../controllers/downtime_controller.dart';

class DowntimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DowntimeController>(() => DowntimeController());
  }
}
