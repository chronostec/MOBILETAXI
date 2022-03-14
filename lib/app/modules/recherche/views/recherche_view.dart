import 'package:alfred_taxi_client/app/common/controllers.dart'
    show ctlHome, ctlMapCourse, ctlRecherche;
import 'package:alfred_taxi_client/app/data/models/distance_matrix_model.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../controllers/recherche_controller.dart';
import 'propositions_modal_fit.dart';

class RechercheView extends GetView<RechercheController> {
  FocusNode originFocusNode = FocusNode();
  final destinationFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.CWHITE,
          title: Obx(() {
            return SizedBox(
                child: ctlRecherche.isOriginetaped.value
                    ? Text(
                        'Point de départ',
                        style: TextStyle(
                            color: AppColor.CBLACK,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      )
                    : Text(
                        "Point d'arrivée",
                        style: TextStyle(
                            color: AppColor.CBLACK,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ));
          }),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Align(
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ctlRecherche.isOriginetaped.value
                          ? ListView(
                              padding: const EdgeInsets.all(15),
                              children: [
                                for (var place in ctlRecherche.originePlaceList)
                                  Container(
                                    child: ListTile(
                                      trailing: Icon(Icons.place),
                                      title: Text(
                                        place.structuredFormatting!.mainText
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.CBLACK),
                                      ),
                                      subtitle: Text(
                                        place
                                            .structuredFormatting!.secondaryText
                                            .toString(),
                                      ),
                                      onTap: () async {
                                        ctlRecherche.detailOigine.value =
                                            await ctlMapCourse
                                                .trouverDetailPlaceId(
                                                    place.placeId.toString());
                                        ctlRecherche.origineTC.text = place
                                            .structuredFormatting!.mainText
                                            .toString();

                                        // ctlMapCourse.calculerDistanceMatrix(
                                        //   LatLng(
                                        //       ctlRecherche
                                        //           .detailOigine
                                        //           .value
                                        //           .geometry!
                                        //           .location!
                                        //           .lat!,
                                        //       ctlRecherche
                                        //           .detailOigine
                                        //           .value
                                        //           .geometry!
                                        //           .location!
                                        //           .lng!
                                        //           .toDouble()),
                                        //   LatLng(
                                        //     ctlRecherche.detailDestination.value
                                        //         .geometry!.location!.lat!
                                        //         .toDouble(),
                                        //     ctlRecherche.detailDestination.value
                                        //         .geometry!.location!.lng!
                                        //         .toDouble(),
                                        //   ),
                                        // );
                                      },
                                    ),
                                  )
                              ],
                            )
                          : ListView(
                              padding: const EdgeInsets.all(15),
                              children: [
                                for (var place
                                    in ctlRecherche.destinationPlaceList)
                                  Container(
                                    child: ListTile(
                                      trailing: Icon(Icons.chevron_right),
                                      title: Text(
                                        place.structuredFormatting!.mainText
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.CBLACK),
                                      ),
                                      subtitle: Text(
                                        place
                                            .structuredFormatting!.secondaryText
                                            .toString(),
                                      ),
                                      onTap: () async {
                                        ctlRecherche.detailDestination.value =
                                            await ctlMapCourse
                                                .trouverDetailPlaceId(
                                                    place.placeId.toString());
                                        ctlRecherche.destinationTC.text = place
                                            .structuredFormatting!.mainText
                                            .toString();
                                        ctlRecherche
                                            .isDestinationNotEmpty.value = true;

                                        printInfo(
                                            info:
                                                "GEOMETRY ${ctlRecherche.detailDestination.value.geometry!.location.lat}");
                                        ctlMapCourse.calculerDistanceMatrix(
                                          LatLng(
                                              ctlRecherche.detailOigine.value
                                                  .geometry!.location!.lat!
                                                  .toDouble(),
                                              ctlRecherche.detailOigine.value
                                                  .geometry!.location!.lng!
                                                  .toDouble()),
                                          LatLng(
                                            ctlRecherche.detailDestination.value
                                                .geometry!.location!.lat!
                                                .toDouble(),
                                            ctlRecherche.detailDestination.value
                                                .geometry!.location!.lng!
                                                .toDouble(),
                                          ),
                                        );
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                  )
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              alignment: Alignment.topCenter,
            ),
            Align(
              child: RECHERCHETRAJET(),
              alignment: Alignment.bottomCenter,
            ),
          ],
        )));
  }
}

