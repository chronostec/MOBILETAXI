import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import 'driver_details_modal_fit.dart';
import 'driving_modal_fit.dart';

class DriverComesCmdeBottom extends StatelessWidget {
  const DriverComesCmdeBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        child: Container(
          height: 8.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColor.CWHITE,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              // Chip(label: Text('En attente du chauffeur')),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_up),
                leading: Container(
                  height: 40,
                  width: 40,
                  // color: Colors.amber,
                  child: const SpinKitDoubleBounce(color: Colors.red),
                ),
                title: Chip(label: Text('En attente du chauffeur')),
              ),
            ],
          ),
        ),
        onTap: () {
          if (ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_ACCEPTEE) {
            showDriverDetails(context);
          } else {
            showDrivingDetails(context);
          }
        },
      ),
    );
  }

  /// SHOW CATEGORIES
  showDriverDetails(context) async {
    return await showMaterialModalBottomSheet(
      expand: false,
      bounce: true,
      isDismissible: true,
      elevation: 20,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DriverDetailModalFit(),
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
