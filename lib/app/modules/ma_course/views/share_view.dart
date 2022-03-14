import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
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
                child: TextField(
                  controller: _shareTF,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    labelText: "N° téléphone",
                    hintText: "+1 0102030405",
                  ),
                  onSubmitted: (value) {
                    if (_shareTF.text.isPhoneNumber) {
                    } else {}
                  },
                ),
              ),
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
            SizedBox(
              width: 100.w,
              child: CupertinoButton(
                color: AppColor.CGREY,
                child: Text(
                  "PARTAGER ",
                  style: TextStyle(
                      color: AppColor.CBLACK,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                      fontSize: 16),
                ),
                onPressed: () {
                  ctlPartage.postPartageToApi(
                      numeropartage: _shareTF.text.trim(),
                      commande_id: ctlRecherche.proposition_id.value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
