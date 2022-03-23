import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/driver_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/modules/driver/views/driver_add_view.dart';
import 'package:fredy_proprio/app/modules/driver/views/driver_historique_view.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'attribute_vehicle_modal.dart';

class driverDetailNestedScrollModal extends StatelessWidget {
  final Driver driver;
  driverDetailNestedScrollModal({Key? key, required this.driver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                child: SizedBox(
                  height: 10,
                  width: 50,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                        height: 5.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(AppImage.person1Image),
                    ),
                    title: Text(
                      "${driver.nom} ${driver.prenom}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${driver.telephone}",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: driver.id! > 0
                        ? IconButton(
                            onPressed: () {
                              Get.back();
                              ctlDriver.isEditing.value = true;
                              ctlDriver.driver.value = driver;

                              ctlDriver.nomTC.text = driver.nom ?? '';
                              ctlDriver.prenomTC.text = driver.prenom ?? '';
                              ctlDriver.permisTC.text =
                                  driver.numeroPermis ?? '';
                              ctlDriver.vehiculeTC.text = ctlDriver
                                      .vehiculeResume.value.immatriculation ??
                                  '';

                              ctlDriver.vehicleSelected.value = Vehicule(
                                id: ctlDriver.vehiculeResume.value.id,
                                immatriculation: ctlDriver
                                    .vehiculeResume.value.immatriculation,
                                annee: ctlDriver.vehiculeResume.value.annee,
                                marque: ctlDriver.vehiculeResume.value.marque,
                                modele: ctlDriver.vehiculeResume.value.modele,
                              );

                              ctlDriver.nomTC.text = driver.nom ?? '';
                              ctlDriver.prenomTC.text = driver.prenom ?? '';
                              ctlDriver.telephoneTC.text =
                                  driver.telephone ?? '';

                              Get.to(() => DriverAddView());
                            },
                            icon: const Icon(FontAwesomeIcons.edit))
                        : const SizedBox(),
                  ),
                  Center(
                    child: ActionChip(
                        label: const Text("attribuer un véhicule"),
                        onPressed: () async {
                          ctlDriver.driverID.value = driver.id ?? 0;
                          await ctlDriver.getVehiculeLibre();
                          showCupertinoModalBottomSheet(
                              expand: true,
                              context: context,
                              builder: (context) => AttribuerVehiculeModal());
                        }),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: border),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        Obx(() => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.car,
                                    color: primary,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                      "${ctlDriver.vehiculeResume.value.distanceJour ?? 0} km"),
                                  const Spacer(),
                                  Container(
                                      height: 20.0,
                                      width: 1.0,
                                      color: Colors.grey),
                                  const Spacer(),
                                  Icon(
                                    FontAwesomeIcons.coins,
                                    color: secondary,
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                      "${ctlDriver.vehiculeResume.value.montantJour ?? 0} F"),
                                  const Spacer(),
                                ],
                              ),
                            )),
                        const SizedBox(height: 20.0),
                        if (driver.vehiculeId != null && driver.vehiculeId! > 0)
                          Card(
                            elevation: 5.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(ctlVehicule.vehiculesList
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    driver.vehiculeId)
                                                .immatriculation ??
                                            'IMMATRICULATION'),
                                        Text(ctlVehicule.vehiculesList
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    driver.vehiculeId)
                                                .marque ??
                                            "MARQUE"),
                                      ],
                                    ),
                                    // const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        Text(ctlVehicule.vehiculesList
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    driver.vehiculeId)
                                                .modele ??
                                            "MODELE"),
                                        Text(ctlVehicule.vehiculesList
                                                .firstWhere((element) =>
                                                    element.id ==
                                                    driver.vehiculeId)
                                                .couleur ??
                                            "COULEUR")
                                      ],
                                    ),
                                    ActionChip(
                                        label: const Icon(
                                            CupertinoIcons.list_number),
                                        onPressed: () {
                                          Get.back();
                                          ctlDriver.driver.value = driver;
                                          Get.to(DriverHistoriqueView());
                                        })
                                  ]),
                            ),
                          )
                        else
                          const SizedBox(),
                        // const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Color primary = const Color(0xffE20056);
  final Color secondary = const Color(0xFFF3D00A);
  final Color border = const Color(0xffE1DDDE);
  final Color bg = const Color(0xfffefefe);
  final List<bool> toggleIsSelected = [true, false, false];
}
