import 'package:get/get.dart';

import '../controllers/phoneauth_controller.dart';

class PhoneauthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneauthController>(
      () => PhoneauthController(),
    );
  }
}
