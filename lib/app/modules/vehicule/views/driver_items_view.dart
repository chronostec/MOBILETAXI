import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';
import 'package:fredy_proprio/app/utils/app_styles.dart';

import 'package:get/get.dart';

import 'driver_detail_modal_with_nested_scroll copy.dart';

class VehiculeItemsView extends GetView {
  final Vehicule vehicule;

  VehiculeItemsView(this.vehicule);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        elevation: 0.5,
        // color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {},
        child: Row(
          children: <Widget>[
            Ink(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                  // color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(AppImage.carImage),
                      fit: BoxFit.cover,
                      alignment: Alignment.center)),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("${vehicule.marque}"),
                            Text("${vehicule.modele}"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("IM. ${vehicule.immatriculation}",
                                style: priceTextStyle1)
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(CupertinoIcons.collections),
                        onPressed: () {
                          ctlVehicule.getVehiculeResume(vehicule.id).then(
                              (value) =>
                                  showMoreAboutVehicule(context, vehicule));
                        },
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showMoreAboutVehicule(BuildContext context, Vehicule vehicule) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => VehiculeDetailNestedScrollModal(
              vehicule: vehicule,
            ));
  }
}
