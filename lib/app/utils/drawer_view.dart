import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/services/local_storage.dart';
import 'package:alfred_taxi_driver/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_driver/app/modules/history/views/history_view.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'images_path.dart';
import 'keywords.dart';
import 'oval_right_clipper.dart';

class BuildDrawer extends StatelessWidget {
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary,
              boxShadow: [const BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () async {
                        final result = await showOkCancelAlertDialog(
                            context: context,
                            message:
                                "Vous etes sur le point de vous déconnecter de votre compte, c'est bien cela",
                            okLabel: 'Oui',
                            cancelLabel: 'Non');
                        print(result);
                        if (result.toString().toLowerCase() ==
                            DIALOGRESULT.OK) {
                          LocalStorage().box.erase();
                          Get.offAllNamed(Routes.AUTHENTICATION);
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange])),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(PathImage.person_icon),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "${ctlHome.driver.value.nom ?? "Votre nom"} ${ctlHome.driver.value.prenom ?? ""}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "VEHICULE ${ctlHome.driver.value.immatriculation ?? ""}",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  const SizedBox(height: 30.0),
                  _buildRow(
                    Icons.home,
                    "Accueil",
                    showBadge: true,
                    badgeText: ctlcommande.listCommande.length,
                    ontap: () {
                      Get.back();
                      checkCommandedisponiblePeriodicEvent();
                      ctlHome.ghomeKey.currentState!.openEndDrawer();
                    },
                  ),
                  // _buildDivider(),
                  // _buildRow(
                  //   Icons.person_pin,
                  //   "Chat",
                  //   ontap: () {
                  //     Get.toNamed(Routes.CHATBOX);
                  //     ctlHome.ghomeKey.currentState!.openEndDrawer();
                  //   },
                  // ),
                  _buildDivider(),
                  _buildRow(
                    Icons.history,
                    "Historique",
                    ontap: () {
                      ctlHistory.onInit();
                      Get.to(() => HistoryView());
                      ctlHome.ghomeKey.currentState!.openEndDrawer();
                    },
                  ),
                  _buildDivider(),
                  _buildRow(
                    Icons.attach_money,
                    "Rechargement",
                    ontap: () {
                      Get.toNamed(Routes.RECHARGEMENT);
                      ctlHome.ghomeKey.currentState!.openEndDrawer();
                    },
                  ),
                  _buildDivider(),
                  _buildRow(
                    Icons.account_box,
                    "Mon profile",
                    ontap: () {
                      Get.toNamed(Routes.PROFILE);
                      ctlHome.ghomeKey.currentState!.openEndDrawer();
                    },
                  ),

                  _buildDivider(),
                  _buildRow(
                    Icons.settings,
                    "Paramètres",
                    ontap: () {
                      Get.toNamed(Routes.PARAMETRES);
                      ctlHome.ghomeKey.currentState!.openEndDrawer();
                    },
                  ),
                  _buildDivider(),
                  _buildRow(
                    Icons.email,
                    "Nous contacter",
                    ontap: () {
                      Get.toNamed(Routes.SUPPORT);
                      ctlHome.ghomeKey.currentState!.openEndDrawer();
                    },
                  ),
                  _buildDivider(),
                  // _buildRow(
                  //   Icons.info_outline,
                  //   "Aide",
                  //   ontap: () {
                  //     Get.toNamed(Routes.AIDE);
                  //     ctlHome.ghomeKey.currentState!.openEndDrawer();
                  //   },
                  // ),
                  // _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title,
      {bool showBadge = false, badgeText = 10, ontap}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
            color: active,
          ),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          const Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "$badgeText+",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }
}
