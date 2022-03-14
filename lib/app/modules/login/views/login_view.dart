import 'package:alfred_taxi_client/app/common/controllers.dart' show ctlLogin;
import 'package:alfred_taxi_client/app/modules/utils/spinkit_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import 'buttons.dart';
import 'phone_number_field.dart';
import 'validation_login_view.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(24.0),
          child: ctlLogin.isOTPview.value
              ? ValidationLoginView()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "N° Téléphone",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 42),
                    ),
                    PhonenumberFIELD(),
                    athenticationBTN(
                      ontap: () async {
                        await ctlLogin.envoyerTelephone();
                        ctlLogin.phoneNumber.value = ctlLogin.phoneTF.text;
                        ctlLogin.isPhoneSending.value
                            ? showEndedCoursetDialog(context: context)
                            : null;
                      },
                    ),
                  ],
                ),
        ),
      )),
    );
  }
}
