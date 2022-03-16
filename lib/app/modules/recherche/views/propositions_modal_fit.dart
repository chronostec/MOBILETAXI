import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/modules/recherche/views/negociation_view.dart';
import 'package:alfred_taxi_client/app/modules/utils/app_svg.dart';
import 'package:alfred_taxi_client/app/modules/utils/images_path.dart';
import 'package:alfred_taxi_client/app/modules/utils/spinkit_dialog.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class CategorieModalFit extends StatelessWidget {
  CategorieModalFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              child: Divider(
                color: Colors.grey,
                thickness: 3,
                indent: 2,
              ),
              width: 40,
            ),
            ListTile(
              title: Text(
                '${ctlRecherche.destinationTC.text}',
                textAlign: TextAlign.center,
              ),
              subtitle: (ctlMapCourse.drivingDistMatrix.value.rows != null &&
                      ctlMapCourse.drivingDistMatrix.value.rows!.length > 0)
                  ? Text(
                      'Durée estimée à ${ctlMapCourse.distMatrix.value.rows![0].elements![0].duration!.text ?? '...'}',
                      textAlign: TextAlign.center,
                    )
                  : SizedBox(),

              // leading: Icon(Icons.map),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(),
            if (ctlRecherche.propositionsList.length == 0)
              SizedBox(
                child: SpinKitCircle(color: AppColor.CREDO),
              )
            else
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < ctlRecherche.propositionsList.length; i++)
                    ListTile(
                        title: Text(
                          '${ctlRecherche.propositionsList[i].libelle}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                            '${ctlRecherche.propositionsList[i].montant} Fcfa'),
                        leading: Container(
                          height: 100.0,
                          width: 20.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imgList[i]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () async {
                          ctlRecherche.proposition_id.value =
                              ctlRecherche.propositionsList[i].id;
                          showEndedCoursetDialog(context: context);
                          Future.delayed(
                            Duration(seconds: 4),
                            () => Get.back,
                          );
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
                        }),
                  ListTile(
                      title: Text(
                        'Je veux négocier',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Container(
                        height: 100.0,
                        width: 20.w,
                        child: SvgPicture.asset(AppSvg.deal),
                      ),
                      onTap: () async {
                        // ctlRecherche.proposition_id.value =
                        //     ctlRecherche.propositionsList[i].id;

                        ctlHome.verifierIdentite();

                        if (ctlHome.user_is_connected.value) {
                          await showMaterialModalBottomSheet(
                            expand: false,
                            bounce: true,
                            isDismissible: true,
                            elevation: 15,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => NegociationView(),
                          );
                        } else {
                          Get.back();
                          ctlLogin.isOTPview.value = false;
                          Get.toNamed(Routes.LOGIN);
                        }
                      }),
                ],
              )
          ],
        ),
      ),
    ));
  }

  List imgList = [AppImage.car, AppImage.lux1, AppImage.lux2];
}
