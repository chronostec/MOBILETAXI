import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/themes/colors/app_colors.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';
import 'package:fredy_proprio/app/utils/app_styles.dart';
import 'package:fredy_proprio/app/utils/modals/modal_with_nested_scroll.dart';

import 'package:get/get.dart';
import 'package:image_picker_type/image_picker_type.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import 'dates_picker.dart';

class VehiculeAddView extends GetView {
  VehiculeAddView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
            backgroundColor:
                ctlVehicule.isEditing.value ? AppColor.PRED : AppColor.PGREY,
            title: ctlVehicule.isEditing.value
                ? const Text("Modifier Véhicule", style: redStyle)
                : const Text("Nouveau Véhicule", style: whiteStyle),
            centerTitle: true),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 20),
                    chapsSaisie(
                        controller: ctlVehicule.immatTC,
                        hint: "1020ZA99.",
                        label: "Immatriculation",
                        inputAction: TextInputAction.next),
                    chapsSaisie(
                        controller: ctlVehicule.marqueTC,
                        hint: "Mercedes Benz.",
                        label: "Marque",
                        inputAction: TextInputAction.next),
                    chapsSaisie(
                        controller: ctlVehicule.modelTC,
                        hint: "TX 01.",
                        label: "Modèle",
                        inputAction: TextInputAction.next),
                    openChooseAnnee(context),
                    openChooseCouleur(context),
                    openChooseCatgeorie(context),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CupertinoButton(
                        color: ctlVehicule.isEditing.value
                            ? AppColor.PRED
                            : AppColor.PGREY,
                        child: ctlVehicule.isEditing.value
                            ? const Text("METTRE A JOUR", style: whiteStyle)
                            : const Text("ENREGISTRER", style: whiteStyle),
                        onPressed: () async {
                          //TODO
                          if (ctlVehicule.categorieTC.text.isEmpty) {
                            ctlVehicule.categorieTC.text =
                                ctlVehicule.categoriesList[10].libelle ?? "";
                          }
                          if (_formKey.currentState!.validate()) {
                            ctlVehicule.isEditing.value
                                ? await modifierVehicule()
                                : await enregistrerVehicule();
                          } else {
                            Get.snackbar("ENREGISTREMENT VEHICULE",
                                "Veillez à bien remplir tous les champs");
                            Get.back();
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
              actions: [
                for (var i = 0; i < ctlVehicule.categoriesList.length; i++)
                  CupertinoActionSheetAction(
                      onPressed: () {
                        ctlVehicule.categorieID.value =
                            ctlVehicule.categoriesList[i].id ?? 1;
                        ctlVehicule.categorieTC.text =
                            ctlVehicule.categoriesList[i].libelle ?? "ECO";
                        Get.back();
                      },
                      child: Text(ctlVehicule.categoriesList[i].libelle ?? '')),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Fermer'),
              ),
            ));
  }

  void _showColorPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
              actions: [
                for (var i = 0; i < ctlVehicule.couleurList.length; i++)
                  CupertinoActionSheetAction(
                      onPressed: () {
                        ctlVehicule.couleurTC.text = ctlVehicule.couleurList[i];
                        Get.back();
                      },
                      child: Text(ctlVehicule.couleurList[i])),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Fermer'),
              ),
            ));
  }

  Future<dynamic> openModal(BuildContext context) {
    return showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        builder: (context) => NestedScrollModal());
  }

  Padding chapsSaisie(
      {controller,
      hint,
      label,
      inputAction = TextInputAction.next,
      keyboardType = TextInputType.text,
      ontap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextFormField(
          validator: (value) {
            if (value!.isNotEmpty) {
              return null;
            } else {
              return "Champs requis";
            }
          },
          controller: controller,
          textInputAction: inputAction,
          keyboardType: keyboardType,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          onTap: ontap,
          decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))))),
    );
  }

  Widget openChooseCatgeorie(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
          controller: ctlVehicule.categorieTC,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          onTap: () => _showPicker(context),
          readOnly: true,
          decoration: const InputDecoration(
              hintText: "Excellent",
              labelText: "Etat actuel du véhicule",
              labelStyle: TextStyle(
                fontWeight: FontWeight.normal,
              ),
              hintStyle:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))))),
    );
  }

  Widget openChooseCouleur(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
          controller: ctlVehicule.couleurTC,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          onTap: () => _showColorPicker(context),
          readOnly: true,
          decoration: const InputDecoration(
              hintText: "Noir",
              labelText: "Couleur",
              labelStyle: TextStyle(
                fontWeight: FontWeight.normal,
              ),
              hintStyle:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))))),
    );
  }

  Widget openChooseAnnee(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextField(
          controller: ctlVehicule.anneeTC,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          onTap: () => showVehiculeAnneeDatePicker(context),
          readOnly: true,
          decoration: const InputDecoration(
              labelText: "Année",
              labelStyle: TextStyle(
                fontWeight: FontWeight.normal,
              ),
              hintStyle:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))))),
    );
  }

  enregistrerVehicule() async {
    await ctlVehicule.addVehicule().then((value) {
      if (value.message == "succes") {
        ctlVehicule.clearTextFields();
        // Get.snackbar(
        //     "ENREGISTREMENT VEHICULE", "Véhicule enregistré avec succès !");
        // Get.back();
        Get.back();
      } else {
        Get.snackbar("ENREGISTREMENT VEHICULE", "Echec d'enregistrement !");
      }
    });
  }

  modifierVehicule() {
    ctlVehicule.updateVehicule().then((value) {
      if (value.message == "succes") {
        ctlVehicule.clearTextFields();

        Get.back();
      } else {
        Get.snackbar("ENREGISTREMENT VEHICULE", "Echec d'enregistrement !");
      }
    });
  }
}
