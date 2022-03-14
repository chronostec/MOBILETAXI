import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/aide_controller.dart';

class AideView extends GetView<AideController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AideView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AideView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
