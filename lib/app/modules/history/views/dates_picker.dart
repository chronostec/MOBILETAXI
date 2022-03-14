import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showStartDatePicker(BuildContext context, {selectedDate}) async {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext builder) {
      return Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: Colors.white,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) {
            if (value != selectedDate) {
              ctlHistory.startDate.value = value;
              print(value);
            }
          },
          initialDateTime: ctlHistory.startDate.value,
          minimumYear: 2021,
          maximumYear: 2042,
          dateOrder: DatePickerDateOrder.dmy,
          use24hFormat: true,
        ),
      );
    },
  );
}

void showEndedDatePicker(BuildContext context, {selectedDate}) async {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext builder) {
      return Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.25,
        color: Colors.white,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) {
            if (value != selectedDate) {
              ctlHistory.endedDate.value = value;
              print(value);
            }
          },
          initialDateTime: ctlHistory.endedDate.value,
          minimumYear: 2021,
          maximumYear: 2042,
          dateOrder: DatePickerDateOrder.dmy,
          use24hFormat: true,
        ),
      );
    },
  );
}
