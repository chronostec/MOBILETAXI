import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/resume_model.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/colors/app_colors.dart';
import '../../../utils/custom_alert_dialog.dart';

class DriverHistoriqueView extends GetView {
  @override
  Widget build(BuildContext context) {
    ChartSeriesController _chartSeriesController1, _chartSeriesController2;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      // DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        body: Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Stack(
          children: [
            ///BODY
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 200.w,
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeCategoryAxis(
                        intervalType: DateTimeIntervalType.hours,
                        labelRotation: -60,
                        title: AxisTitle(text: 'Dates')),
                    primaryYAxis: NumericAxis(
                      name: 'montant',
                      title: AxisTitle(text: 'Montants'),
                    ),

                    // adding multiple axis
                    axes: <ChartAxis>[
                      NumericAxis(
                        name: 'duree',
                        title: AxisTitle(text: 'Durée'),
                        opposedPosition: true,
                      )
                    ],

                    enableMultiSelection: true,
                    enableSideBySideSeriesPlacement: false,
                    tooltipBehavior: ctlDriver.tooltipBehavior,
                    series: <ChartSeries<Resume, DateTime>>[
                      ColumnSeries<Resume, DateTime>(
                        animationDuration: 2000,
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController1 = controller;
                        },
                        dataSource: ctlDriver.historiqueDriverList.length >= 31
                            ? ctlDriver.historiqueDriverList.take(31).toList()
                            : ctlDriver.historiqueDriverList.length >= 15
                                ? ctlDriver.historiqueDriverList
                                    .take(15)
                                    .toList()
                                : ctlDriver.historiqueDriverList,
                        xValueMapper: (Resume sales, _) =>
                            DateTime.parse(sales.date.toString()),
                        yValueMapper: (Resume sales, _) =>
                            int.parse(sales.montant.toString()),
                        enableTooltip: true,
                        name: 'montant',
                        yAxisName: 'Montants',
                      ),
                      LineSeries<Resume, DateTime>(
                        animationDuration: 2000,
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController2 = controller;
                        },
                        yAxisName: 'duree',
                        markerSettings: const MarkerSettings(isVisible: true),
                        opacity: 0.9,
                        width: 0.4,
                        color: Colors.purple,
                        dataSource: ctlDriver.historiqueDriverList.length > 12
                            ? ctlDriver.historiqueDriverList.take(12).toList()
                            : ctlDriver.historiqueDriverList,
                        xValueMapper: (Resume sales, _) =>
                            DateTime.parse(sales.date.toString()),
                        yValueMapper: (Resume sales, _) =>
                            int.parse(sales.duree.toString()),
                        name: 'duree',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// BACK BUTTON
            IconButton(
                onPressed: () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                  Get.back();
                },
                icon: const Icon(
                  CupertinoIcons.arrow_left_square_fill,
                  size: 32,
                  color: AppColor.PBLUEDARK,
                )),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      controller: ctlDriver.startTC,
                      textAlign: TextAlign.center,
                      placeholder: 'Date Début',
                      style: Theme.of(context).textTheme.bodyText2,
                      readOnly: true,
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            title: const Text('Début'),
                            message: SizedBox(
                              height: 80,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime started) {
                                  ctlDriver.startDate.value = started;
                                  ctlDriver.startTC.text =
                                      started.toString().substring(0, 10);
                                },
                              ),
                            ),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  flex: 2,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      readOnly: true,
                      controller: ctlDriver.endTC,
                      placeholder: 'Date Fin',
                      style: Theme.of(context).textTheme.bodyText2,
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            title: const Text('Fin'),
                            message: SizedBox(
                              height: 80,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime ended) {
                                  ctlDriver.endedDate.value = ended;
                                  ctlDriver.endTC.text =
                                      ended.toString().substring(0, 10);
                                },
                              ),
                            ),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                      onEditingComplete: () {
                        ctlDriver.myFocusNode.unfocus();
                        // searchPeriod();
                      },
                      onSubmitted: (value) {
                        ctlDriver.myFocusNode.unfocus();
                        // searchPeriod();
                      },
                    ),
                  ),
                  flex: 2,
                ),
                Flexible(
                  child: IconButton(
                      onPressed: () async {
                        ctlDriver.isLoading.value
                            ? myAwaitingDialog(context: context)
                            : null;
                        await ctlDriver.getHistorique();
                      },
                      icon: const Icon(CupertinoIcons.search)),
                  flex: 1,
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
