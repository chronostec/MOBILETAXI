import 'package:get/get.dart';

import '../controllers/resetpwd_controller.dart';

class ResetpwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetpwdController>(
      () => ResetpwdController(),
    );
  }
}
