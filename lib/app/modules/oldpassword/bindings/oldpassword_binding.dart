import 'package:get/get.dart';

import '../controllers/oldpassword_controller.dart';

class OldpasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OldpasswordController>(
      () => OldpasswordController(),
    );
  }
}
