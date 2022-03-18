import 'package:alfred_taxi_client/app/common/controllers.dart' show ctlLogin;
import 'package:sms_autofill/sms_autofill.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:alfred_taxi_client/app/themes/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/login_controller.dart';
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Container(
                          height: 7.h,
                          decoration: BoxDecoration(
                              color: ctlLogin.isPhoneSending.value
                                  ? AppColor.CGREY
                                  : AppColor.CREDO,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: ctlLogin.isPhoneSending.value
                              ? Center(
                                  child: SpinKitCircle(color: AppColor.CREDO),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        child: Center(
                                          child: Text(
                                            "SUIVANT",
                                            style: categorybtnStyle(),
                                          ),
                                        ),
                                        // QUELLE ACTION EFFECTUER?
                                        onTap: () async {
                                          final signcode = await SmsAutoFill()
                                              .getAppSignature;
                                          print("Signature: $signcode");
                                          ctlLogin.phoneNumber.value =
                                              ctlLogin.phoneTF.text;
                                          await ctlLogin.envoyerTelephone();
                                          await SmsAutoFill().listenForCode;
                                        }),
                                    SizedBox(width: 2.w),
                                    Icon(CupertinoIcons.arrow_right_circle_fill,
                                        color: Colors.white)
                                  ],
                                )),
                    )
                  ],
                ),
        ),
      )),
    );
  }
}
