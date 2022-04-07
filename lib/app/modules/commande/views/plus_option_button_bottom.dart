import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:alfred_taxi_driver/app/utils/small_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import 'modals_and_paiement_modal_fit.dart';

Align plusOptionBottomBar(BuildContext context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: SizedBox(
        width: 100.w,
        height: 7.h,
        child: BigButton(
          title: "Plus d'options",
          color: AppColors.DRED1,
          actionPrincipale: () async {
            checkEchangePeriodicEvent();
            var res = await showModalActionSheet<String>(
              context: context,
              cancelLabel: "fermer",
              actions: [
                const SheetAction(
                  icon: CupertinoIcons.chat_bubble,
                  label: "ECRIRE AU CLIENT",
                  key: KEYWORD.ECHANGER,
                  isDefaultAction: true,
                ),
                const SheetAction(
                  icon: Icons.call,
                  label: 'APPELER CLIENT(E)',
                  key: KEYWORD.APPELER,
                ),
                const SheetAction(
                  icon: Icons.directions,
                  label: 'COMMENCER COURSE',
                  key: KEYWORD.COMMENCER,
                ),
                const SheetAction(
                  icon: Icons.cancel,
                  label: 'ANNULER COURSE',
                  key: KEYWORD.ANNULER,
                ),
              ],
            );
            print(res);

            if (res != null) {
              ctlcommande.managerCourse(res.toString().toLowerCase(),
                  context: context);
            }
          },
        ),
      ),
    ),
  );
}

Align plusOptionBottomBarDriving(BuildContext context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      child: SizedBox(
        width: 100.w,
        child: BigButton(
          title: "Plus d'options",
          color: AppColors.DRED1,
          actionPrincipale: () async {
            checkEchangePeriodicEvent();
            var res = await showModalActionSheet<String>(
              context: context,
              cancelLabel: "fermer",
              actions: [
                const SheetAction(
                  icon: Icons.paid,
                  label: "Passer au paiement",
                  key: KEYWORD.PAYER,
                  isDefaultAction: true,
                ),
                const SheetAction(
                  icon: CupertinoIcons.chat_bubble_2,
                  label: "ECRIRE AU CLIENT",
                  key: KEYWORD.ECHANGER,
                  isDefaultAction: true,
                ),
                const SheetAction(
                  icon: Icons.call,
                  label: 'Appeler client',
                  key: KEYWORD.APPELER,
                ),
                const SheetAction(
                  icon: Icons.cancel,
                  label: 'ANNULER COURSE',
                  key: KEYWORD.ANNULER,
                ),
              ],
            );
            print(res);
            // launch(('tel://0757777500'))
            if (res != null) {
              if (res.toString().toLowerCase() == KEYWORD.PAYER) {
                await showCupertinoModalBottomSheet(
                  expand: false,
                  bounce: true,
                  elevation: 15,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const PayementModalFit(),
                );
              } else {
                ctlcommande.managerCourse(res.toString().toLowerCase(),
                    context: context);
              }
            }
          },
        ),
      ),
    ),
  );
}
