import 'package:alfred_taxi_client/app/data/models/distance_matrix_model.dart';
import 'package:alfred_taxi_client/app/modules/paiement_web/payment_web_view.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../common/controllers.dart';

class PaiementModalFit extends StatelessWidget {
  const PaiementModalFit({Key? key, this.urlien}) : super(key: key);
  final urlien;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                "Veuillez ouvrir la page et saisir votre numéro de téléphone ainsi que le code que vous recevrez par la suite pour finaliser votre paiement.",
                style: TextStyle(letterSpacing: 2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      ctlMapCourse.ISWEBVIEW.value = false;
                      ctlHome.showbottom.value = true;
                      Get.offAllNamed(Routes.HOME);
                    },
                    child: const Text("retour")),
                OutlinedButton(
                    onPressed: () {
                      Get.to((() => PaiementWeb(url: "${urlien}")));
                    },
                    child: const Text("ouvrir"))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