class RECHERCHETRAJET extends StatelessWidget {
  const RECHERCHETRAJET({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20.h,
      width: 95.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColor.CWHITEDARK),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.place,
                color: AppColor.CBLACK,
              ),
              Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.CGREYLIGHT),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextField(
                      controller: ctlRecherche.origineTC,
                      style: TextStyle(
                          color: AppColor.CBLACK,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "${ctlMapCourse.pointPosition.value.libelle ?? 'Lieu de RDV'}",
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: AppColor.CGREY),
                          suffixIcon: ctlRecherche.origineTC.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    ctlRecherche.origineTC.text = "";
                                    ctlRecherche.isOrigineNotEmpty.value =
                                        false;
                                  })
                              : SizedBox()),
                      onTap: () => ctlRecherche.isOriginetaped.value = true,
                      onChanged: (value) {
                        ctlRecherche.isDestinationNotEmpty.value = false;
                        if (value.isNotEmpty) {
                          ctlRecherche.suggererOriginePlaces();
                        }
                      },
                    ),
                  )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.place,
                color: AppColor.CBLACK,
              ),
              Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.CGREYLIGHT),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextField(
                      controller: ctlRecherche.destinationTC,
                      autofocus: true,
                      style: TextStyle(
                          color: AppColor.CBLACK,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ou allez-vous ?",
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                          suffixIcon: ctlRecherche.destinationTC.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    ctlRecherche.destinationTC.text = "";
                                    ctlRecherche.isDestinationNotEmpty.value =
                                        false;
                                  })
                              : SizedBox()),
                      onTap: () => ctlRecherche.isOriginetaped.value = false,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          ctlRecherche.suggererDestinationPlaces();
                        }
                      },
                    ),
                  )),
            ],
          ),
          ctlRecherche.isDestinationNotEmpty.value &&
                  ctlRecherche.destinationTC.text.isNotEmpty
              ? CupertinoButton(
                  onPressed: () {
                    terminerRecherche(context);
                  },
                  child: Text("TERMINER",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: AppColor.CBLACK)))
              : SizedBox(),
        ],
      ),
    );
  }

  terminerRecherche(context) async {
    ctlMapCourse
        .calculerDistanceMatrix(
      LatLng(
          (ctlRecherche.detailOigine.value.geometry!.location!.lat != null &&
                  ctlRecherche.detailOigine.value.geometry!.location!.lat!
                          .toDouble() >
                      0)
              ? ctlRecherche.detailOigine.value.geometry!.location!.lat!
                  .toDouble()
              : ctlRecherche.departGps.value.latitude,
          (ctlRecherche.detailOigine.value.geometry!.location!.lng != null &&
                  ctlRecherche.detailOigine.value.geometry!.location!.lng!
                          .toDouble() >
                      0)
              ? ctlRecherche.detailOigine.value.geometry!.location!.lng!
                  .toDouble()
              : ctlRecherche.departGps.value.longitude),
      LatLng(
        ctlRecherche.detailDestination.value.geometry!.location!.lat!
            .toDouble(),
        ctlRecherche.detailDestination.value.geometry!.location!.lng!
            .toDouble(),
      ),
    )
        .then((DistanceMatrix value) {
      printInfo(
          info:
              "DISTANCE MATRIX RECHERCHE--> DEST:${value.destinationAddresses} ORIG:${value.originAddresses}");

      ctlRecherche.postRechercheEvaluationToApi(
          client_id: ctlHome.user.value.id,
          origine_libelle: ctlRecherche.origineTC.text.isNotEmpty
              ? ctlRecherche.origineTC.text
              : ctlMapCourse.distMatrix.value.originAddresses![0],
          longitude: ctlMapCourse.distMatrix.value.origin!.longitude,
          latitude: ctlMapCourse.distMatrix.value.origin!.latitude,
          dest_libelle: ctlRecherche.destinationTC.text.isNotEmpty
              ? ctlRecherche.destinationTC.text
              : ctlMapCourse.distMatrix.value.destinationAddresses![0],
          dest_longitude: ctlMapCourse.distMatrix.value.destination!.longitude,
          dest_latitude: ctlMapCourse.distMatrix.value.destination!.latitude,
          duree: ctlMapCourse
              .distMatrix.value.rows![0].elements![0].duration!.value,
          distance: ctlMapCourse
              .distMatrix.value.rows![0].elements![0].distance!.value);
    });

    showMaterialModalBottomSheet(
      expand: false,
      bounce: true,
      isDismissible: true,
      elevation: 15,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CategorieModalFit(),
    );
  }
}
