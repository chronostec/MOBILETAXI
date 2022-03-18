// import 'package:alfred_taxi_client/app/common/controllers.dart'
//     show ctlHome, ctlLogin, ctlMapCourse;
// import 'package:alfred_taxi_client/app/common/keywords.dart';
// import 'package:alfred_taxi_client/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// import 'buttons.dart';

// class ValidationLoginView extends GetView {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             "N° Téléphone",
//             style: TextStyle(fontWeight: FontWeight.w400, fontSize: 42),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Container(
//               height: 5.h,
//               width: 80.w,
//               decoration: BoxDecoration(
//                   // color: Colors.black38,
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(5)),
//               child: Center(
//                 child: Text(
//                   ctlLogin.phoneNumber.value,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w400, fontSize: 28),
//                 ),
//               ),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 16, bottom: 4),
//             child: Text(
//               "Confirmer",
//               style: TextStyle(fontSize: 42),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 16, bottom: 24),
//             child: Text(
//               "Veuillez saisir le code que vous avez reçu par SMS",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 22),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: SizedBox(
//               height: 5.h,
//               width: 90.w,
//               child: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Renvoyer le message",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           ctlLogin.envoyerTelephone();
//                         },
//                         icon: const Icon(
//                           Icons.refresh,
//                           size: 36,
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: OTPTextField(
//               length: 4,
//               width: MediaQuery.of(context).size.width,
//               textFieldAlignment: MainAxisAlignment.spaceAround,
//               fieldWidth: 55,
//               fieldStyle: FieldStyle.box,
//               outlineBorderRadius: 15,
//               style: TextStyle(fontSize: 17),
//               onChanged: (pin) async {},
//               onCompleted: (pin) async {
//                 ctlLogin.isCodeSending.value
//                     ? const SpinKitWave(
//                         color: Colors.deepOrange, type: SpinKitWaveType.center)
//                     : null;

//                 // ctlLogin.pin.value = pin;
//                 var result = await ctlLogin.envoyerCodeOTP(pin: pin);
//                 if (result.Message == "succes") {
//                   ctlHome.user_is_connected.value = true;
//                   Get.back();
//                   ctlMapCourse.statuscommand.value =
//                       CMDSTATUS.COMMAND_TRAITEMENT;
//                   // Get.offAllNamed(Routes.MA_COURSE);
//                 } else {
//                   Get.snackbar("CODE OTP",
//                       "Le code que vous avez saisi est incorrect ou a expiré ! Veuillez recommencer svp.",
//                       backgroundColor: Colors.deepOrange,
//                       colorText: Colors.white,
//                       duration: const Duration(seconds: 4));
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: athenticationBTN(
//               title: 'VALIDER',
//               ontap: () {
//                 ctlLogin.envoyerCodeOTP(pin: ctlLogin.pin.value);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:alfred_taxi_client/app/common/controllers.dart'
    show ctlHome, ctlLogin, ctlMapCourse;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ValidationLoginView extends StatefulWidget {
  @override
  State<ValidationLoginView> createState() => _ValidationLoginViewState();
}

class _ValidationLoginViewState extends State<ValidationLoginView> {
  String _code = "";
  String signature = "{{ app signature }}";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

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
          PinFieldAutoFill(
            codeLength: 4,
            decoration: BoxLooseDecoration(
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
              strokeColorBuilder:
                  FixedColorBuilder(Colors.black.withOpacity(0.3)),
            ),
            currentCode: ctlLogin.smsCode.value,
            onCodeSubmitted: (code) {
              ctlLogin.smsCode.value = ctlLogin.smsCode.value;
              ctlLogin.envoyerCodeOTP(pin: code).then((value) {
                if (value.bSuccess == true) {
                  Get.back();
                  Get.snackbar("Félicitation !!!",
                      "Code confirmé avec succès, veuillez confirmer votre commande maintenant.");
                } else {
                  Get.snackbar("Echec Code",
                      "Code erronné !\nVeuillez recommencer svp.");
                }
              });
            },
            onCodeChanged: (code) {
              ctlLogin.smsCode.value = ctlLogin.smsCode.value;
              if (code!.length == 4) {
                ctlLogin.envoyerCodeOTP(pin: code).then((value) {
                  if (value.bSuccess == true) {
                    Get.back();
                    Get.snackbar("Félicitation !!!",
                        "Code confirmé avec succès, veuillez confirmer votre commande maintenant.");
                  } else {
                    Get.snackbar("Echec Code",
                        "Code erronné !\nVeuillez recommencer svp.");
                  }
                });
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
          ),
        ],
      ),
    );
  }
}
