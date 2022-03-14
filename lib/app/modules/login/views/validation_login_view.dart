import 'package:alfred_taxi_client/app/common/controllers.dart'
    show ctlHome, ctlLogin, ctlMapCourse;
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'buttons.dart';

class ValidationLoginView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "N° Téléphone",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 42),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              height: 5.h,
              width: 80.w,
              decoration: BoxDecoration(
                  // color: Colors.black38,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  ctlLogin.phoneNumber.value,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 28),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 4),
            child: Text(
              "Confirmer",
              style: TextStyle(fontSize: 42),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 24),
            child: Text(
              "Veuillez saisir le code que vous avez reçu par SMS",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              height: 5.h,
              width: 90.w,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Renvoyer le message",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                    IconButton(
                        onPressed: () {
                          ctlLogin.envoyerTelephone();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 36,
                        ))
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 55,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: TextStyle(fontSize: 17),
              onChanged: (pin) async {},
              onCompleted: (pin) async {
                printInfo(info: "INFO PIN $pin");
                ctlLogin.isCodeSending.value
                    ? const SpinKitWave(
                        color: Colors.deepOrange, type: SpinKitWaveType.center)
                    : null;
                ctlLogin.envoyerCodeOTP(pin: pin);
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 16),
          //   child: athenticationBTN(
          //     title: 'VALIDER',
          //     ontap: () {
          //       ctlLogin.envoyerCodeOTP(pin: ctlLogin.pin.value);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
