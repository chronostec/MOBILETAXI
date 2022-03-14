import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import 'modal_fit.dart';

AppBar CustomAppBarView(context) {
  return AppBar(
    title: Obx(
      () => Text(
        ctlHistory.PERIODICTITLE.value,
        overflow: TextOverflow.clip,
        maxLines: 1,
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            width: 80.w,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.spaceAround,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "TOTAL: ",
                            style: TextStyle(color: AppColors.DWHITE0),
                          ),
                          Text(
                            "${ctlHistory.totalCourses.value} COURSE",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: AppColors.DWHITE0),
                          ),
                        ],
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "MONTANT: ",
                            style: TextStyle(color: AppColors.DWHITE0),
                          ),
                          Text(
                            " ${ctlHistory.currencyFormat.value.format(ctlHistory.totalAmount.value)} F",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: AppColors.DWHITE0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      width: 15.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text("plus")),
                    ),
                    onTap: () async {
                      showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const HistoryModalFit(),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(50.0)),
  );
}
