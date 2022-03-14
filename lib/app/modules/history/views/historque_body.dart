import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/themes/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Obx(
          () => ListView(
            children: [
              for (var historique in ctlHistorique.tempList.reversed.toList())
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: 95.w, minWidth: 90.w),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 236, 219),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${historique.destination}",
                              style: historiqueTextStyle(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "MT: ${historique.montantPercu} F",
                                  style:
                                      historiqueTextStyle(fw: FontWeight.w500),
                                ),
                                Text(
                                  "Durée: ${historique.duree} min",
                                  style:
                                      historiqueTextStyle(fw: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date du ${DateFormat.yMd().format(DateTime.parse("${historique.date}"))}",
                                  style:
                                      historiqueTextStyle(fw: FontWeight.w500),
                                ),
                                Text(
                                  " à ${DateFormat.Hms().format(DateTime.parse("${historique.date}"))}",
                                  style:
                                      historiqueTextStyle(fw: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        )),
      ],
    );
  }
}
