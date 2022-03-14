import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> popscopeDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text(
        'Attention',
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Baloo', color: Colors.deepOrange),
      ),
      children: [
        const Center(child: Text("Êtes-vous sûr de fermer l'application?")),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () async {
                exit(0);
              },
              child: Text('Oui'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () => Get.back(),
              child: Text('Non'),
            )
          ],
        )
      ],
    ),
  );
}
