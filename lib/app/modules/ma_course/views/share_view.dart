import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

class ShareView extends GetView {
  TextEditingController _shareTF = TextEditingController();
  GlobalKey _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.CWHITE,
        title: Text("PARTAGER CETTE COURSE",
            style: TextStyle(
                color: AppColor.CBLACK,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "",
                style: TextStyle(
                  color: AppColor.CBLACK,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: InternationalPhoneNumberInput(
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          initialValue: ctlLogin.number.value,
                          // textFieldController: _shareTF,
                          hintText: '01 01 01 01 01',
                          formatInput: false,
                          keyboardType: TextInputType.phone,
                          onInputValidated: (bool value) {},
                          inputBorder: InputBorder.none,
                          onSaved: (value) {
                            // print(
                            //     "PHONE NUMBER: ${ctlLogin.phoneNumber.value}");
                            // ctlLogin.phoneNumber.value =
                            //     value.phoneNumber.toString();
                          },
                          onInputChanged: (value) {
                            // print(
                            //     "PHONE NUMBER: ${ctlLogin.phoneNumber.value}");
                            _shareTF.text = value.phoneNumber.toString();
                          }),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 8, right: 8),
              child: Text(
                "Informations partagées",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.minus, color: AppColor.CGREY),
                      SizedBox(width: 10),
                      Text(
                        "Immatriculation du véhicule",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.CGREY,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.minus, color: AppColor.CGREY),
                      SizedBox(width: 10),
                      Text(
                        "Nom du chauffeur",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.CGREY,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.minus, color: AppColor.CGREY),
                      SizedBox(width: 10),
                      Text(
                        "Votre destination",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.CGREY,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.minus, color: AppColor.CGREY),
                      SizedBox(width: 10),
                      Text(
                        "Votre position en temps réel",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.CGREY,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 24, horizontal: 4),
                    child: Text(
                      "Votre correspondant recevra un sms qui lui permettra de suivre votre course via un lien",
                      style: TextStyle(
                          color: AppColor.CGREY,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Obx(() => SizedBox(
                child: ctlPartage.is_partage_requesting.value
                    ? SizedBox(
                        height: 7.h,
                        child: SpinKitCircle(color: AppColor.CREDO))
                    : SizedBox(
                        width: 100.w,
                        child: CupertinoButton(
                            color: AppColor.CGREY,
                            child: Text("PARTAGER ",
                                style: TextStyle(
                                    color: AppColor.CBLACK,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 4,
                                    fontSize: 16)),
                            onPressed: () {
                              ctlPartage.postPartageToApi(
                                  numeropartage: _shareTF.text
                                      .trim()
                                      .substring(1, _shareTF.text.length),
                                  commande_id:
                                      ctlRecherche.maCommande.value.id ?? 0);
                            }))))
          ],
        ),
      ),
    );
  }
}
