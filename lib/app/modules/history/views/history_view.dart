import 'package:alfred_taxi_driver/app/modules/history/views/app_bar_view.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';
import 'historque_body.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarView(context),
      body: const CupertinoPageScaffold(
        backgroundColor: AppColors.DGREEN1,
        child: SizedBox.expand(
          child: SafeArea(
            bottom: false,
            child: HistoryBody(),
          ),
        ),
      ),
    );
  }
}
