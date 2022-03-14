import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/sales_model.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../controllers/repport_controller.dart';

class RepportView extends GetView<RepportController> {
  @override
  Widget build(BuildContext context) {
    ChartSeriesController _chartSeriesController1, _chartSeriesController2;

    return CupertinoPageScaffold(
        child: Obx(
      () => ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      controller: ctlReport.beginTF,
                      placeholder: 'Date Début',
                      style: Theme.of(context).textTheme.bodyText2,
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            title: Text('Début'),
                            message: Container(
                              height: 80,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime started) {
                                  ctlReport.begindate.value =
                                      started.toString().substring(0, 10);
                                  ctlReport.beginTF.text =
                                      started.toString().substring(0, 10);
                                },
                              ),
                            ),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                      onEditingComplete: () {
                        ctlReport.myFocusNode.unfocus();
                      },
                      onSubmitted: (value) {
                        ctlReport.myFocusNode.unfocus();
                      },
                    ),
                  ),
                  flex: 2,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      autofocus: false,
                      controller: ctlReport.endTF,
                      placeholder: 'Date Fin',
                      style: Theme.of(context).textTheme.bodyText2,
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            title: Text('Fin'),
                            message: Container(
                              height: 80,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime ended) {
                                  ctlReport.endeddate.value =
                                      ended.toString().substring(0, 10);
                                  ctlReport.endTF.text =
                                      ended.toString().substring(0, 10);
                                },
                              ),
                            ),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                      onEditingComplete: () {
                        ctlReport.myFocusNode.unfocus();
                        searchPeriod();
                      },
                      onSubmitted: (value) {
                        ctlReport.myFocusNode.unfocus();
                        searchPeriod();
                      },
                    ),
                  ),
                  flex: 2,
                ),
                Flexible(
                  child: IconButton(
                      onPressed: () async => searchPeriod,
                      icon: Icon(CupertinoIcons.search)),
                  flex: 1,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
            child: CupertinoSlidingSegmentedControl(
                groupValue: ctlReport.chooseperiod.value,
                children: const <int, Widget>{
                  0: Text('Tout'),
                  1: Text('Jour'),
                  2: Text('Semaine'),
                  3: Text('Mois'),
                  4: Text('Année')
                },
                onValueChanged: (value) {
                  print(value);
                  ctlReport.chooseperiod.value = value as int;
                  ctlReport.dataProcessing();
                }),
          ),

          ///
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: ctlReport.finalsalesList.length <= 12
                  ? 100.w
                  : ctlReport.finalsalesList.length <= 31
                      ? 130.w
                      : 200.w,
              child: SfCartesianChart(
                primaryXAxis: DateTimeCategoryAxis(
                    intervalType: DateTimeIntervalType.months,
                    labelRotation: -60,
                    title: AxisTitle(text: 'Dates')),
                primaryYAxis: NumericAxis(
                  name: 'Montants',
                  title: AxisTitle(text: 'Montants'),
                ),

                // adding multiple axis
                axes: <ChartAxis>[
                  NumericAxis(
                    name: 'Vehicules',
                    title: AxisTitle(text: 'Nombre véhicules'),
                    opposedPosition: true,
                  )
                ],

                enableMultiSelection: true,
                enableSideBySideSeriesPlacement: false,
                tooltipBehavior: ctlReport.tooltipBehavior,
                series: <ChartSeries<Sales, DateTime>>[
                  ColumnSeries<Sales, DateTime>(
                    animationDuration: 2000,
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController1 = controller;
                    },
                    dataSource: ctlReport.finalsalesList.length >= 31
                        ? ctlReport.finalsalesList.take(31).toList()
                        : ctlReport.finalsalesList.length >= 15
                            ? ctlReport.finalsalesList.take(15).toList()
                            : ctlReport.finalsalesList,
                    xValueMapper: (Sales sales, _) =>
                        ctlReport.correctDateTime(sales.createdat),
                    yValueMapper: (Sales sales, _) => int.parse(sales.price),
                    enableTooltip: true,
                    name: 'Montants',
                    yAxisName: 'Montants',
                  ),
                  LineSeries<Sales, DateTime>(
                    animationDuration: 2000,
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController2 = controller;
                    },
                    yAxisName: 'Vehicules',
                    markerSettings: MarkerSettings(isVisible: true),
                    opacity: 0.9,
                    width: 0.4,
                    color: Colors.purple,
                    dataSource: ctlReport.finalsalesList.length >= 12
                        ? ctlReport.finalsalesList.take(12).toList()
                        : ctlReport.finalsalesList,
                    xValueMapper: (Sales sales, _) =>
                        ctlReport.correctDateTime(sales.createdat),
                    yValueMapper: (Sales sales, _) => int.parse(sales.cars),
                    name: 'Vehicules',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildStats() {
    final TextStyle stats = const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white);
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      sliver: SliverGrid.count(
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.2,
        crossAxisCount: 3,
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
                  "+${ctlFinance.format.format(5000000).substring(0, ctlFinance.format.format(5000000).length - 3)}",
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
                  "+${ctlFinance.format.format(3000000).substring(0, ctlFinance.format.format(3000000).length - 3)}",
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
                  "+${ctlFinance.format.format(8000000).substring(0, ctlFinance.format.format(8000000).length - 3)}",
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

  Future<void> showModal(BuildContext context) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Vos lavages'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('LAVAGE 1'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('LAVAGE 2'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('LAVAGE 3'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('LAVAGE 4'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('LAVAGE 5'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  searchPeriod() async {
    ctlReport.chooseperiod.value = 0;
    if (DateTime.parse(ctlReport.begindate.value)
        .isAfter(DateTime.parse(ctlReport.endeddate.value))) {
      Get.snackbar('DATE INCORRECT', "Vérifiez que les dates sont correctes !");
    } else {
      await ctlReport.searchPeriod();
    }
  }
}
