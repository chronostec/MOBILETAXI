import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors/app_colors.dart';
import '../controllers/oldpassword_controller.dart';

class OldpasswordView extends GetView<OldpasswordController> {
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
                        "ANCIEN MOT DE PASS  ",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                  child: TextFormField(
                    maxLength: 6,
                    controller: ctlOldpassword.passwordTC,
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
                      labelText: "Mot de passe",
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        print("Mot de passe oublié");
                        Get.offAllNamed(Routes.RESETPASS);
                      },
                      child: const Text(
                        "Mot de passe oublié?",
                        style: TextStyle(
                          color: Colors.black,
                        ),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      )),
                ),
                const SizedBox(height: 60.0),
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
                        Get.snackbar(
                            "Merci", "COnnexion établie avec succès !");
                        Get.offAllNamed(Routes.HOME);
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Envoyer".toUpperCase(),
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
