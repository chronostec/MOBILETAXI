import 'dart:ui';

import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import 'modal_fit.dart';

AppBar CustomAppBarView(context) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 78, 76, 76),
    title: Obx(
      () => Text(
        ctlHistorique.PERIODICTITLE.value,
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
                            style: TextStyle(color: AppColor.CWHITE),
                          ),
                          Text(
                            "${ctlHistorique.totalCourses.value} COURSE",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: AppColor.CWHITE),
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
                            style: TextStyle(color: AppColor.CWHITE),
                          ),
                          Text(
                            " ${ctlHistorique.currencyFormat.value.format(ctlHistorique.totalAmount.value)} F",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                color: AppColor.CWHITE),
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
                          color: Color.fromARGB(255, 12, 12, 12),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text("plus",style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),)),
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
