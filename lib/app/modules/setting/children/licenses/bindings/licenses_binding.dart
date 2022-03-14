import 'package:get/get.dart';

import '../controllers/licenses_controller.dart';

class LicensesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LicensesController>(
      () => LicensesController(),
    );
  }
}
