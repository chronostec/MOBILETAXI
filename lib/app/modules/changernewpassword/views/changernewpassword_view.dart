import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors/app_colors.dart';
import '../controllers/changernewpassword_controller.dart';

class ChangernewpasswordView extends GetView<ChangernewpasswordController> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(FontAwesomeIcons.backward,
                  color: AppColor.PORANGE)),
          title: const Text(
            "Nouveau Mot de Pass",
            style: TextStyle(
              color: AppColor.PORANGE,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100.0),

                /// PASSWORD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                    controller: ctlchangernewpassword.passwordTC,
                    maxLength: 6,
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
                    controller: ctlchangernewpassword.confirmPasswordTC,
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

                const SizedBox(height: 60.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                    color: AppColor.PORANGE,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (ctlchangernewpassword.confirmPasswordTC.text ==
                            ctlchangernewpassword.passwordTC.text) {
                          Get.snackbar("Félicitations",
                              "Mot de pass réinitialisé avec succès ! Merci de vous connecter svp.");
                          // Get.offAllNamed(Routes.SIGNIN);
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
