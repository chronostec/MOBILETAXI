import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/financeresume_model.dart';
import 'package:fredy_proprio/app/themes/colors/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../routes/app_pages.dart';
import '../controllers/rapportactivite_controller.dart';

class RapportactiviteView extends GetView<RapportactiviteController> {
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
            SingleChildScrollView(
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
                  tooltipBehavior: ctlRapportActivite.tooltipBehavior,
                  series: <ChartSeries<Objet, DateTime>>[
                    ColumnSeries<Objet, DateTime>(
                      animationDuration: 2000,
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController1 = controller;
                      },
                      dataSource: ctlRapportActivite.rapportJournee.value.objet!
                                  .toList()
                                  .length >=
                              31
                          ? ctlRapportActivite.rapportJournee.value.objet!
                              .toList()
                              .take(31)
                              .toList()
                          : ctlRapportActivite.rapportJournee.value.objet!
                                      .toList()
                                      .length >=
                                  15
                              ? ctlRapportActivite.rapportJournee.value.objet!
                                  .toList()
                                  .take(15)
                                  .toList()
                              : ctlRapportActivite.rapportJournee.value.objet!
                                  .toList(),
                      xValueMapper: (Objet sales, _) =>
                          DateTime.parse(sales.date.toString()),
                      yValueMapper: (Objet sales, _) =>
                          int.parse(sales.montant.toString()),
                      enableTooltip: true,
                      name: 'montant',
                      yAxisName: 'Montants',
                    ),
                    LineSeries<Objet, DateTime>(
                      animationDuration: 2000,
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController2 = controller;
                      },
                      yAxisName: 'duree',
                      markerSettings: const MarkerSettings(isVisible: true),
                      opacity: 0.9,
                      width: 0.4,
                      color: Colors.purple,
                      dataSource: ctlRapportActivite.rapportJournee.value.objet!
                                  .toList()
                                  .length >
                              12
                          ? ctlRapportActivite.rapportJournee.value.objet!
                              .toList()
                              .take(12)
                              .toList()
                          : ctlRapportActivite.rapportJournee.value.objet!
                              .toList(),
                      xValueMapper: (Objet sales, _) =>
                          DateTime.parse(sales.date.toString()),
                      yValueMapper: (Objet sales, _) =>
                          int.parse(sales.duree.toString()),
                      name: 'duree',
                    ),
                  ],
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
                  Get.offNamed(Routes.HOME);
                },
                icon: const Icon(
                  CupertinoIcons.arrow_left_square_fill,
                  size: 32,
                  color: AppColor.PBLUEDARK,
                )),
          ],
        ),
      ),
    ));
  }
}
