import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/data/models/distance_matrix_model.dart';
import 'package:alfred_taxi_client/app/modules/home/views/picked_propositions_modal.dart';
import 'package:alfred_taxi_client/app/modules/recherche/views/propositions_modal_fit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

rechercherSelectiondestination(context) async {
  ctlMapCourse
      .calculerDistanceMatrix(
          ctlRecherche.departGps.value, ctlHome.cameraPosition.value.target)
      .then((DistanceMatrix value) {
    ctlRecherche.postRechercheEvaluationToApi(
        client_id: ctlHome.user.value.id,
        origine_libelle: ctlRecherche.departTC.text.isNotEmpty
            ? ctlRecherche.departTC.text
            : ctlMapCourse.distMatrix.value.originAddresses![0],
        longitude: ctlRecherche.departGps.value.longitude,
        latitude: ctlRecherche.departGps.value.latitude,
        dest_libelle: ctlRecherche.arriveeTC.text.isNotEmpty
            ? ctlRecherche.arriveeTC.text
            : ctlMapCourse.distMatrix.value.destinationAddresses![0],
        dest_longitude: ctlHome.cameraPosition.value.target.longitude,
        dest_latitude: ctlHome.cameraPosition.value.target.latitude,
        duree:
            ctlMapCourse.distMatrix.value.rows![0].elements![0].duration!.value,
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
    builder: (context) => PickedPropositions(),
  );
}
