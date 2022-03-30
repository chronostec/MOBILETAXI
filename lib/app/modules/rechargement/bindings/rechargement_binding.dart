import 'package:get/get.dart';

import '../controllers/rechargement_controller.dart';

class RechargementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechargementController>(
      () => RechargementController(),
    );
  }
}
