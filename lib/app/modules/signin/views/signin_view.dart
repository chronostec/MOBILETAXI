import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/modules/resetpwd/views/resetpwd_view.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
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
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 4),
                            child: Text(
                              "AUTHENTIFICATION",
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8.0),
                      child: IntlPhoneField(
                        controller: ctlSignin.phoneTC,
                        decoration: const InputDecoration(
                          labelText: 'Téléphone',
                        ),
                        initialCountryCode: 'CI',
                        // controller: ctlSignin.phoneTC,
                        onChanged: (phone) {
                          print(phone.completeNumber);
                          // ctlSignin.phoneTC.text = phone.completeNumber;
                        },
                        disableLengthCheck: false,
                        validator: (value) {
                          if (value!.isNotEmpty &&
                              value.isPhoneNumber &&
                              ctlSignin.phoneTC.text.toString().length > 6) {
                            print(value);
                            return null;
                          } else {
                            return "téléphone requis !";
                          }
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 8.0),
                    child: TextFormField(
                      maxLength: 6,
                      controller: ctlSignin.passwordTC,
                      validator: (value) {
                        if (value!.isNotEmpty && value.toString().length == 6) {
                          return null;
                        } else {
                          return "requis!";
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        labelText: "Mot de passe",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      padding:
                          const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                      color: AppColors.DRED1,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('ok');
                          ctlSignin.signinUser();
                        } else
                          Get.snackbar(
                              'Attention', "Attention, champs obligatoires.");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Se connecter".toUpperCase(),
                            style: const TextStyle(
                                color: AppColors.DWHITE0,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          const SizedBox(width: 40.0),
                          const Icon(
                            CupertinoIcons.arrow_right_circle_fill,
                            size: 18.0,
                            color: AppColors.DWHITE0,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  Container(
                    padding: const EdgeInsets.only(right: 16.0, bottom: 4),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          print("Mot de passe oublié");
                          Get.toNamed(Routes.PHONEAUTH);
                        },
                        child: const Text(
                          "Changer mot de passe",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.only(right: 16.0),
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //       onPressed: () {
                  //         print("Créer un compte");
                  //         // Get.offAll(() => SignupView());
                  //       },
                  //       child: const Text(
                  //         "S'inscrire ici",
                  //         style: TextStyle(
                  //             color: AppColors.DRED1,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold,
                  //             decoration: TextDecoration.underline),
                  //       )),
                  // ),
                  const SizedBox(height: 50.0),
                ],
              ))),
    );
  }
}
