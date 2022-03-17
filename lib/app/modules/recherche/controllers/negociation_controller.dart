import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:get/get.dart';

class NegociationController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt montantNegocie = 0.obs;

  @override
  void onInit() {
    selectedIndex.value = 0;
    montantNegocie.value = ctlRecherche.propositionsList[0].montant!.toInt();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  incrementMoney() {
    if (montantNegocie.value <
        ctlRecherche
            .propositionsList[ctlNegociation.selectedIndex.value].montant!
            .toInt()) {
      montantNegocie.value = montantNegocie.value +
          ctlRecherche.propositionsList[0].palier!.toInt();
    } else {
      montantNegocie.value = ctlRecherche
          .propositionsList[ctlNegociation.selectedIndex.value].montant!
          .toInt();
    }
  }

  decrementMoney() {
    if (montantNegocie.value >
        ctlRecherche.propositionsList[ctlNegociation.selectedIndex.value]
            .montantMinimum!
            .toInt()) {
      montantNegocie.value = montantNegocie.value -
          ctlRecherche.propositionsList[0].palier!.toInt();
    } else {
      montantNegocie.value = ctlRecherche
          .propositionsList[ctlNegociation.selectedIndex.value].montantMinimum!
          .toInt();
    }
  }
}
