import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';

void showVehiculeAnneeDatePicker(BuildContext context, {selectedDate}) async {
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
              ctlVehicule.vehiculeAnnee.value = value;
              ctlVehicule.anneeTC.text = value.toString().substring(0, 10);
              print(value);
            }
          },
          initialDateTime: ctlVehicule.endedDate.value,
          minimumYear: 2010,
          maximumYear: DateTime.now().year,
          maximumDate: DateTime.now(),
          dateOrder: DatePickerDateOrder.ymd,
          use24hFormat: true,
        ),
      );
    },
  );
}
