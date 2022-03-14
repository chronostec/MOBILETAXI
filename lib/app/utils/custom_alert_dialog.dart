import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredy_proprio/app/themes/colors/app_colors.dart';
import 'package:sizer/sizer.dart';

myAwaitingDialog({
  required context,
}) async {
  showDialog(
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
                color: AppColor.PYELLOW,
                lineWidth: 10,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
