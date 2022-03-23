import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';
import 'package:fredy_proprio/app/utils/app_styles.dart';
import 'package:fredy_proprio/app/utils/custom_alert_dialog.dart';
import 'package:get/get.dart';

class AttribuerVehiculeModal extends StatelessWidget {
  AttribuerVehiculeModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            Obx(() => CupertinoSliverNavigationBar(
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                        onPressed: () {
                          if (ctlDriver.vehicleSelected.value.id != null &&
                              ctlDriver.vehicleSelected.value.id! > 0 &&
                              ctlDriver.driverID.value > 0) {
                            ctlDriver.isLoading.value
                                ? myAwaitingDialog(context: context)
                                : null;
                            ctlDriver.attribuerVehicule().then((value) {
                              if (value.message == "succes") {
                                Get.back();
                                Get.back();
                              } else {
                                Get.snackbar("ATTRIBUTION VEHICULOE",
                                    "Echec de l'opération. Veuillez réessayer svp");
                              }
                            });
                          }
                        },
                        icon: SvgPicture.asset(AppSvg.save, height: 30)),
                  ),
                  middle: CupertinoSearchTextField(
                    controller: ctlDriver.searchTextTC,
                    placeholder: 'Chercher ....',
                    onTap: () {
                      ctlDriver.tempVehiculelibreList.value =
                          ctlDriver.vehiculelibreList;
                    },
                    onChanged: (value) {
                      if (value.toString().isNotEmpty) {
                        ctlDriver.tempVehiculelibreList.value = ctlDriver
                            .vehiculelibreList.reversed
                            .toList()
                            .where((p0) =>
                                p0.immatriculation!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                p0.marque!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                p0.modele!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                            .toList();
                      } else {
                        ctlDriver.tempVehiculelibreList.value =
                            ctlDriver.vehiculelibreList;
                      }
                    },
                    onSuffixTap: () {
                      ctlDriver.searchTextTC.text = "";
                      ctlDriver.tempVehiculelibreList.value =
                          ctlDriver.vehiculelibreList;
                    },
                  ),
                  largeTitle: (ctlDriver.vehicleSelected.value != Vehicule() &&
                          ctlDriver.vehicleSelected.value.id != null &&
                          ctlDriver.vehicleSelected.value.id! > 0)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Card(
                              child: Chip(
                                  label: Text(
                                      "VEHICULE.  ${ctlDriver.vehicleSelected.value.immatriculation}"
                                          .toUpperCase()))))
                      : const SizedBox(),
                )),
            Obx(() => SliverList(
                    delegate: SliverChildListDelegate([
                  for (var index = 0;
                      index < ctlDriver.tempVehiculelibreList.length;
                      index++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: MaterialButton(
                        padding: const EdgeInsets.all(0),
                        elevation: 0.5,
                        // color: Colors.white,
                        clipBehavior: Clip.antiAlias,
                        shape: ctlDriver.vehicleSelected.value.id ==
                                ctlDriver.tempVehiculelibreList[index].id
                            ? RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.green, width: 4),
                                borderRadius: BorderRadius.circular(10.0))
                            : RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {},
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(AppSvg.car, height: 60),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                            Text(
                                                "${ctlDriver.tempVehiculelibreList[index].marque}"),
                                            Text(
                                                "${ctlDriver.tempVehiculelibreList[index].modele}"),
                                            const SizedBox(height: 5),
                                            Text(
                                                "IM. ${ctlDriver.tempVehiculelibreList[index].immatriculation}",
                                                style: ctlDriver.vehicleSelected
                                                            .value.id ==
                                                        ctlDriver
                                                            .tempVehiculelibreList[
                                                                index]
                                                            .id
                                                    ? priceTextStyle1
                                                    : priceTextStyle0)
                                          ])),
                                      IconButton(
                                        icon: ctlDriver
                                                    .vehicleSelected.value.id ==
                                                ctlDriver
                                                    .tempVehiculelibreList[
                                                        index]
                                                    .id
                                            ? const Icon(
                                                CupertinoIcons
                                                    .check_mark_circled_solid,
                                                color: Colors.green,
                                              )
                                            : const Icon(CupertinoIcons
                                                .check_mark_circled),
                                        onPressed: () {
                                          ctlDriver.vehicleSelected.value =
                                              Vehicule(
                                            id: ctlDriver
                                                .tempVehiculelibreList[index]
                                                .id,
                                            immatriculation: ctlDriver
                                                .tempVehiculelibreList[index]
                                                .immatriculation,
                                            marque: ctlDriver
                                                .tempVehiculelibreList[index]
                                                .marque,
                                            modele: ctlDriver
                                                .tempVehiculelibreList[index]
                                                .modele,
                                          );
                                        },
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    )
                ])))
          ],
        ),
      ),
    );
  }
}
