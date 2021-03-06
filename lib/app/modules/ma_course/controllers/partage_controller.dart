import 'package:alfred_taxi_client/app/data/models/partage_model.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartageController extends GetxController {
  final is_partage_requesting = false.obs;

  final globalKEY = GlobalKey<FormState>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<String> postPartageToApi(
      {required numeropartage, required commande_id}) async {
    is_partage_requesting.value = true;
    Partage _resultat = Partage();
    print("CONTACT ET ID: $numeropartage  $commande_id");
    await provPartage
        .postPartage(numeropartage: numeropartage, commande_id: commande_id)
        .then((value) {
      if (value.bSuccess) {
        // is_partage_requesting.value = false;
        Get.back();
        Get.snackbar("COURSE PARTAGEE",
            "Votre course a été partagée avec succès et votre correspondant peut suivre votre course !",
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.orange,
            colorText: Colors.white);
        _resultat = value;
      } else {
        // is_partage_requesting.value = false;
        Get.snackbar("PARTAGE",
            "Quelque chose s'est mal passée, veuillez recmmencer svp!",
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
        _resultat = value;
      }
    });

    is_partage_requesting.value = false;
    return _resultat.message;
  }
}
