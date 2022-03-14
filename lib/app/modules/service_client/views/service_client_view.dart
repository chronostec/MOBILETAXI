import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/service_client_controller.dart';

class ServiceClientView extends GetView<ServiceClientController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ServiceClientView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ServiceClientView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
