import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/financeresume_model.dart';
import 'package:fredy_proprio/app/data/models/sales_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:get/get.dart';

class RapportactiviteController extends GetxController {
  late FocusNode myFocusNode;
  var tooltipBehavior;

  DateTime datejour = DateTime.now();
  final isready = false.obs;
  final resumeList = <Sales>[].obs;

  final RxBool isLoading = false.obs;
  RxString dateJour = DateTime.now().toString().substring(0, 10).obs;
  Rx<Financeresume> rapportJournee = Financeresume().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getRapportJournee();
    super.onReady();
  }

  @override
  void onClose() {}

  Future<Financeresume> getRapportJournee() async {
    isLoading.value = true;
    rapportJournee.value = await provDashboard.getRapportJournee(
        proprio_id: helper.proprioInfo.value.id!.toInt(),
        date_jour: dateJour.value);
    isLoading.value = false;
    return rapportJournee.value;
  }
}
