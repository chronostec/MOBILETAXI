import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/services/local_storage.dart';
import 'package:fredy_proprio/app/routes/app_pages.dart';
import 'package:fredy_proprio/app/themes/colors/app_colors.dart';
import 'package:fredy_proprio/app/themes/themeservice.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';

import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

import '../controllers/setting_controller.dart';
import 'languages_view.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Card(
                //     elevation: 8.0,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0)),
                //     color: Colors.orange,
                //     child: ListTile(
                //         onTap: () {
                //           //open edit profile
                //         },
                //         title: const Text("Mr Koffi Pascal",
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.w500)),
                //         leading: const CircleAvatar(
                //             backgroundImage: NetworkImage(AppImage.userImage)),
                //         trailing: const Icon(Icons.edit, color: Colors.white))),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                          Icons.lock_outline,
                          color: Colors.orange,
                        ),
                        title: const Text("Changer mot de passe"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Get.toNamed(Routes.CHANGEPASSWORD);
                        },
                      ),
                      // _buildDivider(),
                      // ListTile(
                      //   leading: const Icon(
                      //     FontAwesomeIcons.language,
                      //     color: Colors.orange,
                      //   ),
                      //   title: const Text("Changer Thème"),
                      //   trailing: const Icon(Icons.color_lens),
                      //   onTap: () {
                      //     ThemeService().switchTheme();
                      //     ctlSetting.changethemetext();
                      //   },
                      // ),
                      _buildDivider(),
                      ListTile(
                        leading: const Icon(
                          FontAwesomeIcons.language,
                          color: Colors.orange,
                        ),
                        title: const Text("Changer Langue"),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          // ThemeService().switchTheme();
                          // ctlSetting.changethemetext();
                        },
                      ),
                      _buildDivider(),
                      // ListTile(
                      //   leading: const Icon(
                      //     CupertinoIcons.color_filter_fill,
                      //     color: Colors.orange,
                      //   ),
                      //   title: const Text("Changer Thème"),
                      //   trailing: const Icon(Icons.keyboard_arrow_right),
                      //   onTap: () {
                      //     ThemeService().switchTheme();
                      //     ctlSetting.changethemetext();
                      //   },
                      // ),
                      // _buildDivider(),
                      ListTile(
                        leading: const Icon(
                          Icons.location_on,
                          color: Colors.orange,
                        ),
                        title: const Text("Déconnexion"),
                        trailing: const Icon(Icons.logout),
                        onTap: () {
                          LocalStorage().eraseUserData();
                          ctlHome.currentPage.value = 0;
                          Get.offAllNamed(Routes.SIGNIN);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                // const Text(
                //   "Notifications",
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.orange,
                //   ),
                // ),
                // SwitchListTile(
                //   activeColor: Colors.orange,
                //   contentPadding: const EdgeInsets.all(0),
                //   value: true,
                //   title: const Text("Received notification"),
                //   onChanged: (val) {},
                // ),
                // const SizedBox(height: 60.0),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  Widget buildSettingsList(context) {
    return SettingsList(
      // applicationType: ApplicationType.cupertino,
      sections: [
        SettingsSection(
          title: const Text('général'),
          tiles: [
            SettingsTile(
              title: const Text('Langue'),
              description: const Text('Français'),
              leading: const Icon(Icons.language),
              onPressed: (context) => Get.to(LanguagesView()),
            ),
            SettingsTile(
              title: const Text('Thème'),
              description: Text(ctlSetting.themecolor.value),
              leading: const Icon(Icons.color_lens),
              onPressed: (context) {
                ThemeService().switchTheme();
                ctlSetting.changethemetext();
              },
            ),
            SettingsTile(
              title: const Text('Sauvegarde'),
              description: const Text('en ligne'),
              leading: const Icon(Icons.cloud_queue),
            ),
          ],
        ),

        ///Account
        SettingsSection(
          title: const Text('Compte Utilisateur'),
          tiles: [
            SettingsTile(
                title: const Text('Utilisateur'),
                description: const Text('connexion'),
                leading: const Icon(Icons.person),
                onPressed: (context) {}),
            SettingsTile(
              title: const Text('Déconnexion'),
              description: const Text('changer compte'),
              leading: const Icon(Icons.logout),
              onPressed: (context) {
                Get.dialog(AlertDialog(
                  title: const Text(
                      'Êtes-vous sûr de vouloir changer de compte ?'),
                  actions: [
                    TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'non',
                          style: TextStyle(color: Colors.grey),
                        )),
                    TextButton(
                        onPressed: () {
                          // exit(0);
                        },
                        child: const Text('oui'))
                  ],
                ));
              },
            ),
          ],
        ),

        /// Version
        // CustomSection(
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(top: 22, bottom: 8),
        //         child: Image.asset(
        //           'assets/image/settings.png',
        //           height: 50,
        //           width: 50,
        //           color: Color(0xFF777777),
        //         ),
        //       ),
        //       Text(
        //         'Version: 1.0.0 (111)',
        //         style: TextStyle(color: Color(0xFF777777)),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
