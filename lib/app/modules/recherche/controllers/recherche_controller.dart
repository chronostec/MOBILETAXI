import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/data/models/commande_model.dart';
import 'package:alfred_taxi_client/app/data/models/google_place_model.dart';
import 'package:alfred_taxi_client/app/data/models/notes_model.dart';
import 'package:alfred_taxi_client/app/data/models/paiement_model.dart';
import 'package:alfred_taxi_client/app/data/models/place_detail_model.dart';
import 'package:alfred_taxi_client/app/data/models/recherche_evaluation_model.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart';
import 'package:alfred_taxi_client/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_client/app/modules/note/views/note_view_expand.dart';
import 'package:alfred_taxi_client/app/modules/paiement_web/payment_web_view.dart';
import 'package:alfred_taxi_client/app/modules/utils/paiement_modal_fit.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RechercheController extends GetxController {
  ///SAISIR ORIGINE
  final departTC = TextEditingController();
  final arriveeTC = TextEditingController();

  ///SAISIR ORIGINE
  final origineTC = TextEditingController();

  ///SAISIR DESTINATION
  final destinationTC = TextEditingController();

  ///CHOISIR PLACE ORIGINE
  final originePlaceList = <GooglePlace>[].obs;

  ///CHOISIR PLACE DESTINATION
  final destinationPlaceList = <GooglePlace>[].obs;

  ///DETAIL DES PLACE
  final detailOigine = PlaceDetail().obs;

  ///RDV OR ORIGINE GPS
  Rx<LatLng> departGps = LatLng(0, 0).obs;
  Rx<LatLng> arriveeGps = LatLng(0, 0).obs;
  final detailDestination = PlaceDetail().obs;
  final destinationLibelle = PlaceDetail().obs;

  ///CHOISIR PLACE DESTINATION
  final propositionsList = <RechercheEvaluation>[].obs;
  final maCommande = Commande().obs;

  final isOrigineNotEmpty = false.obs;
  final isDestinationNotEmpty = false.obs;
  final isOriginetaped = false.obs;
  final proposition_id = 0.obs;
  final proposition = RechercheEvaluation().obs;
  RxBool isWaiting = false.obs;
  RxBool isDriving = false.obs;
  @override
  void onInit() {
    departGps.value = LatLng(ctlHome.user.value.gpsLatitude ?? 0,
        ctlHome.user.value.gpsLongitude ?? 0);
    destinationTC.text = '';
    departTC.text = '';
    arriveeTC.text = '';
    super.onInit();
  }

  @override
  void onReady() {
    /*  lat: ctlHome.currentPosition.value.latitude,
      lng: ctlHome.currentPosition.value.latitude, */
    detailOigine.value = PlaceDetail(
        geometry: Geometry(
            location: Location(
      lat: ctlMapCourse.pointActuelle.value.latitude,
      lng: ctlMapCourse.pointActuelle.value.longitude,
    )));
    super.onReady();
  }

  @override
  void onClose() {}

  ///SUGGERER PLACES ORIGINE
  Future suggererOriginePlaces() async {
    originePlaceList.value = await provGplaces.getSuggestion(
        input: origineTC.text, lang: ctlHome.defaultLanguage.value);
  }

  ///SUGGERER PLACES DESTINATION
  Future suggererDestinationPlaces() async {
    destinationPlaceList.value = await provGplaces.getSuggestion(
        input: destinationTC.text.trim(), lang: ctlHome.defaultLanguage.value);
  }

  ///PROPOSER COURSES
  Future<List<RechercheEvaluation>> postRechercheEvaluationToApi({
    required client_id,
    required origine_libelle,
    required longitude,
    required latitude,
    required dest_libelle,
    required dest_longitude,
    required dest_latitude,
    required duree,
    required distance,
  }) async {
    assert(duree != null && distance != null);
    int temps;
    double dist;
    // temps = convertDureeToNumric(duree: duree);
    // dist = convertDistanceToNumric(distance: distance);
    print("DIRDIST ${(duree / 60).ceil()}");
    print("DIRDIST ${distance / 1000}");
    temps = (duree / 60).ceil();
    dist = distance / 1000;

    propositionsList.value = await provProposition.postRechercheEvaluation(
      client_id: client_id ?? 0,
      longitude: longitude,
      latitude: latitude,
      origine_libelle: origine_libelle.toString().length > 255
          ? origine_libelle.toString().substring(0, 255)
          : origine_libelle,
      dest_libelle: dest_libelle.toString().length > 255
          ? dest_libelle.toString().substring(0, 255)
          : dest_libelle,
      dest_longitude: dest_longitude,
      dest_latitude: dest_latitude,
      duree: temps,
      distance: dist,
    );

    return propositionsList;
  }

  ///ENVOYER COMMANDE
  Future<String> passerCommandeToApi() async {
    var resultat = await provCommande.postCommande(
        proposition_id: proposition_id.value,
        client_id: ctlHome.user.value.id ?? 50);
    checkCommandStatus();

    ctlMapCourse.addDestinationmarker(LatLng(
      ctlMapCourse.distMatrix.value.destination!.latitude!.toDouble(),
      ctlMapCourse.distMatrix.value.destination!.longitude!.toDouble(),
    ));
    ctlMapCourse.addRdvmarker(LatLng(
      ctlMapCourse.distMatrix.value.origin!.latitude!.toDouble(),
      ctlMapCourse.distMatrix.value.origin!.longitude!.toDouble(),
    ));
    return resultat;
  }

  ///RECEVOIR COMMANDE
  Future<Commande> recevoirCommande() async {
    var resultat = await provCommande.getCommande(
        proposition_id_saisir: proposition_id.value,
        commande_id: maCommande.value.id ?? 0);
    printInfo(
        info:
            "CHAUFFEUR========================>${maCommande.value.gpsLat}, ${maCommande.value.gpsLon}");
    if (resultat.isNotEmpty) {
      if (resultat.isNotEmpty &&
          resultat[0].status != CMDSTATUS.COMMAND_ANNULEE) {
        ctlMapCourse.statuscommand.value =
            renvoyerStatusCommande(resultat[0].status!.toInt());
        maCommande.value = resultat[0];

        ///ACTUALISER MARKERS
        if (resultat[0].status != CMDSTATUS.COMMAND_EMPTY &&
            resultat[0].status != CMDSTATUS.COMMAND_TRAITEMENT &&
            resultat[0].status != CMDSTATUS.COMMAND_ANNULEE) {
          ctlMapCourse.addDrivermarker(LatLng(
              double.parse(maCommande.value.driverLat.toString()),
              double.parse(maCommande.value.driverLong.toString())));

          ///CHANGEMENT DE TRAJET
          if (resultat[0].status == CMDSTATUS.COMMAND_ACCEPTEE &&
              isWaiting.value == false) {
            ctlMapCourse.dessinierTrajet(
                origine: PointLatLng(
                    double.parse(maCommande.value.driverLat.toString()),
                    double.parse(maCommande.value.driverLong.toString())),
                destination: PointLatLng(
                    double.parse(maCommande.value.rdvLat.toString()),
                    double.parse(maCommande.value.rdvLong.toString())),
                color: AppColor.CBLUE);
            if (isWaiting.value == false) {
              isWaiting.value = true;
            }
          } else if (resultat[0].status == CMDSTATUS.COMMAND_COMMENCEE ||
              resultat[0].status == CMDSTATUS.COMMAND_PAIEMENT &&
                  isDriving.value == false) {
            ctlMapCourse.dessinierTrajet(
                origine: PointLatLng(
                    double.parse(maCommande.value.rdvLat.toString()),
                    double.parse(maCommande.value.rdvLong.toString())),
                destination: PointLatLng(
                    double.parse(maCommande.value.destLat.toString()),
                    double.parse(maCommande.value.destLong.toString())),
                color: AppColor.CGREEN);
            if (isDriving.value == false) {
              isDriving.value = true;
            }
          } else {
            // ctlMapCourse.markers.clear();
            ctlMapCourse.polylines.clear();
          }
        }
      } else {
        ctlHome.reinitialiserTout();
      }

      ctlMapCourse.actualiserMarkerCourse();
      if (ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_TERMINEE) {
        if (ctlNote.isNoted.value == true) {
          ctlHome.reinitialiserTout();
        } else {
          await ctlNote.getNotationFromApi();
          Get.to(() => NoteExpandView());
        }
      }
      if (ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_ANNULEE) {
        ctlHome.reinitialiserTout();
      }
      if (ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_PAIEMENT) {
        Paiement _paiement = await provPaiement.getPaiement(
            commande_id: ctlRecherche.maCommande.value.id as int);

        if (_paiement.lien != null && _paiement.lien != "") {
          ctlHome.urlpaiement.value = _paiement.lien.toString();
        }
      }
      if (resultat != null &&
          resultat.isNotEmpty &&
          resultat[0].status == CMDSTATUS.COMMAND_ACCEPTEE &&
          resultat[0].driverId != 0 &&
          resultat[0].immatriculation != "") {
        ctlMapCourse.rdvDistanceMatrix(
            LatLng(double.parse(maCommande.value.driverLat.toString()),
                double.parse(maCommande.value.driverLong.toString())),
            LatLng(double.parse(maCommande.value.rdvLat.toString()),
                double.parse(maCommande.value.rdvLong.toString())));
      } else if (resultat != null &&
          resultat.isNotEmpty &&
          resultat[0].status == CMDSTATUS.COMMAND_COMMENCEE) {
        ctlMapCourse.drivingDistanceMatrix(
            LatLng(double.parse(maCommande.value.driverLat.toString()),
                double.parse(maCommande.value.driverLong.toString())),
            LatLng(double.parse(maCommande.value.destLat.toString()),
                double.parse(maCommande.value.destLong.toString())));
      }
    }
    return maCommande.value;
  }

  changerZoomMap(int status) {
    switch (status) {
      case CMDSTATUS.COMMAND_TRAITEMENT:
        ctlMapCourse.zoom.value = 18.0;
        break;
      case CMDSTATUS.COMMAND_ACCEPTEE:
        ctlMapCourse.zoom.value = 18.0;
        break;
      case CMDSTATUS.COMMAND_COMMENCEE:
        ctlMapCourse.zoom.value = 17.0;
        break;
      default:
        ctlMapCourse.zoom.value = 16.0;
    }
  }

  int renvoyerStatusCommande(int id) {
    int _status = 1000;
    switch (id) {
      case 0:
        _status = CMDSTATUS.COMMAND_EMPTY;
        break;
      case 1:
        _status = CMDSTATUS.COMMAND_TRAITEMENT;
        break;
      case 2:
        _status = CMDSTATUS.COMMAND_ANNULEE;
        break;
      case 3:
        _status = CMDSTATUS.COMMAND_ACCEPTEE;
        break;
      case 4:
        _status = CMDSTATUS.COMMAND_COMMENCEE;
        break;
      case 5:
        _status = CMDSTATUS.COMMAND_PAIEMENT;
        break;
      case 6:
        _status = CMDSTATUS.COMMAND_TERMINEE;
        break;
      default:
        _status = CMDSTATUS.COMMAND_TRAITEMENT;
    }

    return _status;
  }

  void courseannulee() {
    ctlMapCourse.statuscommand.value = CMDSTATUS.COMMAND_EMPTY;
  }
}
