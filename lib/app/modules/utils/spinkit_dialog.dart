import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

/// SHOW AWAIT DIALOG
showEndedCoursetDialog({
  required context,
}) async {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        height: 25.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              "Patientez svp",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 4,
              ),
            ),
            Center(
              child: SpinKitDualRing(
                color: AppColor.CRED,
                lineWidth: 10,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
