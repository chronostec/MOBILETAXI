import 'package:get/get.dart';

import '../controllers/vehicule_controller.dart';

class VehiculeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehiculeController>(
      () => VehiculeController(),
    );
  }
}
