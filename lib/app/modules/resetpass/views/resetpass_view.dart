import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';

import '../../../themes/colors/app_colors.dart';
import '../controllers/resetpass_controller.dart';

class ResetpassView extends GetView<ResetpassController> {
  final _formKey = GlobalKey<FormState>();
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
                        width: 70.w,
                        height: 12.h,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text(
                        "REINITIALISATION  ",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 8.0),
                    child: IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Téléphone',
                        // hintText: '10 00 00 00 01',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'CI',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                      disableLengthCheck: false,
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            value.isPhoneNumber &&
                            value.toString().length > 6) {
                          ctlOtp.phoneNumber.value = value;
                          print("téléphone $value");
                          return null;
                        } else {
                          return "téléphone requis !";
                        }
                      },
                    )),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                    color: AppColor.PYELLOW,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.snackbar("Merci",
                            "Un code de validation vous a été envoyé par sms à ce numéro !");
                        Get.offAllNamed(Routes.OTP);
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "envoyer".toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        const SizedBox(width: 40.0),
                        const Icon(
                          FontAwesomeIcons.arrowRight,
                          size: 18.0,
                        )
                      ],
                    ),
                  ),
                ),
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
                Container(
                  padding: const EdgeInsets.only(right: 16.0),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        print("Créer un compte");
                        Get.offAllNamed(Routes.SIGNUP);
                      },
                      child: const Text(
                        "Créer un compte",
                        style: TextStyle(
                            color: AppColor.PBLUEDARK,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      )),
                ),
                const SizedBox(height: 50.0),
              ],
            )),
      ),
    );
  }
}
