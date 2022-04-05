import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/services/local_storage.dart';
import 'package:alfred_taxi_driver/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_driver/app/modules/history/views/history_view.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'images_path.dart';

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
          decoration: BoxDecoration(
              color: primary,
              boxShadow: const [BoxShadow(color: Colors.black45)]),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        color: LightColor.yellow2,
                        boxShadow: [BoxShadow(color: Colors.black45)]),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.power_settings_new,
                              color: active,
                            ),
                            onPressed: () async {
                              await showPlatformDialog(
                                  context: context,
                                  builder: (context) {
                                    return PlatformAlertDialog(
                                      title: const Text("Se déconnecter"),
                                      content: const Text(
                                          "Vous etes sur le point de vous déconnecter de votre compte, c'est bien cela"),
                                      actions: [
                                        PlatformDialogAction(
                                          onPressed: () {
                                            LocalStorage().box.erase();
                                            Get.offAllNamed(
                                                Routes.AUTHENTICATION);
                                          },
                                          child: const Text('Déconnecter'),
                                        ),
                                        PlatformDialogAction(
                                          onPressed: () async {
                                            Get.back();
                                          },
                                          child: const Text('Rester'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                        Container(
                          height: 90,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              // gradient: LinearGradient(
                              //     colors: [Colors.orange, Colors.deepOrange]),
                              ),
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
                        SizedBox(height: 10.sp),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildRow(
                          CupertinoIcons.house,
                          "Accueil",
                          showBadge: true,
                          badgeText: ctlcommande.listCommande.length,
                          ontap: () {
                            Get.back();
                            checkCommandedisponiblePeriodicEvent();
                            ctlHome.ghomeKey.currentState!.openEndDrawer();
                          },
                        ),
                        _buildRow(
                          CupertinoIcons.line_horizontal_3_decrease,
                          "Historique",
                          ontap: () {
                            ctlHistory.onInit();
                            Get.to(() => HistoryView());
                            ctlHome.ghomeKey.currentState!.openEndDrawer();
                          },
                        ),
                        _buildRow(
                          CupertinoIcons.bag,
                          "Rechargement",
                          ontap: () {
                            Get.toNamed(Routes.RECHARGEMENT);
                            ctlHome.ghomeKey.currentState!.openEndDrawer();
                          },
                        ),
                        _buildRow(
                          CupertinoIcons.person,
                          "Mon profile",
                          ontap: () {
                            Get.toNamed(Routes.PROFILE);
                            ctlHome.ghomeKey.currentState!.openEndDrawer();
                          },
                        ),
                        _buildRow(
                          CupertinoIcons.settings,
                          "Paramètres",
                          ontap: () {
                            Get.toNamed(Routes.PARAMETRES);
                            ctlHome.ghomeKey.currentState!.openEndDrawer();
                          },
                        ),
                        _buildRow(
                          CupertinoIcons.chat_bubble_2,
                          "Nous contacter",
                          ontap: () {
                            Get.toNamed(Routes.SUPPORT);
                            ctlHome.ghomeKey.currentState!.openEndDrawer();
                          },
                        ),
                      ],
                    ),
                  )
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
    final TextStyle tStyle = TextStyle(
      color: active,
      fontSize: 15.sp,
    );
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: Row(children: [
          Icon(
            icon,
            color: divider,
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
