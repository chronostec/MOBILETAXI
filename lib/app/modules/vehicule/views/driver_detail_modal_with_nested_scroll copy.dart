import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/modules/driver/views/driver_add_view.dart';
import 'package:fredy_proprio/app/modules/vehicule/views/vehicule_add_view.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';
import 'package:get/get.dart';

class VehiculeDetailNestedScrollModal extends StatelessWidget {
  final Vehicule vehicule;
  VehiculeDetailNestedScrollModal({Key? key, required this.vehicule})
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
                    backgroundImage: AssetImage(AppImage.carImage),
                  ),
                  title: Text(
                    "${vehicule.marque ?? 'marque'} - ${vehicule.modele ?? 'modele'}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "IMMAT ${vehicule.immatriculation ?? ''}",
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        Get.back();
                        ctlVehicule.vehicule.value = vehicule;
                        ctlVehicule.vehiculeDate.value =
                            DateTime.tryParse(vehicule.annee.toString()) ??
                                DateTime.now();
                        ctlVehicule.isEditing.value = true;
                        ctlVehicule.immatTC.text =
                            vehicule.immatriculation.toString();
                        ctlVehicule.modelTC.text = vehicule.modele.toString();
                        ctlVehicule.marqueTC.text = vehicule.marque.toString();
                        ctlVehicule.couleurTC.text =
                            vehicule.couleur.toString();

                        Get.to(() => VehiculeAddView());
                      },
                      icon: const Icon(FontAwesomeIcons.edit)),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.bolt_fill,
                              color: primary,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                                "${ctlVehicule.vehiculeResume.value.distanceJour ?? 0} km"),
                            Spacer(),
                            Container(
                                height: 20.0, width: 1.0, color: Colors.grey),
                            Spacer(),
                            Icon(
                              FontAwesomeIcons.coins,
                              color: secondary,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                                "${ctlVehicule.vehiculeResume.value.montantJour ?? 0} F"),
                            Spacer(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Card(
                        elevation: 5.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(children: [
                            (ctlVehicule.vehiculeResume.value.driverNom !=
                                        null ||
                                    ctlVehicule.vehiculeResume.value
                                            .driverPrenom !=
                                        null)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Chauffeur"),
                                      Text(
                                          "${ctlVehicule.vehiculeResume.value.driverNom} ${ctlVehicule.vehiculeResume.value.driverPrenom}"),
                                    ],
                                  )
                                : const SizedBox(),
                            const Spacer(),
                            ctlVehicule.vehiculeResume.value.driverNom != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      Text(
                                          "${ctlVehicule.vehiculeResume.value.driverTelephone}"),
                                    ],
                                  )
                                : const SizedBox(),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ],
        )),
      ),
    );
  }

  final Color primary = Color(0xffE20056);
  final Color secondary = Color(0xFFF3D00A);
  final Color border = Color(0xffE1DDDE);
  final Color bg = Color(0xfffefefe);
  final List<bool> toggleIsSelected = [true, false, false];
}
