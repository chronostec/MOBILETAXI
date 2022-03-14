import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';
import 'app_bar_view.dart';
import 'historque_body.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarView(context),
      body: const CupertinoPageScaffold(
        // backgroundColor: AppColor.CGREY,
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
