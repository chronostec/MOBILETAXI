import 'package:get/get.dart';

import '../controllers/changernewpassword_controller.dart';

class ChangernewpasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangernewpasswordController>(
      () => ChangernewpasswordController(),
    );
  }
}
