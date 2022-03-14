import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/images_path.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../controllers/parametres_controller.dart';
import 'changeLangThemeSheet.dart';

class ParametresView extends GetView<ParametresController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Parametres'),
          centerTitle: true,
        ),
        body: Obx(
          () => Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                              FontAwesomeIcons.language,
                              color: AppColors.DRED1,
                            ),
                            title: const Text("Changer Langue"),
                            subtitle:
                                Text(ctlParametre.language.value.toLowerCase()),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              final result = await showChangeLanguage(context);
                              print(result);
                              ctlParametre.changerLangue(result);
                            },
                          ),
                          _buildDivider(),
                          ListTile(
                            leading: const Icon(
                              FontAwesomeIcons.moon,
                              color: AppColors.DRED1,
                            ),
                            title: const Text("Changer Thème"),
                            subtitle:
                                Text(ctlParametre.apptheme.value.toLowerCase()),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                            onTap: () async {
                              final result = await showChangeTheme(context);
                              print(result);
                              ctlParametre.changerTheme(result);
                            },
                          ),
                          _buildDivider(),
                          ListTile(
                            leading: const Icon(
                              FontAwesomeIcons.copyright,
                              color: AppColors.DRED1,
                            ),
                            title: const Text("Consulter Licence"),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              //open change location
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Paramètres de notifications",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    SwitchListTile(
                      activeColor: AppColors.DRED1,
                      contentPadding: const EdgeInsets.all(0),
                      value: ctlParametre.receiveNotifications.value,
                      title: const Text("Receivoir notifications"),
                      onChanged: (value) {
                        ctlParametre.receiveNotifications.value = value;
                      },
                    ),
                    SwitchListTile(
                      activeColor: AppColors.DRED1,
                      contentPadding: const EdgeInsets.all(0),
                      value: ctlParametre.receiveUpdate.value,
                      title: const Text("Receivoir mise à jour"),
                      onChanged: (value) {
                        ctlParametre.receiveUpdate.value = value;
                      },
                    ),
                    const SizedBox(height: 60.0),
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
}
