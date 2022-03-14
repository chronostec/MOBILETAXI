import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneTF = TextEditingController();
  TextEditingController _passTF = TextEditingController();

  AuthenticationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Card(
                    color: AppColors.DRED1,
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 10,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                const SizedBox(height: 40.0),
                Text(
                  "Bienvenu",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const Text(
                  "Saisir vos identifiants",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Card(
                    margin: const EdgeInsets.all(32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        const SizedBox(height: 20.0),
                        Text(
                          "Compte Chauffeur",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: AppColors.DRED1,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40.0),
                        TextFormField(
                          controller: _phoneTF,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              value!.isNotEmpty ? null : "champs requis !",
                          decoration: const InputDecoration(
                              labelText: "Entrer  téléphone",
                              labelStyle: TextStyle(color: AppColors.DRED1),
                              hintText: "07 07 07 07 07",
                              prefixIcon:
                                  Icon(Icons.phone, color: AppColors.DRED1),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.DRED1))),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passTF,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              value!.isNotEmpty ? null : "champs requis !",
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: "Enter mot de passe",
                              labelStyle: TextStyle(color: AppColors.DRED1),
                              hintText: "* * * * * * *  * * ",
                              prefixIcon:
                                  Icon(Icons.phone, color: AppColors.DRED1),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.DRED1))),
                        ),
                        const SizedBox(height: 30.0),
                        ElevatedButton(
                          child: const Text(
                            "ENVOYER",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                letterSpacing: 4),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const AlertDialog(
                                  content: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: SpinKitRing(
                                        color: Colors.red,
                                        size: 60,
                                        lineWidth: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              await ctlAuth
                                  .signIn(
                                      phone: _phoneTF.text,
                                      password: _passTF.text)
                                  .then((value) {
                                if (value) {
                                  Get.offAllNamed(Routes.HOME);
                                } else {
                                  Get.back();
                                  Get.snackbar("ALERTE AUTHENTIFICATION",
                                      "Vos identifiants sont incorrects, veuilez réessayer svp.",
                                      duration: const Duration(seconds: 4));
                                }
                              });
                            } else {
                              Get.snackbar("ALERTE FORMULAIRE",
                                  "Veuillez s'il vous plait renseigner tous les champs du formulaire.");
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.DRED1),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(16)),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
