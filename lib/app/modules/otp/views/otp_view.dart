import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/routes/app_pages.dart';
import 'package:fredy_proprio/app/themes/colors/app_colors.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:sizer/sizer.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  final _formKey = GlobalKey<FormState>();
  OtpTimerButtonController _timerController = OtpTimerButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100.0),
                Stack(
                  children: <Widget>[
                    Positioned(
                      left: 20.0,
                      top: 10.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.PYELLOW,
                            borderRadius: BorderRadius.circular(20.0)),
                        width: 95.w,
                        height: 12.h,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        "CODE DE VALIDATION ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 26.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                const Center(
                  child: Text(
                    "Saisir le code envoyé au",
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() => Center(
                      child: Text(
                        ctlOtp.phoneNumber.value,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 26.0, fontWeight: FontWeight.bold),
                      ),
                    )),
                const SizedBox(height: 70.0),
                const OtpConfirmView(),
                const SizedBox(height: 20.0),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(FontAwesomeIcons.redo, size: 18.0),
                              const SizedBox(width: 5.0),
                              OtpTimerButton(
                                  buttonType: ButtonType.text_button,
                                  controller: _timerController,
                                  onPressed: () {
                                    _timerController.startTimer();
                                  },
                                  text: Text("Renvoyer code".toUpperCase(),
                                      style: const TextStyle(
                                          // color: AppColor.PBLACK,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0)),
                                  duration: 80)
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              disabledColor: AppColor.PGREY0,
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 16.0, 10.0, 16.0),
                              color: AppColor.PYELLOW,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: ctlOtp.isComplete.value
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        Get.snackbar("Merci",
                                            "Veuillez bien conserver le code que vous aller saisir !!",
                                            duration:
                                                const Duration(seconds: 5));
                                        Get.offAllNamed(Routes.NEWPASSWORD);
                                      }
                                    }
                                  : null,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "envoyer".toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  const SizedBox(width: 40.0),
                                  const Icon(
                                    FontAwesomeIcons.arrowRight,
                                    size: 18.0,
                                  )
                                ],
                              ),
                            )),
                      ],
                    )),
                const SizedBox(height: 60.0),
                Container(
                  padding: const EdgeInsets.only(right: 16.0, top: 16),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        print("Dejà inscrit?  se connecter");
                        Get.offAllNamed(Routes.SIGNIN);
                      },
                      child: const Text(
                        "Dejà inscrit?  se connecter",
                        style: TextStyle(
                            color: AppColor.PBLUEDARK,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      )),
                ),
              ],
            )),
      ),
    );
  }
}

class OtpConfirmView extends StatefulWidget {
  const OtpConfirmView({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpConfirmView> createState() => _OtpConfirmViewState();
}

class _OtpConfirmViewState extends State<OtpConfirmView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
      child: OTPTextField(
        controller: ctlOtp.phoneTC,
        length: 4,
        width: MediaQuery.of(context).size.width,
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldWidth: 55,
        fieldStyle: FieldStyle.box,
        outlineBorderRadius: 15,
        style: const TextStyle(fontSize: 17),
        onChanged: (pin) {
          print("Changed: " + pin);
          if (pin.length == 4) {
            ctlOtp.isComplete.value = true;
          } else {
            ctlOtp.isComplete.value = false;
          }
        },
        onCompleted: (pin) {
          print("Completed: " + pin);
          if (pin.length == 4) {
            ctlOtp.isComplete.value = true;
          } else {
            ctlOtp.isComplete.value = false;
          }

          ///TODO
        },
      ),
    );
  }
}
