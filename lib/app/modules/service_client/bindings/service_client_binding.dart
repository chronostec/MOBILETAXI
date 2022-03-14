import 'package:get/get.dart';

import '../controllers/service_client_controller.dart';

class ServiceClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceClientController>(
      () => ServiceClientController(),
    );
  }
}
