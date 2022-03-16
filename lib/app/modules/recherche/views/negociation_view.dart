import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/modules/recherche/controllers/negociation_controller.dart';
import 'package:alfred_taxi_client/app/modules/utils/images_path.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:count_stepper/count_stepper.dart';
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
              children: [
                for (var index = 0;
                    index < ctlRecherche.propositionsList.length;
                    index++)
                  Container(
                    height: 12.h,
                    width: 90.w,
                    padding: const EdgeInsets.all(12),
                    decoration: ctlNegociation.selectedIndex.value == index
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                colors: [AppColor.CREDO, AppColor.CORANGE]))
                        : BoxDecoration(
                            border:
                                Border.all(width: 2, color: AppColor.CORANGE),
                            borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                        title: Text(
                          '${ctlRecherche.propositionsList[index].libelle}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                            '${ctlRecherche.propositionsList[index].montant} Fcfa'),
                        leading: Container(
                          height: 100.0,
                          width: 20.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imgList[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () async {
                          ctlNegociation.selectedIndex.value = index;
                        }),
                  )
              ],
            ),
          )),
    );
  }
}
