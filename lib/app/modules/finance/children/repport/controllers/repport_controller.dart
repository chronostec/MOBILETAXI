import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/data/models/sales_model.dart';
import 'package:get/get.dart';

import 'sales_datasource.dart';


class RepportController extends GetxController {
  late FocusNode myFocusNode;
   var tooltipBehavior;
  final beginTF = TextEditingController();
  final endTF = TextEditingController();
  final isready = false.obs; // break progress indicator
  final dataperiod = ''.obs;

  final amount = 0.obs;
  final vehicles = 0.obs;

  int count_cars = 0;
  int count_prices = 0;

  final chooseperiod = 0.obs;

  /// `sales lists`
  final begindate = '${DateTime.now()}'.obs;
  final endeddate = '${DateTime.now()}'.obs;

  /// `sales lists`
  final customersalesList = <Sales>[].obs;
  final usersalesList = <Sales>[].obs;
  final currentsalesList = <Sales>[].obs;

  ///`data processing list`
  var tempsalesList = <Sales>[].obs;
  var finalsalesList = <Sales>[].obs;

  var salesDataSource;

  ///`Find first date of the week which contains provided date.`
  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  /// `Find last date of the week which contains provided date.`
  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  /// `parse date to correct datetime value`
  DateTime correctDateTime(String dateTime) {
    String date = '';
    switch (chooseperiod.value) {
      case 0:
        date = dateTime;
        break;
      case 1:
        date = dateTime;
        break;
      case 2:
        date = dateTime;
        break;
      case 3:
        date = '$dateTime-01';
        break;
      case 4:
        date = '$dateTime-01-01';
        break;
      default:
        date = dateTime;
    }
    print('date = ' + date);
    return DateTime.parse(date);
  }

  ///` DATA PROCESSING`
  Future<List<Sales>> dataProcessing() async {
    isready.value = true;
    int end = 10;
    switch (chooseperiod.value) {
      case 0:
        end = 10;
        break;
      case 1:
        end = 13;
        break;
      case 2:
        end = 10;
        break;
      case 3:
        end = 7;
        break;
      case 4:
        end = 4;
        break;
      default:
        end = 10;
    }

    ///`create a temp list with date grouped and empty price `
    if (chooseperiod.value == 1) {
      tempsalesList.clear();
      usersalesList.forEach((element) {
        if (tempsalesList
            .where((p) =>
                p.createdat.toString().substring(0, end) ==
                element.createdat.toString().substring(0, end))
            .toList()
            .isEmpty) {
          if (element.createdat.toString().substring(0, end-3) ==
              DateTime.now().toString().substring(0, end-3)) {
                
            var date = element.createdat.toString().substring(0, end);
            tempsalesList.add(Sales(createdat: date));
          }
        }
      });
    } else if (chooseperiod.value == 2) {
      tempsalesList.clear();
      usersalesList.forEach((element) {
        if (tempsalesList
            .where((p) =>
                p.createdat.toString().substring(0, 10) ==
                element.createdat.toString().substring(0, 10))
            .toList()
            .isEmpty) {
          if (DateTime.parse(element.createdat.toString().substring(0, 10))
                  .isAfter(findFirstDateOfTheWeek(DateTime.parse(
                      DateTime.now().toString().substring(0, 10)))) ||
              DateTime.parse(element.createdat.toString().substring(0, 10))
                  .isAtSameMomentAs(DateTime.parse(
                      DateTime.now().toString().substring(0, 10)))) {
            var date = element.createdat.toString().substring(0, end);
            tempsalesList.add(Sales(createdat: date));
          }
        }
      });
    } else {
      tempsalesList.clear();
      usersalesList.forEach((element) {
        if (tempsalesList
            .where((p) =>
                p.createdat.toString().substring(0, end) ==
                element.createdat.toString().substring(0, end))
            .toList()
            .isEmpty) {
          var date = element.createdat.toString().substring(0, end);
          tempsalesList.add(Sales(createdat: date));
        }
      });
    }

    /// `create  final list from temp list, with prices concatenated`
    finalsalesList.clear();
    amount.value = 0;
    vehicles.value = 0;
    count_cars = 0;
    count_prices = 0;

    if (chooseperiod.value == 1) {
      tempsalesList.forEach((element) {
        for (var item in usersalesList) {
          if (element.createdat.toString().substring(0, end) ==
              item.createdat.toString().substring(0, end)) {
            count_prices = count_prices + int.parse(item.price);
            count_cars++;
          }
        }

        finalsalesList.add(Sales(
            createdat: element.createdat.substring(0, end),
            cars: count_cars.toString(),
            price: count_prices.toString()));

        amount.value = amount.value + count_prices; // total price
        vehicles.value = vehicles.value + count_cars; // total vehicles
        count_prices = 0;
        count_cars = 0;
      });
    } else if (chooseperiod.value == 2) {
      tempsalesList.forEach((element) {
        for (var item in usersalesList) {
          if (element.createdat.toString().substring(0, 10) ==
              item.createdat.toString().substring(0, 10)) {
            count_prices = count_prices + int.parse(item.price);
            count_cars++;
          }
        }

        finalsalesList.add(Sales(
            createdat: element.createdat.substring(0, 10),
            cars: count_cars.toString(),
            price: count_prices.toString()));

        amount.value = amount.value + count_prices; // total price
        vehicles.value = vehicles.value + count_cars; // total vehicles
        count_prices = 0;
        count_cars = 0;
      });
    } else {
      tempsalesList.forEach((element) {
        for (var item in usersalesList) {
          if (element.createdat.toString().substring(0, end) ==
              item.createdat.toString().substring(0, end)) {
            count_prices = count_prices + int.parse(item.price);
            count_cars++;
          }
        }

        finalsalesList.add(Sales(
            createdat: element.createdat.substring(0, end),
            cars: count_cars.toString(),
            price: count_prices.toString()));

        amount.value = amount.value + count_prices; // total price
        vehicles.value = vehicles.value + count_cars; // total vehicles
        count_prices = 0;
        count_cars = 0;
      });
    }

    finalsalesList.value = finalsalesList.reversed.toList();
// rebuild datagrid list
    salesDataSource = SalesDataSource(sales: finalsalesList);
    isready.value = false;

    return finalsalesList;
  }

