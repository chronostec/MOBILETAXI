import 'dart:ui';

import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'annuler_cmde_dialog.dart';

class AwaitingCmdeBottom extends StatelessWidget {
  const AwaitingCmdeBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
          color: AppColor.CWHITEDARK,
          elevation: 8,
          child: Container(
              // height: 25.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColor.CWHITE,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ListTile(
                  leading: IconButton(
                      onPressed: () {
                        //TODO
                        annulerCmde(context: context);
                      },
                      icon: Icon(Icons.close)),
                  title: Text(
                    "Mise en relation avec un chauffeur",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: AppColor.CBLACK,
                        fontSize: 13),
                    textAlign: TextAlign.left,
                  ),
                  subtitle: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                    backgroundColor: Theme.of(context).primaryColorLight,
                  ),
                ),
                (ctlRecherche.maCommande.value.montantClient != null)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Wrap(children: [
                              Text(
                                'MT: ',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '${ctlRecherche.maCommande.value.montantNegocie ?? ''} Fcfa',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ]),
                            Wrap(children: [
                              Text(
                                'durée course: ',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                '${ctlRecherche.maCommande.value.dureeEffective ?? '...'} min',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ]),
                          ],
                        ),
                      )
                    : SizedBox(),
                (ctlRecherche.maCommande.value.rdvLibelle != null &&
                        ctlRecherche.maCommande.value.rdvLibelle!.isNotEmpty)
                    ? Card(
                        color: AppColor.CGREYLIGHT,
                        child: ListTile(
                          leading: Icon(
                            Icons.person_pin_circle_sharp,
                            color: AppColor.CGREEN,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${ctlRecherche.maCommande.value.rdvLibelle ?? ''}',
                                // textAlign: TextAlign.left,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    : SizedBox(),
                (ctlRecherche.maCommande.value.destLibelle != null &&
                        ctlRecherche.maCommande.value.destLibelle!.isNotEmpty)
                    ? Card(
                        color: AppColor.CGREYLIGHT,
                        child: ListTile(
                            leading: Icon(
                              Icons.person_pin_circle_sharp,
                              color: AppColor.CRED,
                            ),
                            title: Text(
                                '${ctlRecherche.maCommande.value.destLibelle ?? ''}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))))
                    : SizedBox()
              ]))),
    );
  }
}
