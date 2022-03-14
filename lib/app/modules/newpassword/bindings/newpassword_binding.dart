import 'package:get/get.dart';

import '../controllers/newpassword_controller.dart';

class NewpasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewpasswordController>(
      () => NewpasswordController(),
    );
  }
}
