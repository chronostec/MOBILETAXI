import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/dashboard_resumer_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  Rx<DashboardResumer> dashboardResume = DashboardResumer().obs;
  final RxBool isLoading = false.obs;
  TextEditingController montantTC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    loadDashboardresume();
    ctlFinance.getFinanceresume();
    super.onReady();
  }

  @override
  void onClose() {}

  Future loadDashboardresume() async {
    isLoading.value = true;
    dashboardResume.value = await provDashboard.getListerDashboardResumers(
        proprio_id: helper.proprioInfo.value.id ?? 0,
        date_jour: helper.startdate.value);
    isLoading.value = false;
  }

  
}
