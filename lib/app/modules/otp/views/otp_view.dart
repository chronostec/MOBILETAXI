import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/modules/otp/views/rounded_with_cursor.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:sizer/sizer.dart';

import '../controllers/otp_controller.dart';
import 'otp_header.dart';

class OtpView extends StatefulWidget {
  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final _formKey = GlobalKey<FormState>();
  OtpTimerButtonController _timerController = OtpTimerButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              // padding: EdgeInsets.fromLTRB(24, 64, 24, 24),
              child: Column(
                children: [
                  OtpHeader(),
                  RoundedWithCustomCursor(),
                  const SizedBox(height: 44),
                  Text(
                    "Vous n'avez pas reçu de code ?",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color.fromRGBO(62, 116, 165, 1),
                    ),
                  ),
                  OtpTimerButton(
                      buttonType: ButtonType.text_button,
                      controller: _timerController,
                      onPressed: () {
                        _timerController.startTimer();
                      },
                      text: Text('Renvoyer',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(62, 116, 165, 1))),
                      duration: 80),
                ],
              ),
            ),
          ),
          ctlOtp.isLoading.value
              ? Center(
                  child: Container(
                  color: Colors.black45,
                  height: 100.h,
                  width: 100.w,
                  child: SpinKitCircle(
                    color: AppColors.DRED1,
                    size: 100,
                  ),
                ))
              : SizedBox()
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
