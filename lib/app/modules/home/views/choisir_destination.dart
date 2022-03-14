import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BOTTOMGO extends StatelessWidget {
  const BOTTOMGO({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
          width: 100.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: AppColor.CGREY),
          child: TextField(
            maxLines: 1,
            textAlign: TextAlign.center,
            readOnly: true,
            style: TextStyle(
                color: AppColor.CBLACK,
                fontWeight: FontWeight.bold,
                fontSize: 28),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                  "${ctlMapCourse.pointPosition.value.libelle ?? 'Ou allez-vous ?'}",
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            onTap: () => Get.toNamed(Routes.RECHERCHE),
          )),
    );
  }
}
