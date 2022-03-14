import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
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
            title: const Text(
              'CHERCHER PAR PÉRIODE',
              style: TextStyle(
                  color: AppColor.CBLACK,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading: const Icon(Icons.calendar_today, color: AppColor.CBLUE),
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
            title: const Text(
              'TOUTES LES VISITES',
              style: TextStyle(
                  color: AppColor.CBLACK,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading: const Icon(Icons.calendar_today, color: AppColor.CBLUE),
            onTap: () {
              ctlHistorique.findVisitesByDate(period: PERIODTYPE.ALLTIME);
              Get.back();
            },
          ),
          ListTile(
            title: const Text(
              "AUJOURD'HUI",
              style: TextStyle(
                  color: AppColor.CBLACK,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading: const Icon(Icons.today, color: AppColor.CBLUE),
            onTap: () {
              ctlHistorique.findVisitesByDate(period: PERIODTYPE.TODAY);
              Get.back();
            },
          ),
          ListTile(
            title: const Text(
              'HIER',
              style: TextStyle(
                  color: AppColor.CBLACK,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading: const Icon(Icons.view_day, color: AppColor.CBLUE),
            onTap: () {
              ctlHistorique.findVisitesByDate(period: PERIODTYPE.YESTERDAY);
              Get.back();
            },
          ),
          ListTile(
            title: const Text(
              'LA SEMAINE',
              style: TextStyle(
                  color: AppColor.CBLACK,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  wordSpacing: 6),
            ),
            leading: const Icon(Icons.view_week, color: AppColor.CBLUE),
            onTap: () {
              ctlHistorique.findVisitesByDate(period: PERIODTYPE.THISWEEK);
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
              title: DateTime.parse(ctlHistorique.startDate.value.toString().substring(0, 10))
                          .isBefore(DateTime.parse(ctlHistorique.endedDate.value
                              .toString()
                              .substring(0, 10))) ||
                      DateTime.parse(ctlHistorique.startDate.value
                              .toString()
                              .substring(0, 10))
                          .isAtSameMomentAs(DateTime.parse(ctlHistorique.endedDate.value
                              .toString()
                              .substring(0, 10)))
                  ? const Text("")
                  : const Text(
                      "Attention!! date de début doit être plus petit que date de fin.",
                      style: TextStyle(color: AppColor.CGREY),
                    ),
              trailing: DateTime.parse(ctlHistorique.startDate.value
                              .toString()
                              .substring(0, 10))
                          .isBefore(DateTime.parse(ctlHistorique.endedDate.value
                              .toString()
                              .substring(0, 10))) ||
                      DateTime.parse(ctlHistorique.startDate.value.toString().substring(0, 10))
                          .isAtSameMomentAs(DateTime.parse(ctlHistorique.endedDate.value
                              .toString()
                              .substring(0, 10)))
                  ? ActionChip(
                      label: const Text(
                        "Terminer",
                      ),
                      onPressed: () {
                        ctlHistorique.findVisitesByDate(
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
              title: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("DU: "),
                  Text(
                    DateFormat("dd-MM-yyyy")
                        .format(ctlHistorique.startDate.value),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ],
              ),
              leading: const Icon(Icons.date_range, color: AppColor.CBLUE),
              onTap: () => showStartDatePicker(context),
            ),
            ListTile(
              title: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("AU: "),
                  Text(
                    DateFormat("dd-MM-yyyy")
                        .format(ctlHistorique.endedDate.value),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ],
              ),
              leading: const Icon(Icons.date_range, color: AppColor.CBLUE),
              onTap: () => showEndedDatePicker(context),
            ),
          ],
        ),
      ),
    ));
  }
}
