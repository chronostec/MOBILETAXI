import 'package:alfred_taxi_client/app/modules/paiement_web/payment_web_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> reverserMontantDialog(BuildContext context, String urlien) {
  var _formKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Effectuer Paiement"),
          content: Center(
            child: Text(
              "Veuillez ouvrir la page et saisir votre numéro de téléphone ainsi que le code que vous recevrez par la suite pour finaliser votre paiement.",
              style: TextStyle(letterSpacing: 2),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Get.back(), child: const Text("retour")),
            OutlinedButton(
                onPressed: () {
                  Get.to((() => PaiementWeb(url: "${urlien}")));
                },
                child: const Text("ouvrir"))
          ],
          actionsAlignment: MainAxisAlignment.spaceAround,
        );
      });
}
