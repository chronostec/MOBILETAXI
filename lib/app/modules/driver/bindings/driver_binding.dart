import 'package:get/get.dart';

import '../controllers/driver_controller.dart';

class DriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverController>(
      () => DriverController(),
    );
  }
}
