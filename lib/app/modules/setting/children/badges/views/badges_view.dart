import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/badges_controller.dart';

class BadgesView extends GetView<BadgesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BadgesView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BadgesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
