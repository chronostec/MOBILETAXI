import 'package:get/get.dart';

import '../controllers/aide_controller.dart';

class AideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AideController>(
      () => AideController(),
    );
  }
}
