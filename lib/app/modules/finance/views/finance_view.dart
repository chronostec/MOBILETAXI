import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/financeresume_model.dart';
import 'package:fredy_proprio/app/routes/app_pages.dart';
import 'package:fredy_proprio/app/themes/colors/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/finance_controller.dart';

class FinanceView extends GetView<FinanceController> {
  var _chartSeriesController2;

  FinanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).buttonColor,
      body: Obx(() => _bodyListview(context)),
    );
  }

  TextStyle stats = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white);

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "+${ctlFinance.financeResume.value.espece ?? 0}",
                  softWrap: true,
                  style: stats,
                ),
                const Text(
                  "ESPECE",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.pink,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "+${ctlFinance.financeResume.value.dematerialise ?? 0}",
                  style: stats,
                ),
                const Text("MOBILE",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "+${ctlFinance.financeResume.value.totaux ?? 0}",
                  style: stats,
                ),
                const Text("TOTAUX",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _bodyListview(BuildContext context) {
    return ListView(
      children: [
        _buildStats(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: ctlFinance.startTC,
                    placeholder: 'Date Début',
                    style: Theme.of(context).textTheme.bodyText2,
                    readOnly: true,
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          title: const Text('Début'),
                          message: SizedBox(
                            height: 80,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (DateTime started) {
                                ctlFinance.startDate.value = started;
                                ctlFinance.startTC.text =
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
                    controller: ctlFinance.endTC,
                    placeholder: 'Date Fin',
                    style: Theme.of(context).textTheme.bodyText2,
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          title: const Text('Fin'),
                          message: SizedBox(
                            height: 80,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (DateTime ended) {
                                ctlFinance.endedDate.value = ended;
                                ctlFinance.endTC.text =
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
                      ctlFinance.myFocusNode.unfocus();
                      // searchPeriod();
                    },
                    onSubmitted: (value) {
                      ctlFinance.myFocusNode.unfocus();
                      // searchPeriod();
                    },
                  ),
                ),
                flex: 2,
              ),
              Flexible(
                child: IconButton(
                    onPressed: () async {
                      // ctlFinance.isLoading.value
                      //     ? myAwaitingDialog(context: context)
                      //     : null;
                      await ctlFinance.getFinanceresume();
                    },
                    icon: const Icon(CupertinoIcons.search)),
                flex: 1,
              )
            ],
          ),
        ),

        ///
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 200.w,
            child: SfCartesianChart(
              primaryXAxis: DateTimeCategoryAxis(
                  intervalType: DateTimeIntervalType.auto,
                  labelRotation: -60,
                  title: AxisTitle(text: 'Dates')),
              primaryYAxis: NumericAxis(
                name: 'montant',
                title: AxisTitle(text: 'Montants'),
              ),
              axes: <ChartAxis>[
                NumericAxis(
                  name: 'duree',
                  title: AxisTitle(text: 'Durée'),
                  opposedPosition: true,
                )
              ],
              enableMultiSelection: true,
              enableSideBySideSeriesPlacement: false,
              tooltipBehavior: ctlFinance.tooltipBehavior,
              series: <ChartSeries<Objet, DateTime>>[
                ColumnSeries<Objet, DateTime>(
                  animationDuration: 2000,
                  onRendererCreated: (ChartSeriesController controller) {},
                  dataSource: ctlFinance.financeResume.value.objet!
                              .toList()
                              .length >=
                          31
                      ? ctlFinance.financeResume.value.objet!
                          .toList()
                          .take(31)
                          .toList()
                      : ctlFinance.financeResume.value.objet!.toList().length >=
                              15
                          ? ctlFinance.financeResume.value.objet!
                              .toList()
                              .take(15)
                              .toList()
                          : ctlFinance.financeResume.value.objet!.toList(),
                  xValueMapper: (Objet sales, _) => DateTime.parse(sales.date!),
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
                  dataSource:
                      ctlFinance.financeResume.value.objet!.toList().length > 12
                          ? ctlFinance.financeResume.value.objet!
                              .toList()
                              .take(31)
                              .toList()
                          : ctlFinance.financeResume.value.objet!.toList(),
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

        /// RECHARGEMENT
        // soldeCard(context, titre: "Argent comptant", montant: "200000"),
        soldeCard(context,
            titre: "Argent comptant",
            montant: ctlRechargement.rechargements.value.solde ?? 0,
            active: true,
            action: () => Get.toNamed(Routes.RECHARGEMENT))
      ],
    );
  }

  Stack soldeCard(BuildContext context,
      {required String titre,
      required int montant,
      bool active = false,
      action}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: 10.h,
                color: LightColor.navyBlue1,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          titre,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                ctlRechargement.currency.format(
                                    montant, ctlRechargement.unitSettings),
                                style: GoogleFonts.mulish(
                                    textStyle:
                                        Theme.of(context).textTheme.headline4,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                    color: LightColor.yellow2),
                              )
                            ])
                      ],
                    ),
                    const Positioned(
                      left: -170,
                      top: -170,
                      child: CircleAvatar(
                        radius: 130,
                        backgroundColor: LightColor.lightBlue2,
                      ),
                    ),
                    const Positioned(
                      left: -160,
                      top: -190,
                      child: CircleAvatar(
                        radius: 130,
                        backgroundColor: LightColor.lightBlue1,
                      ),
                    ),
                    active
                        ? const SizedBox()
                        : const Positioned(
                            right: -170,
                            bottom: -170,
                            child: CircleAvatar(
                              radius: 130,
                              backgroundColor: LightColor.yellow2,
                            ),
                          ),
                    active
                        ? const SizedBox()
                        : const Positioned(
                            right: -160,
                            bottom: -190,
                            child: CircleAvatar(
                              radius: 130,
                              backgroundColor: LightColor.yellow,
                            ),
                          )
                  ],
                ),
              )),
        ),
        active
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
                  child: IconButton(
                      onPressed: action,
                      icon: Icon(
                          CupertinoIcons.arrowshape_turn_up_right_circle_fill,
                          size: 48.sp,
                          color: Colors.white)),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
