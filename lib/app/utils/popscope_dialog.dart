import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';

PlatformAlertDialog popscopeDialogg() {
  return PlatformAlertDialog(
    title: const Text("Fermer L'Appli"),
    content: const Text(
        "Attention, vous etes sur le point de quitter l'application"),
    actions: [
      PlatformDialogAction(
        onPressed: () {
          exit(0);
        },
        child: const Text('Quitter'),
      ),
      PlatformDialogAction(
        onPressed: () async {
          Get.back();
        },
        child: const Text('Rester'),
      ),
    ],
  );
}
