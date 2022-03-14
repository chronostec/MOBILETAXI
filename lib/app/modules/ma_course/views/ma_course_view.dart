import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ma_course_controller.dart';
import 'commande_awaiting_bottom.dart';
import 'driver_come_bottom_cmde.dart';
import 'driving_pending_bottom_cmde.dart';

class MaCourseView extends GetView<MaCourseController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Stack(children: [
        ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_TRAITEMENT
            ? AwaitingCmdeBottom()
            : SizedBox(),
        ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_ACCEPTEE
            ? DriverComesCmdeBottom()
            : SizedBox(),
        (ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_COMMENCEE ||
                ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_PAIEMENT)
            ? DrivingPendingCmdeBottom()
            : SizedBox(),
      ])
    ]));
  }
}
