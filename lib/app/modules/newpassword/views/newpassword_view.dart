import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../controllers/newpassword_controller.dart';

class NewpasswordView extends GetView<NewpasswordController> {
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
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20.0)),
                        width: 95.w,
                        height: 12.h,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: Text("NOUVEAU MOT DE PASS",
                          style: TextStyle(
                              fontSize: 26.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),

                /// PASSWORD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                      controller: ctlNewpassword.passwordTC,
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
                      style: const TextStyle(fontSize: 32)),
                ),

                /// CONFIRM PASSWORD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextFormField(
                      maxLength: 6,
                      controller: ctlNewpassword.confirmPasswordTC,
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
                      style: const TextStyle(fontSize: 32)),
                ),

                const SizedBox(height: 60.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                    color: Colors.yellow,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (ctlNewpassword.confirmPasswordTC.text ==
                            ctlNewpassword.passwordTC.text) {
                          ctlNewpassword.puNewPasswordFN();
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
