import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/modules/recherche/controllers/negociation_controller.dart';
import 'package:alfred_taxi_client/app/modules/utils/images_path.dart';
import 'package:alfred_taxi_client/app/modules/utils/spinkit_dialog.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:alfred_taxi_client/app/themes/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NegociationView extends GetView<NegociationController> {
  List imgList = [AppImage.car, AppImage.lux1, AppImage.lux2];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: Text('NEGOCIER LE PRIX'),
            centerTitle: true,
          ),
          body: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 2.h),
                for (var index = 0;
                    index < ctlRecherche.propositionsList.length;
                    index++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                        height: 12.h,
                        padding: const EdgeInsets.all(12),
                        decoration: ctlNegociation.selectedIndex.value == index
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                    colors: [AppColor.CREDO, AppColor.CORANGE]))
                            : BoxDecoration(
                                border: Border.all(
                                    width: 2, color: AppColor.CORANGE),
                                borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                            title: Text(
                              '${ctlRecherche.propositionsList[index].libelle}',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: ctlRecherche.propositionsList[index]
                                        .montantMinimum !=
                                    null
                                ? ctlRecherche.propositionsList[index]
                                            .montantMinimum!
                                            .toInt() >
                                        0
                                    ? Text(
                                        'Négociable à ${ctlRecherche.propositionsList[index].montantMinimum ?? "0 Fcfa"} Fcfa minimum',
                                      )
                                    : Text(
                                        'Non négociable',
                                      )
                                : const SizedBox(),
                            trailing: Text(
                                '${ctlRecherche.propositionsList[index].montant} Fcfa'),
                            leading: Container(
                                height: 100.0,
                                width: 20.w,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(imgList[index]),
                                  fit: BoxFit.fill,
                                ))),
                            onTap: () async {
                              ctlNegociation.selectedIndex.value = index;
                              ctlNegociation.montantNegocie.value = ctlRecherche
                                      .propositionsList[index].montant ??
                                  0;
                            })),
                  ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(children: [
                      Text("Attention !!!"),
                      Text(
                          "En négociant le prix du transport vous prenez le risque de voir votre commande refusée par les chauffeurs",
                          textAlign: TextAlign.center),
                    ])),
                Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(CupertinoIcons.arrowtriangle_up_fill),
                          onPressed: () => ctlNegociation.incrementMoney(),
                        ),
                        Text(
                          "${ctlNegociation.montantNegocie.value}",
                          style: TextStyle(
                            color: AppColor.CBLACK,
                            fontSize: 28.sp,
                          ),
                        ),
                        IconButton(
                          icon: Icon(CupertinoIcons.arrowtriangle_down_fill),
                          onPressed: () => ctlNegociation.decrementMoney(),
                        )
                      ]),
                ),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: SizedBox(
                    height: 8.h,
                    width: 95.w,
                    child: ElevatedButton(
                        child: Text(
                          'COMMANDER ${ctlRecherche.propositionsList[ctlNegociation.selectedIndex.value].libelle}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          ctlRecherche.proposition_id.value = ctlRecherche
                              .propositionsList[
                                  ctlNegociation.selectedIndex.value]
                              .id;
                          ctlHome.verifierIdentite();

                          if (ctlHome.user_is_connected.value) {
                            ctlRecherche.passerCommandeToApi().then((value) {
                              if (value == "succes") {
                                ctlMapCourse.statuscommand.value =
                                    CMDSTATUS.COMMAND_TRAITEMENT;
                                Get.back();
                                Get.back();
                                Get.back();
                                // Get.offAllNamed(Routes.MA_COURSE);
                              }
                            });
                          } else {
                            Get.back();
                            ctlLogin.isOTPview.value = false;
                            Get.toNamed(Routes.LOGIN);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColor.CREDO))),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
