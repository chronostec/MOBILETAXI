import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/modules/phoneauth/views/phone_header.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controllers/phoneauth_controller.dart';

class PhoneauthView extends GetView<PhoneauthController> {
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
                  PhoneHeader(),
                  const SizedBox(height: 50.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8.0),
                      child: IntlPhoneField(
                        // controller: ctlPhoneauth.phoneTC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Téléphone',
                        ),
                        initialCountryCode: 'CI',
                        onChanged: (phone) {
                          // print(phone.completeNumber);
                          ctlPhoneauth.phoneTC.text = phone.completeNumber;
                        },
                        disableLengthCheck: false,
                        validator: (value) {
                          if (value!.isNotEmpty &&
                              value.isPhoneNumber &&
                              ctlPhoneauth.phoneTC.text.toString().length > 6) {
                            print(value);
                            return null;
                          } else {
                            return "téléphone requis !";
                          }
                        },
                      )),
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
                          Get.offNamed(Routes.OTP);
                        } else
                          Get.snackbar(
                              'Attention', "Attention, champs obligatoires.");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Recevoir sms".toUpperCase(),
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
                ],
              ))),
    );
  }
}
