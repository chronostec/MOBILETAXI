import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'driving_modal_fit.dart';

class DrivingPendingCmdeBottom extends StatelessWidget {
  const DrivingPendingCmdeBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        child: Container(
          height: 14.h,
          width: 98.w,
          decoration: BoxDecoration(
            color: AppColor.CWHITE,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SpinKitThreeInOut(color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Icon(Icons.keyboard_arrow_up),
                  )
                ],
              ),
            Chip(
                    label: Text(
                        'Arrivée prévue dans ${ctlMapCourse.drivingDistMatrix.value.rows != null && ctlMapCourse.drivingDistMatrix.value.rows!.length > 0 ? ctlMapCourse.drivingDistMatrix.value.rows![0].elements![0].duration!.text : '... min'}'))
            ],
          ),
        ),
        onTap: () {
          showDrivingDetails(context);
        },
      ),
    );
  }

  showDrivingDetails(context) async {
    return await showMaterialModalBottomSheet(
      expand: false,
      bounce: true,
      isDismissible: true,
      elevation: 20,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DrivingModalFit(),
    );
  }
}
