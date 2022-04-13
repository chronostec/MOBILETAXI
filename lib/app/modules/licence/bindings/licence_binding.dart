import 'package:get/get.dart';

import '../controllers/licence_controller.dart';

class LicenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LicenceController>(
      () => LicenceController(),
    );
  }
}
