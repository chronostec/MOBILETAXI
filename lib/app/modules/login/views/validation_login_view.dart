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
                    Get.back();
                    Get.snackbar("Félicitation !!!",
                        "Code confirmé avec succès, veuillez confirmer votre commande maintenant.");
                  } else {
                    Get.snackbar("Echec Code",
                        "Code erronné !\nVeuillez recommencer svp.");
                  }
                });
                FocusScope.of(context).requestFocus(FocusNode());
                // ctlLogin.envoyerCodeOTP(pin: code);
              }
            },
          ),
        ],
      ),
    );
  }
}

class SmsAutoFillpage extends StatefulWidget {
  @override
  _SmsAutoFillpageState createState() => _SmsAutoFillpageState();
}

class _SmsAutoFillpageState extends State<SmsAutoFillpage> {
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          PhoneFieldHint(),
          Spacer(),
          PinFieldAutoFill(
            decoration: UnderlineDecoration(
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
              colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
            ),
            currentCode: _code,
            onCodeSubmitted: (code) {},
            onCodeChanged: (code) {
              if (code!.length == 6) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
          ),
          Spacer(),
          TextFieldPinAutoFill(
            currentCode: _code,
          ),
          Spacer(),
          ElevatedButton(
            child: Text('Listen for sms code'),
            onPressed: () async {
              await SmsAutoFill().listenForCode;
            },
          ),
          ElevatedButton(
            child: Text('Set code to 123456'),
            onPressed: () async {
              setState(() {
                _code = '123456';
              });
            },
          ),
          SizedBox(height: 8.0),
          Divider(height: 1.0),
          SizedBox(height: 4.0),
          Text("App Signature : $signature"),
          SizedBox(height: 4.0),
          ElevatedButton(
            child: Text('Get app signature'),
            onPressed: () async {
              signature = await SmsAutoFill().getAppSignature;
              setState(() {});
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (_) => CodeAutoFillTestPage()));
            },
            child: Text("Test CodeAutoFill mixin"),
          )
        ],
      ),
    );
  }
}
