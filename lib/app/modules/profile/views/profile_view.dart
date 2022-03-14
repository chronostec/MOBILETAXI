import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/services/local_storage.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/themes/styles/app_styles.dart';
import 'package:alfred_taxi_driver/app/utils/images_path.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppBarTheme.of(context).backgroundColor,
          elevation: 1,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: AppColors.DRED,
              ),
              onPressed: () async {
                final result = await showOkCancelAlertDialog(
                  context: context,
                  message:
                      "Vous etes sur le point de vous déconnecter de votre compte, c'est bien cela",
                  okLabel: 'Oui',
                  cancelLabel: 'Non',
                );
                print(result);
                if (result.toString().toLowerCase() == DIALOGRESULT.OK) {
                  LocalStorage().box.erase();
                  Get.offAllNamed(Routes.AUTHENTICATION);
                }
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              child: ListView(
                children: [
                  const Text(
                    "Editer Profile",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(PathImage.person_icon))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  buildTextField(
                      labelText: 'Nom',
                      placeholder: ctlHome.driver.value.nom ?? 'Mesabo',
                      isPasswordTextField: false,
                      controller: ctlProfile.fnameTF.value),
                  buildTextField(
                      labelText: 'Prénom',
                      placeholder: ctlHome.driver.value.prenom ?? 'Mesman',
                      isPasswordTextField: false,
                      controller: ctlProfile.lnameTF.value),
                  buildTextField(
                      labelText: 'Téléphone',
                      placeholder:
                          ctlHome.driver.value.telephone ?? '+2250101010101',
                      isPasswordTextField: false,
                      controller: ctlProfile.phoneTF.value,
                      inputType: TextInputType.phone),
                  buildTextField(
                      labelText: 'Mot de pass',
                      placeholder: "********",
                      isPasswordTextField: true,
                      controller: ctlProfile.passwordTF.value),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: outlinedButtonStyle(),
                        onPressed: () {
                          //TODO reset editing
                        },
                        child: const Text("ANNULER",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      ElevatedButton(
                        style: elevatedButtonStyle(color: AppColors.DRED1),
                        onPressed: () {},
                        child: const Text(
                          "ENREGISTRER",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String labelText,
    required String placeholder,
    required bool isPasswordTextField,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: inputType,
        obscureText:
            isPasswordTextField ? ctlProfile.showPassword.value : false,
        onChanged: (value) => print(controller.text),
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      ctlProfile.showPassword.value =
                          !ctlProfile.showPassword.value;
                      // print(ctlProfile.showPassword.value);
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
