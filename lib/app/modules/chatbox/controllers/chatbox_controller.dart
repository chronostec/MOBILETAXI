import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/data/models/echange_model.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart';
import 'package:alfred_taxi_client/app/data/services/stream_commande_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatboxController extends GetxController {
  RxBool DIALOGSTATUS = false.obs;
  RxBool UNREDMESSAGE = false.obs;

  var chatboxList = <Echange>[].obs;

  @override
  void onInit() {
    checkEchangePeriodicEvent();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<bool> ecrireMessage(String message) async {
    var _res = await provEchange.postEchange(
        cmde_id: ctlRecherche.maCommande.value.id,
        driver_id: ctlHome.user.value.id,
        message: message);
    lireMessages();
    return _res.bSuccess;
  }

  lireMessages() async {
    int _length = chatboxList.length;
    var _res = await provEchange.getEchange(
      cmde_id: ctlRecherche.maCommande.value.id,
    );
    _res.length > chatboxList.length ? chatboxList.value = _res : null;
    if (chatboxList.length > _length && chatboxList.last.driverId != null) {
      Get.snackbar("NOUVEAU MESSAGE", "${chatboxList.last.contenu}",
          backgroundColor: Colors.greenAccent, colorText: Colors.black);
    }
    chatboxList.value = chatboxList.reversed.toList();
    return chatboxList;
  }
}
