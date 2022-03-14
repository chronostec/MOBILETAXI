import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';

class CmdeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.person_pin_circle_sharp,
            color: AppColor.CGREEN,
          ),
          title: Text(
            'De ${ctlRecherche.maCommande.value.rdvLibelle ?? ''}',
            textAlign: TextAlign.left,
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.person_pin_circle_sharp,
            color: AppColor.CRED,
          ),
          title: Text(
            'A ${ctlRecherche.maCommande.value.destLibelle ?? ''}',
            textAlign: TextAlign.left,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Montant: ${ctlRecherche.maCommande.value.montantClient} Fcfa',
              textAlign: TextAlign.center,
            ),
            Text(
              'Durée: ${ctlRecherche.maCommande.value.dureeEffective ?? '...'}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
