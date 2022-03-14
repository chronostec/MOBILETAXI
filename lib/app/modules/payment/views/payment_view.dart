import 'package:alfred_taxi_driver/app/modules/payment/views/paiement_item.dart';
import 'package:alfred_taxi_driver/app/utils/images_path.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment View'),
          centerTitle: true,
        ),
        body: HistoryItem(
          image: PathImage.person_icon,
          subtitle: "bonsoir",
          title: "salut",
        ));
  }
}
