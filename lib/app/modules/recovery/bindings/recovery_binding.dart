import 'package:get/get.dart';

import '../controllers/recovery_controller.dart';

class RecoveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecoveryController>(
      () => RecoveryController(),
    );
  }
}
