import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/management_controller.dart';

class ManagementView extends GetView<ManagementController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ManagementView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ManagementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
