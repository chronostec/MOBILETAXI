import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';
import 'package:fredy_proprio/app/utils/app_styles.dart';
import 'package:fredy_proprio/app/utils/custom_alert_dialog.dart';

import 'package:get/get.dart';
import 'package:image_picker_type/image_picker_type.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import 'attribute_vehicle_modal_with_nested_scroll.dart';

class DriverAddView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ctlDriver.isEditing.value ? Colors.red : Colors.blue,
          title: ctlDriver.isEditing.value
              ? const Text("Modifier chauffeur", style: redStyle)
              : const Text("Nouveau chauffeur", style: whiteStyle),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        child: ctlDriver.photoTC.text.isNotEmpty
                            ? Container(
                                height: 20.h,
                                width: 50.w,
                                child: Image.file(File(ctlDriver.photoTC.text),
                                    scale: 1))
                            : Ink(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            AssetImage(AppImage.person1Image),
                                        fit: BoxFit.cover)))),
                    Align(
                      alignment: const Alignment(1.5, 1.5),
                      child: MaterialButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: ImagePickerHelper(
                                    // isSave: true,  //if you want to save image in directory

                                    size: const Size(300, 300),
                                    onDone: (file) {
                                      if (file == null) {
                                        print(null);
                                      } else {
                                        ctlDriver.photoTC.text = file.path;
                                        printInfo(
                                            info:
                                                "PHOTO PICKED at ${file.path}");
                                      }
                                    },
                                  ),
                                );

                                /// If you dont want to safe area you can remove it
                              });
                        },
                        minWidth: 0,
                        child: const Icon(Icons.camera_alt),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: const CircleBorder(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20),
                chapsSaisie(
                    controller: ctlDriver.nomTC,
                    hint: "Gbeu.",
                    label: "Nom",
                    inputAction: TextInputAction.next),
                chapsSaisie(
                    controller: ctlDriver.prenomTC,
                    hint: "Noel.",
                    label: "Prénom",
                    inputAction: TextInputAction.next),
                chapsSaisie(
                    controller: ctlDriver.permisTC,
                    hint: "445832540CI22.",
                    label: "Numéro permis",
                    inputAction: TextInputAction.next),
                chapsSaisie(
                    controller: ctlDriver.telephoneTC,
                    hint: "+225 0707060504",
                    label: "Téléphone",
                    keyboardType: TextInputType.phone,
                    inputAction: TextInputAction.next),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CupertinoButton(
                    color: ctlDriver.isEditing.value ? Colors.red : Colors.blue,
                    child: ctlDriver.isEditing.value
                        ? const Text("METTRE A JOUR", style: whiteStyle)
                        : const Text("ENREGISTRER", style: whiteStyle),
                    onPressed: () async {
                      //TODO
                      ctlDriver.isLoading.value
                          ? myAwaitingDialog(context: context)
                          : null;
                      ctlDriver.isEditing.value
                          ? await modifierDriver()
                          : await enregistrerDriver();

                      Get.back();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    ;
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
      child: TextField(
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

  enregistrerDriver() async {
    await ctlDriver.postDriver();
  }

  modifierDriver() async {
    await ctlDriver.putDriver();
  }
}
