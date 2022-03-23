import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reversement_controller.dart';
import 'paiement_webview_page.dart';

class ReversementView extends GetView<ReversementController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: const PaiementWebviewPage(),
    );
  }
}
