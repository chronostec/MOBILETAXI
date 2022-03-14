import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/recovery_controller.dart';

class RecoveryView extends GetView<RecoveryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RecoveryView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RecoveryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
