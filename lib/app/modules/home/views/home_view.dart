import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/modules/home/views/mapicker.dart';
import 'package:alfred_taxi_client/app/modules/ma_course/views/ma_course_view.dart';
import 'package:alfred_taxi_client/app/modules/map_course/views/map_course_view.dart';
import 'package:alfred_taxi_client/app/modules/utils/drawer_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'choisir_destination.dart';
import 'menu_haut.dart';
import 'popscopr_dialog.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await popscopeDialog(context);
      },
      child: Scaffold(
        key: ctlHome.ghomeKey,
        backgroundColor: Colors.white,
        drawer: BuildDrawer(),
        body: SizedBox.expand(
          child: SafeArea(
            bottom: false,
            child: EMPTYCMDHOME(),
          ),
        ),
      ),
    );
  }
}

class EMPTYCMDHOME extends StatelessWidget {
  const EMPTYCMDHOME({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaPicker();
  }
}

/* Stack(
      children: [
        /// GOOGLE MAPS VIEW
        Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: MapCourseView(),
        ),
        MENUHAUT(),
        Obx(() {
          return Align(
            child:
                ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_EMPTY ||
                        ctlHome.showbottom.value == true
                    ? CHOISIRTRAJET()
                    : MaCourseView(),
            alignment: Alignment.bottomCenter,
          );
        }),
      ],
    ) */