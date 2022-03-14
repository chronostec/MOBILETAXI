import 'package:get/get.dart';

import '../controllers/parametres_controller.dart';

class ParametresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParametresController>(
      () => ParametresController(),
    );
  }
}
