import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/financeresume_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FinanceController extends GetxController {
  final format = NumberFormat("#,##0.00", "en_US");
  late FocusNode myFocusNode;
  var tooltipBehavior;

  TextEditingController startTC = TextEditingController();
  TextEditingController endTC = TextEditingController();

  RxBool isLoading = false.obs;
  RxInt periodIndex = 0.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endedDate = DateTime.now().obs;
  RxString dateJour = DateTime.now().toString().substring(0, 10).obs;

  Rx<Financeresume> financeResume = Financeresume().obs;

  @override
  void onInit() {
    getFinanceresume();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<Financeresume> getFinanceresume() async {
    isLoading.value = true;
    financeResume.value = await provFinance.getListerFinanceResumers(
      proprio_id: helper.proprioInfo.value.id ?? 0,
      date_debut: startDate.value.toString().substring(0, 10),
      date_fin: endedDate.value.toString().substring(0, 10),
    );
    isLoading.value = false;
    return financeResume.value;
  }
}
