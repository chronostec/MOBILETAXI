import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/modules/history/views/history_view.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'images_path.dart';
import 'oval_right_clipper.dart';

class BuildDrawer extends StatelessWidget {
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
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
                      onPressed: () {},
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
                      backgroundImage: AssetImage(AppImage.person),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "${ctlHome.user.value.telephone ?? "Téléphone"}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 30.0),
                  _buildRow(
                    Icons.home,
                    "Accueil",
                    ontap: () {
                      Get.back();

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
                    ontap: () async {
                      await ctlHistorique.getHistorique();
                      Get.to(() => HistoryView());
                      ctlHome.ghomeKey.currentState!.openEndDrawer();
                    },
                  ),

                  // _buildDivider(),
                  // _buildRow(
                  //   Icons.settings,
                  //   "Paramètres",
                  //   ontap: () {
                  //     Get.toNamed(Routes.PARAMETRES);
                  //     ctlHome.ghomeKey.currentState!.openEndDrawer();
                  //   },
                  // ),
                  _buildDivider(),
                  _buildRow(
                    Icons.email,
                    "Nous contacter",
                    ontap: () {
                      Get.toNamed(Routes.SUPPORT);
                      ctlHome.ghomeKey.currentState!.openEndDrawer();
                    },
                  ),
                  // _buildDivider(),
                  // _buildRow(
                  //   Icons.info_outline,
                  //   "Aide",
                  //   ontap: () {
                  //     Get.toNamed(Routes.AIDE);
                  //     ctlHome.ghomeKey.currentState!.openEndDrawer();
                  //   },
                  // ),
                  _buildDivider(),
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