  ///` SEARCH PERIOD`
  Future<List<Sales>> searchPeriod() async {
    tempsalesList.clear();
    usersalesList.forEach((element) {
      if (tempsalesList
          .where((p) =>
              p.createdat.toString().substring(0, 10) ==
              element.createdat.toString().substring(0, 10))
          .toList()
          .isEmpty) {
        if ((DateTime.parse(element.createdat.toString().substring(0, 10))
                    .isAfter(DateTime.parse(begindate.value)) ||
                DateTime.parse(element.createdat.toString().substring(0, 10))
                    .isAtSameMomentAs(DateTime.parse(begindate.value))) &&
            (DateTime.parse(element.createdat.toString().substring(0, 10))
                    .isBefore(DateTime.parse(endeddate.value)) ||
                DateTime.parse(element.createdat.toString().substring(0, 10))
                    .isAtSameMomentAs(DateTime.parse(endeddate.value)))) {
          var date = element.createdat.toString().substring(0, 10);
          tempsalesList.add(Sales(createdat: date));
        }
      }
    });

    /// `create  final list from temp list, with prices concatenated`
    finalsalesList.clear();
    amount.value = 0;
    vehicles.value = 0;
    count_cars = 0;
    count_prices = 0;

    tempsalesList.forEach((element) {
      for (var item in usersalesList) {
        if (element.createdat.toString().substring(0, 10) ==
            item.createdat.toString().substring(0, 10)) {
          count_prices = count_prices + int.parse(item.price);
          count_cars++;
        }
      }

      ///print(element.createdat.substring(0, end));
      finalsalesList.add(Sales(
          createdat: element.createdat.substring(0, 10),
          cars: count_cars.toString(),
          price: count_prices.toString()));

      amount.value = amount.value + count_prices; // total price
      vehicles.value = vehicles.value + count_cars; // total vehicles
      count_prices = 0;
      count_cars = 0;
    });

    finalsalesList.value = finalsalesList.reversed.toList();

    // rebuild datagrid list
    salesDataSource = SalesDataSource(sales: finalsalesList);
    isready.value = false;

    return finalsalesList;
  }

  ///`Fetch prices and dates for customer`
  Future fetchcustomersSales() async {
    isready.value = true;
    // fetchslesProvider
    //     .fetchCustomerSales(Customer(uid: usersHelper.uid.value))
    //     .then((value) {
    //   usersalesList.value = value;
    //   dataProcessing();
    // });
    isready.value = false;
    print(usersalesList);
  }

  ///`Fetch prices and dates for user`
  Future fetchusersSales() async {
    isready.value = true;
    // fetchslesProvider
    //     .fetchUserSales(User(uid: usersHelper.uid.value))
    //     .then((value) async {
    //   usersalesList.value = value;
    //   await dataProcessing();
    // });
    isready.value = false;
  }

  @override
  void onInit() {
    // usersHelper.status.value == Consts.customer
    //     ? fetchcustomersSales()
    //     : fetchusersSales();
    // tooltipBehavior = TooltipBehavior(enable: true);

    beginTF.text = DateTime.now().toString().substring(0, 10);
    endTF.text = DateTime.now().toString().substring(0, 10);
     myFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
