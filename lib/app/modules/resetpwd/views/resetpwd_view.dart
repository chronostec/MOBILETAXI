import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/resetpwd_controller.dart';

class ResetpwdView extends GetView<ResetpwdController> {
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
                              "REINITIALISATION",
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
                    child: TextFormField(
                      maxLength: 6,
                      controller: ctlResetpwd.password1TC,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 8.0),
                    child: TextFormField(
                      maxLength: 6,
                      controller: ctlResetpwd.password2TC,
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
                        labelText: "Confirmer mot de passe",
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
                          if (ctlResetpwd.password1TC.text ==
                              ctlResetpwd.password2TC.text) {
                            Get.offAllNamed(Routes.SIGNIN);
                          } else {
                            Get.snackbar(
                                'Attention', "Mots de passe non identiques");
                          }
                        } else
                          Get.snackbar('Attention',
                              "Vous devez remplir identiquement tous les champs");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Envoyer".toUpperCase(),
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
                          Get.offAllNamed(Routes.SIGNIN);
                        },
                        child: const Text(
                          "Se connecter ici",
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        )),
                  ),
                ],
              ))),
    );
  }
}
