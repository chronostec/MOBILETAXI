import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/licenses_controller.dart';

class LicensesView extends GetView<LicensesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LicensesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LicensesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
