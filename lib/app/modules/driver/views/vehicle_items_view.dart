import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/utils/app_styles.dart';

import 'package:get/get.dart';

class VehicleItemsView extends GetView {
  final VehiculeLibre vLibre;
  const VehicleItemsView(this.vLibre, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: MaterialButton(
          padding: const EdgeInsets.all(0),
          elevation: 0.5,
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {
            ctlDriver.vehiclelibre.value = vLibre;
            Get.back();
          },
          child: Row(
            children: <Widget>[
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
                              Text("${vLibre.marque}", style: spacerTextStyle),
                              const SizedBox(
                                height: 2,
                              ),
                              Text("${vLibre.modele}", style: spacerTextStyle),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("${vLibre.immatriculation}",
                                  style: priceTextStyle)
                            ],
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
