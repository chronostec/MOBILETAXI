import 'package:get/get.dart';

import '../controllers/repport_controller.dart';

class RepportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepportController>(
      () => RepportController(),
    );
  }
}
