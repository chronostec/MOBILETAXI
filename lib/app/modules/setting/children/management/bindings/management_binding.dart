import 'package:get/get.dart';

import '../controllers/management_controller.dart';

class ManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagementController>(
      () => ManagementController(),
    );
  }
}
