import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/modules/dashboard/views/dashboard_view.dart';
import 'package:fredy_proprio/app/modules/driver/views/driver_view.dart';
import 'package:fredy_proprio/app/modules/finance/views/finance_view.dart';
import 'package:fredy_proprio/app/modules/setting/views/setting_view.dart';
import 'package:fredy_proprio/app/modules/vehicule/views/vehicule_view.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: _pageController,
            children: [
              const DashboardView(),
              FinanceView(),
              const DriverView(),
              VehiculeView(),
              SettingView()
            ],
            onPageChanged: (index) {
              ctlHome.currentPage.value = index;
            },
          ),
          bottomNavigationBar: BottomBar(
            selectedIndex: ctlHome.currentPage.value,
            onTap: (int index) {
              if (index == 0) {
                ctlDashboard.loadDashboardresume();
              }
              if (index == 2) {
                ctlDriver.ListerDrivers();
              }
              if (index == 3) {
                ctlVehicule.listerVehicules();
              }
              _pageController.jumpToPage(index);
              ctlHome.currentPage.value = index;
            },
            items: <BottomBarItem>[
              BottomBarItem(
                icon: const Icon(Icons.home, size: 18),
                title: const Text('Accueil'),
                activeColor: Colors.red,
                darkActiveColor: Colors.red.shade400,
              ),
              BottomBarItem(
                icon: const Icon(FontAwesomeIcons.coins, size: 18),
                title: const Text('Finance'),
                activeColor: Colors.deepPurpleAccent,
              ),
              BottomBarItem(
                icon: const Icon(Icons.person, size: 18),
                title: const Text('Chauffeurs'),
                activeColor: Colors.blue,
                darkActiveColor: Colors.blue.shade400, // Optional
              ),
              BottomBarItem(
                icon: const Icon(Icons.drive_eta, size: 18),
                title: const Text('Vehicules'),
                activeColor: Colors.greenAccent.shade700,
                darkActiveColor: Colors.greenAccent.shade400, // Optional
              ),
              BottomBarItem(
                icon: const Icon(Icons.settings, size: 18),
                title: const Text('Paramètres'),
                activeColor: Colors.orange,
              ),
            ],
          ),
        ));
  }
}
