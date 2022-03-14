import 'package:get/get.dart';

import '../controllers/rapportactivite_controller.dart';

class RapportactiviteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RapportactiviteController>(
      () => RapportactiviteController(),
    );
  }
}
