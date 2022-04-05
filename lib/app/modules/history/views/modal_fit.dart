import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/themes/colors/light_color.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'dates_picker.dart';

class HistoryModalFit extends StatelessWidget {
  const HistoryModalFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            tileColor: LightColor.yellow2.withAlpha(230),
            title: const Text(
              'CHERCHER PAR PÉRIODE',
              style: TextStyle(
                  color: LightColor.navyBlue1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading:
                const Icon(Icons.calendar_today, color: LightColor.navyBlue1),
            onTap: () async {
              var selectedDate = '';
              Get.back();
              showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => ModalFitDate(),
              );
            },
          ),
          ListTile(
            tileColor: LightColor.yellow2.withAlpha(230),
            title: Text(
              'TOUTES LES VISITES',
              style: TextStyle(
                  color: LightColor.navyBlue1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading:
                const Icon(Icons.calendar_today, color: LightColor.navyBlue1),
            onTap: () {
              ctlHistory.findVisitesByDate(period: PERIODTYPE.ALLTIME);
              Get.back();
            },
          ),
          ListTile(
            tileColor: LightColor.yellow2.withAlpha(230),
            title: Text(
              "AUJOURD'HUI",
              style: TextStyle(
                  color: LightColor.navyBlue1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading: const Icon(Icons.today, color: LightColor.navyBlue1),
            onTap: () {
              ctlHistory.findVisitesByDate(period: PERIODTYPE.TODAY);
              Get.back();
            },
          ),
          ListTile(
            tileColor: LightColor.yellow2.withAlpha(230),
            title: Text(
              'HIER',
              style: TextStyle(
                  color: LightColor.navyBlue1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading: const Icon(Icons.view_day, color: LightColor.navyBlue1),
            onTap: () {
              ctlHistory.findVisitesByDate(period: PERIODTYPE.YESTERDAY);
              Get.back();
            },
          ),
          ListTile(
            tileColor: LightColor.yellow2.withAlpha(230),
            title: Text(
              'LA SEMAINE',
              style: TextStyle(
                  color: LightColor.navyBlue1,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading: const Icon(Icons.view_week, color: LightColor.navyBlue1),
            onTap: () {
              ctlHistory.findVisitesByDate(period: PERIODTYPE.THISWEEK);
              Get.back();
            },
          ),
        ],
      ),
    ));
  }
}

class ModalFitDate extends StatelessWidget {
  const ModalFitDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              tileColor: LightColor.yellow2,
              title: DateTime.parse(ctlHistory.startDate.value.toString().substring(0, 10))
                          .isBefore(DateTime.parse(ctlHistory.endedDate.value
                              .toString()
                              .substring(0, 10))) ||
                      DateTime.parse(ctlHistory.startDate.value
                              .toString()
                              .substring(0, 10))
                          .isAtSameMomentAs(DateTime.parse(ctlHistory.endedDate.value
                              .toString()
                              .substring(0, 10)))
                  ? const Text("")
                  : const Text(
                      "Attention!! date de début doit être plus petit que date de fin.",
                      style: TextStyle(color: AppColors.DRED),
                    ),
              trailing: DateTime.parse(ctlHistory.startDate.value
                              .toString()
                              .substring(0, 10))
                          .isBefore(DateTime.parse(ctlHistory.endedDate.value
                              .toString()
                              .substring(0, 10))) ||
                      DateTime.parse(ctlHistory.startDate.value.toString().substring(0, 10))
                          .isAtSameMomentAs(DateTime.parse(ctlHistory
                              .endedDate.value
                              .toString()
                              .substring(0, 10)))
                  ? ActionChip(
                      label: const Text(
                        "Terminer",
                      ),
                      onPressed: () {
                        ctlHistory.findVisitesByDate(
                            period: PERIODTYPE.PERIODIC);
                        Get.back();
                      },
                    )
                  : InkWell(
                      onTap: () => Get.back(),
                      child: const Text(
                        "Quitter",
                      ),
                    ),
            ),
            ListTile(
              tileColor: LightColor.yellow2,
              title: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("DU: "),
                  Text(
                    DateFormat("dd-MM-yyyy").format(ctlHistory.startDate.value),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ],
              ),
              leading:
                  const Icon(Icons.date_range, color: LightColor.navyBlue1),
              onTap: () => showStartDatePicker(context),
            ),
            ListTile(
              tileColor: LightColor.yellow2,
              title: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("AU: "),
                  Text(
                    DateFormat("dd-MM-yyyy").format(ctlHistory.endedDate.value),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ],
              ),
              leading:
                  const Icon(Icons.date_range, color: LightColor.navyBlue1),
              onTap: () => showEndedDatePicker(context),
            ),
          ],
        ),
      ),
    ));
  }
}
