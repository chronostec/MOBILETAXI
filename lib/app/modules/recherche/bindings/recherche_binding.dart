import 'package:get/get.dart';

import '../controllers/recherche_controller.dart';

class RechercheBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechercheController>(
      () => RechercheController(),
    );
  }
}
