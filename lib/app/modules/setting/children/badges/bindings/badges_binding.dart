import 'package:get/get.dart';

import '../controllers/badges_controller.dart';

class BadgesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BadgesController>(
      () => BadgesController(),
    );
  }
}
