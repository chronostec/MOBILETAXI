import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/historique_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart'
    show proHistorique;
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  RxBool DIALOGSTATUS = false.obs;
  var PERIODICTITLE = "Point du jour".obs;
  var periodType = PERIODTYPE.TODAY.obs;

  RxInt totalCourses = 0.obs;
  RxDouble totalAmount = 0.0.obs;

  final chooseperiod = 0.obs;
  var currencyFormat =
      NumberFormat("#,##0.00", "${ctlHome.defaultLanguage}").obs;

  /// `visites lists`
  final tempList = <Historique>[].obs;

  final historiquesList = <Historique>[
    // for (var i = 10; i < 31; i++)
    //   Historique(
    //     id: i,
    //     destination: "destination$i",
    //     duree: "$i",
    //     montant: "${i}000",
    //     date: "2022-01-$i 15:$i:01",
    //   ),
  ].obs;

  ///` dateimes`
  final startDate = DateTime.now().obs;
  final endedDate = DateTime.now().obs;

  @override
  void onInit() async {
    currencyFormat.value =
        NumberFormat("#,##0.00", "${ctlHome.defaultLanguage}");
    getHistorique();

    super.onInit();
  }

  @override
  void onReady() async {
    await findVisitesByDate(period: PERIODTYPE.TODAY);
    super.onReady();
  }

  @override
  void onClose() {}

  ///`GET HISTORIQUE`
  Future getHistorique() async {
    historiquesList.value =
        await proHistorique.getHistorique(driver_id: ctlHome.driver.value.id);
    tempList.value = historiquesList;
    findVisitesByDate(period: PERIODTYPE.TODAY);
  }

  ///`Find first date of the week which contains provided date.`
  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  /// `Find last date of the week which contains provided date.`
  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  /// `sort visite liste by a period witch can be`
  /// [today, yesterday, this week, this month, alltime, from stat date to end date]
  Future findVisitesByDate({required period}) async {
    // String _nowString = DateTime.now().toString().substring(0, 10);
    DateTime _nowDate = DateTime.now();

    switch (period) {
      case PERIODTYPE.TODAY:
        PERIODICTITLE.value = PERIODTITLE.TODAY;
        tempList.value = historiquesList
            .where((visite) =>
                visite.date.toString().substring(0, 10) ==
                DateTime.now().toString().substring(0, 10))
            .toList();
        totalCourses.value = tempList.length;
        totalAmount.value = calculateAmount(tempList);

        break;
      case PERIODTYPE.YESTERDAY:
        PERIODICTITLE.value = PERIODTITLE.YESTERDAY;
        tempList.value = historiquesList
            .where((visite) =>
                DateTime.parse(visite.date.toString().substring(0, 10)).isAfter(
                    DateTime.now().subtract(const Duration(days: 2))) &&
                DateTime.parse(visite.date.toString().substring(0, 10))
                    .isBefore(DateTime.now().subtract(const Duration(days: 1))))
            .toList();
        totalCourses.value = tempList.length;
        totalAmount.value = calculateAmount(tempList);
        break;
      case PERIODTYPE.THISWEEK:
        PERIODICTITLE.value = PERIODTITLE.THISWEEK;
        tempList.value = historiquesList
            .where((visite) =>
                DateTime.parse(visite.date.toString().substring(0, 10)).isAfter(
                    DateTime.now()
                        .subtract(Duration(days: _nowDate.weekday))) &&
                DateTime.parse(visite.date.toString().substring(0, 10))
                    .isBefore(_nowDate))
            .toList();
        totalCourses.value = tempList.length;
        totalAmount.value = calculateAmount(tempList);
        break;

      case PERIODTYPE.ALLTIME:
        PERIODICTITLE.value = PERIODTITLE.ALLTIME;
        tempList.value = historiquesList;
        totalCourses.value = tempList.length;
        totalAmount.value = calculateAmount(tempList);
        break;
      case PERIODTYPE.PERIODIC:
        tempList.value = historiquesList
            .where(
              (visite) =>
                  DateTime.parse(visite.date.toString().substring(0, 10))
                      .isAfter(
                          DateTime.parse(startDate.toString().substring(0, 10))
                              .subtract(const Duration(days: 1))) &&
                  DateTime.parse(visite.date.toString().substring(0, 10))
                      .isBefore(
                          DateTime.parse(endedDate.toString().substring(0, 10))
                              .add(const Duration(days: 1))),
            )
            .toList();
        totalCourses.value = tempList.length;
        totalAmount.value = calculateAmount(tempList);
        break;
      default:
        PERIODICTITLE.value = PERIODTITLE.ALLTIME;
        tempList.value = historiquesList;
        totalCourses.value = tempList.length;
        totalAmount.value = calculateAmount(tempList);
    }
    return tempList;
  }

  double calculateAmount(List<Historique> historiques) {
    var value = 0.0;
    for (var amount in historiques) {
      value = value + double.parse(amount.montantPercu.toString());
    }

    return value;
  }
}
