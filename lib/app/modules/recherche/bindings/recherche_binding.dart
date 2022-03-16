import 'package:get/get.dart';

import 'package:alfred_taxi_client/app/modules/recherche/controllers/negociation_controller.dart';

import '../controllers/recherche_controller.dart';

class RechercheBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NegociationController>(
      () => NegociationController(),
    );
    Get.lazyPut<RechercheController>(
      () => RechercheController(),
    );
  }
}
