import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

/// SHOW AWAIT DIALOG
annulerCmde({
  required context,
}) async {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        height: 32.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                "Etes-vous sur de bien vouloir annuler cette commande?",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 4,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      ctlAnnuler.postAnnulationTaxToApi(
                          motif_id: 1,
                          proposition_id: ctlRecherche.proposition_id.value);
                    },
                    child: Text(
                      "OUI",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          letterSpacing: 4,
                          color: Colors.grey),
                    )),
                TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "NON",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        letterSpacing: 4,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
