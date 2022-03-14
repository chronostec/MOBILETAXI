import 'package:get/get.dart';

import '../controllers/resetpass_controller.dart';

class ResetpassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetpassController>(
      () => ResetpassController(),
    );
  }
}
