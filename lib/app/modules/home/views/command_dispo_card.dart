import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/commandes_model.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: non_constant_identifier_names
Padding ComandeDispoCard(Commande commande) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
    child: InkWell(
      onTap: () async {
        // print(commande.id);
        ctlcommande.commande.value = commande;
        await ctlcommande.getDetailCommande().then((value) async {
          if (value) {
            ctlcommande.changeStatus(CMDSTATUS.COMMAND_EMPTY);
            ctlHome.onMapCreated(ctlHome.mapController);
            ctlcommande.DETAILLER_COMMANDE.value = true;
            Get.toNamed(Routes.COMMANDE);
          } else {
            Get.snackbar("", "Chargement des données en cours");
            ctlcommande.getCommandeDisponible();
          }
        });
      },
      child: Container(
        height: commande.montantNegocie.toString() !=
                commande.montantPercu.toString()
            ? 15.h
            : 10.h,
        decoration: BoxDecoration(
            color: AppColors.DWHITE0,
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ComandDispoCardItem(
                  titre: "Destination", lieu: commande.destLibelle),
              ComandDispoCardDureeMontant(
                  montant: commande.montantPercu, duree: commande.duree),
              commande.montantNegocie.toString() !=
                      commande.montantPercu.toString()
                  ? Container(
                      color: Colors.amber.shade50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Négocié à :",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            Flexible(
                                child: Text(
                              "${commande.montantNegocie} F",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
                            ))
                          ]),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    ),
  );
}

Row ComandDispoCardItem({
  required titre,
  required lieu,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "$titre :",
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
      ),
      Flexible(
        child: Text(
          "$lieu",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontStyle: FontStyle.italic),
        ),
      ),
    ],
  );
}

Row ComandDispoCardDureeMontant({
  required montant,
  required duree,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "MT : $montant F",
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
      Text(
        "Durée:  $duree min",
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    ],
  );
}
