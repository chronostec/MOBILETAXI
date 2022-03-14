import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors/app_colors.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final _formKey = GlobalKey<FormState>();

  SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30.0),
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
                        "INSCRIPTION  ",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                /// TELEPHONE
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Téléphone',
                      ),
                      initialCountryCode: 'CI',
                      // controller: ctlSignup.phoneTC,
                      onChanged: (phone) {
                        print(phone.completeNumber);
                        ctlSignup.phoneTC.text = phone.completeNumber;
                      },
                      disableLengthCheck: false,
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            value.isPhoneNumber &&
                            ctlSignup.phoneTC.text.toString().length > 6) {
                          return null;
                        } else {
                          return "téléphone requis !";
                        }
                      },
                    )),

                /// NOM
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                    controller: ctlSignup.nomTC,
                    validator: (value) {
                      if (value!.isNotEmpty && value.toString().length > 1) {
                        return null;
                      } else {
                        return "minimum 2 caractères requis!";
                      }
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Nom",
                    ),
                  ),
                ),

                /// PRENOM
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                    controller: ctlSignup.prenomTC,
                    validator: (value) {
                      if (value!.isNotEmpty && value.toString().length > 1) {
                        return null;
                      } else {
                        return "minimum 2 caractères requis!";
                      }
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "Prénom",
                    ),
                  ),
                ),

                /// EMAIL
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                    controller: ctlSignup.emailTC,
                    validator: (value) {
                      if (value!.isNotEmpty && value.trim().isEmail) {
                        return null;
                      } else {
                        return "e-mail invalide !";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: "E-mail",
                    ),
                  ),
                ),

                /// PASSWORD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                    maxLength: 6,
                    controller: ctlSignup.passwordTC,
                    validator: (value) {
                      if (value!.isNotEmpty && value.toString().length == 6) {
                        return null;
                      } else {
                        return "minimum 6 caractères requis!";
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Mot de passe",
                    ),
                  ),
                ),

                /// CONFIRM PASSWORD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                    maxLength: 6,
                    controller: ctlSignup.confirmpasswordTC,
                    validator: (value) {
                      if (value!.isNotEmpty && value.toString().length == 6) {
                        return null;
                      } else {
                        return "minimum 6 caractères requis!";
                      }
                    },
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirmer mot de passe",
                    ),
                  ),
                ),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      )),
                ),
                const SizedBox(height: 40.0),
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
                        if (ctlSignup.confirmpasswordTC.text ==
                            ctlSignup.passwordTC.text) {
                          ctlSignup.signupFN();
                        } else {
                          Get.snackbar("Erreur",
                              "Les mot de pass ne correspondent pas !!");
                        }
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "S'inscrire".toUpperCase(),
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
                const SizedBox(height: 50.0),
              ],
            )),
      ),
    );
  }
}
