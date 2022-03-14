import 'package:alfred_taxi_driver/app/data/models/message_support_model.dart';
import 'package:alfred_taxi_driver/app/data/models/objet_message_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final objet = "Autre".obs;
  final formKey = GlobalKey<FormState>();
  final messageTF = TextEditingController();

  final isSending = false.obs;
  final isFetching = false.obs;

  List<ObjetMessage> messageObjetsList = <ObjetMessage>[].obs;
  var mesobjets = <String>[].obs;
  final message = MessageSupport().obs;

  @override
  void onInit() {
    messageObjetsList = [];
    getMessageObjet();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future getMessageObjet() async {
    isFetching.value = true;
    messageObjetsList = await proMessage.getObjetMessage();
    if (messageObjetsList.isNotEmpty) {
      mesobjets.value = [];
      for (var m in messageObjetsList) {
        mesobjets.add(m.libelle);
      }
    }
    isFetching.value = false;
    return messageObjetsList;
  }

  Future<MessageSupport> postMessage(
      {required client_id, required objetc, required contenu}) async {
    isSending.value = true;
    message.value = await proMessage.postMessageSupport(
        client_id: client_id, objetc: objetc, contenu: contenu);
    isSending.value = false;

    return message.value;
  }
}
