import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/modules/commande/views/commande_driving_view.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:alfred_taxi_driver/app/utils/small_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommandeDetailBottomButtons extends StatelessWidget {
  const CommandeDetailBottomButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: AppColors.DBLACK,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallButton(
                  title: 'Réfuser',
                  color: AppColors.DRED,
                  actionPrincipale: () async {
                    var res = await showModalActionSheet<String>(
                      context: context,
                      title: 'Refuser commande',
                      message:
                          "En continuant, vous enlevez cette comande de votre liste de commande actuelle ?",
                      actions: [
                        const SheetAction(
                          icon: Icons.check,
                          label: "OUI",
                          key: KEYWORD.YES,
                          isDefaultAction: true,
                        ),
                        const SheetAction(
                          icon: Icons.close,
                          label: 'NON',
                          key: KEYWORD.NO,
                        ),
                      ],
                    );
                    print(res);
                    if (res.toString().toLowerCase() ==
                        KEYWORD.YES.toString().toLowerCase()) {
                      ctlcommande.changeStatus(CMDSTATUS.COMMAND_EMPTY);
                      // ctlcommande.listCommande.removeWhere((element) =>
                      //     element.id == ctlcommande.commande.value.id);

                      Get.offAllNamed(Routes.HOME);
                    }
                  },
                ),
                SmallButton(
                  title: 'Accepter',
                  color: AppColors.DGREEN,
                  actionPrincipale: () async {
                    var res = await showModalActionSheet<String>(
                      context: context,
                      title: 'Accepter commande',
                      message:
                          "En continuant, vous accepter de conduire ce client depuis le lieu de rendez-vous jusqu'à destination",
                      actions: [
                        const SheetAction(
                          icon: Icons.info,
                          label: "J'accepte !",
                          key: KEYWORD.ACCEPTER,
                          isDefaultAction: true,
                        ),
                        const SheetAction(
                          icon: Icons.reply_all_rounded,
                          label: 'Revenir en arrière',
                          key: KEYWORD.REVENIR,
                        ),
                      ],
                    );
                    print(res);
                    if (res != null) {
                      ctlcommande.managerCourse(res.toLowerCase(),
                          context: context);
                    }
                  },
                  actionSecondaire: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
