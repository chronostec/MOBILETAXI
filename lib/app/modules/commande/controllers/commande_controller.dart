import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/commandes_model.dart';
import 'package:alfred_taxi_driver/app/data/models/partage_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart';
import 'package:alfred_taxi_driver/app/data/services/local_storage.dart';
import 'package:alfred_taxi_driver/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_driver/app/modules/chatbox/views/chatbox_view.dart';
import 'package:alfred_taxi_driver/app/modules/commande/views/commande_driving_view.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:url_launcher/url_launcher.dart';

class CommandeController extends GetxController {
  final commande = Commande().obs;

  /////////////////////////////////////////////////////////////
  Rx<Commandes> listCommande = Commandes().obs;

  RxInt statuscommand = 1000.obs;
  RxBool FINCOURSE = false.obs;
  RxBool PAIEMENTCOURSE = false.obs;
  RxBool DETAILLER_COMMANDE = false.obs;
  RxBool isGetting = false.obs;
  RxBool isPosting = false.obs;
  RxBool isRequesting = false.obs;

  var mapStyle = "".obs;
  RxBool DIALOGSTATUS = false.obs;
  RxBool isHours = true.obs;

  @override
  void onInit() {
    DIALOGSTATUS.value = false;

    super.onInit();
  }

  @override
  void onReady() {
    checkCommandedisponiblePeriodicEvent();

    super.onReady();
  }

  @override
  void onClose() {}

  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) {
      // print('CHRONOMETRE===> ${value.hours}');
    },
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  ///`LISTE COMMANDES`
  Future getCommandeDisponible() async {
    var _res =
        await proCommande.getCommande(driver_id: ctlHome.driver.value.id ?? 0);
    printInfo(info: "COMMANDE EN COURS ${_res.commande!.length}");
    if (_res.commande != null && _res.commande!.isNotEmpty) {
      listCommande.value = _res;
    }
    listCommande.value = _res;
  }

  ///`DETAIL COMMAND`
  Future<bool> getDetailCommande() async {
    bool _isOk = false;
    var _resultat = await proCommande.getCommandeDetail(
        cmde_id: commande.value.id, driver_id: ctlHome.driver.value.id ?? 0);

    if (_resultat.commande != null && _resultat.commande!.isNotEmpty) {
      commande.value = _resultat.commande![0];
      changeZoom(_resultat.commande![0].status as int);
      _isOk = true;
    } else {
      // commande.value = Commande();
      _isOk = false;
    }
    await LocalStorage().saveCurrentCmde(commande.value);
    await LocalStorage().saveCurrentCmde(commande.value);
    return _isOk;
  }

  ///`DETAIL COMMAND`
  Future<bool> getDetailCommandeAcceptee() async {
    bool _isOk = false;
    var _resultat = await proCommande.getCommandeDetailAcceptee(
        cmde_id: commande.value.id, driver_id: ctlHome.driver.value.id);

    if (_resultat.commande!.isNotEmpty) {
      commande.value = _resultat.commande![0];
      _isOk = true;
    } else {
      // commande.value = Commande();
      _isOk = false;
    }
    await LocalStorage().saveCurrentCmde(commande.value);
    return _isOk;
  }

  changeStatus(int value) => statuscommand.value = value;

  Future<dynamic> showEchangeDialogFunction(BuildContext context) {
    return showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ChatboxView(),
    );
  }

  ///`MANAGER LA COURSE EN CHANGEANT LE STATUS 0,1,2,3...`
  Future managerCourse(String action, {context}) async {
    await executerAction(action, context: context);
  }

  Future executerAction(String action, {context}) async {
    switch (action.toLowerCase()) {
      case KEYWORD.APPELER:
        launch('tel://${ctlcommande.commande.value.clientTelephone}');
        break;
      case KEYWORD.ECHANGER:
        ctlcommande.showEchangeDialogFunction(context);
        break;
      case KEYWORD.ACCEPTER:
        showEndedCoursetDialog(context: context);
        accepterCourse();
        break;
      case KEYWORD.ANNULER:
        showEndedCoursetDialog(context: context);
        annulerCourse();
        break;
      case KEYWORD.COMMENCER:
        showEndedCoursetDialog(context: context);
        commencerCourse();

        break;
      case KEYWORD.TERMINER:
        // showEndedCoursetDialog(context: context);
        terminerCourse();
        break;
      case KEYWORD.PAYER:
        statuscommand.value = CMDSTATUS.COMMAND_PAIEMENT;

        break;
      default:
    }
  }

  /// ACCEPTER COMMANDE
  accepterCourse() async {
    await postManagerCmde(
            driver_id: ctlHome.driver.value.id as int,
            cmde_id: commande.value.id as int,
            status: CMDSTATUS.COMMAND_ACCEPTEE)
        .then((value) {
      if (value.bSuccess) {
        statuscommand.value = CMDSTATUS.COMMAND_ACCEPTEE;
        ctlcommande.stopWatchTimer.onExecute.add(StopWatchExecute.reset);
        ctlcommande.stopWatchTimer.onExecute.add(StopWatchExecute.start);
        ctlcommande.DETAILLER_COMMANDE.value = false;

        if (ctlcommande.statuscommand.value == CMDSTATUS.COMMAND_ACCEPTEE &&
            ctlHome.isWaiting.value == false) {
          ctlDrivermap.getPolyline(
            destination: LatLng(
              ctlcommande.commande.value.clientLatitude!.toDouble(),
              ctlcommande.commande.value.clientLongitude!.toDouble(),
            ),
            color: AppColors.DGREENLIGHT,
          );

          if (ctlHome.isWaiting.value == false) {
            ctlHome.isWaiting.value = true;
          }
        }

        updateDriverPositionRemaingDistMatrix();
        Get.off(() => const CommandeDrivingView());
      } else {
        Get.snackbar("ACCEPTATION COMMANDE",
            "Quelque chose de s'est mal passé, veuillez recommencer svp !");
      }
    });
  }

  /// COMMENCER COURSE
  commencerCourse() async {
    await postManagerCmde(
            driver_id: ctlHome.driver.value.id as int,
            cmde_id: commande.value.id!.toInt(),
            status: CMDSTATUS.COMMAND_COMMENCEE)
        .then((value) {
      if (value.bSuccess) {
        statuscommand.value = CMDSTATUS.COMMAND_COMMENCEE;
        ctlcommande.stopWatchTimer.onExecute.add(StopWatchExecute.reset);
        ctlcommande.stopWatchTimer.onExecute.add(StopWatchExecute.start);

        if ((ctlcommande.statuscommand.value == CMDSTATUS.COMMAND_COMMENCEE ||
                ctlcommande.statuscommand.value ==
                    CMDSTATUS.COMMAND_PAIEMENT) &&
            ctlHome.isDriving.value == false) {
          ctlDrivermap.getPolyline(
            destination: LatLng(
              ctlcommande.commande.value.destLatitude!.toDouble(),
              ctlcommande.commande.value.destLongitude!.toDouble(),
            ),
            color: AppColors.DORANGE1,
          );
          if (ctlHome.isDriving.value == false) {
            ctlHome.isDriving.value = true;
          }
        }

        Get.back();
      } else {
        Get.snackbar("COMMENCER COURSE",
            "Quelque chose de s'est mal passé, veuillez recommencer svp !");
      }
      updateDriverPositionRemaingDistMatrix();
    });
  }

  /// ANNULER COURSE
  annulerCourse() async {
    await postManagerCmde(
            driver_id: ctlHome.driver.value.id ?? 0,
            cmde_id: commande.value.id ?? 0,
            status: CMDSTATUS.COMMAND_ANNULEE)
        .then((value) {
      if (value.bSuccess) {
        ctlHome.rebaseCommandes().then((value) => Get.back());
      } else {
        Get.snackbar("ANNULER COURSE",
            "Quelque chose de s'est mal passé, veuillez recommencer svp !");
      }
    });
  }

  /// ANNULER COURSE
  refuserCourse() async {
    await proCommande
        .putRefuserCommande(
            commande_id_saisir: commande.value.id ?? 0,
            chauffeur_id_saisir: ctlHome.driver.value.id ?? 0)
        .then((value) {
      if (value.bSuccess) {
        ctlHome.rebaseCommandes();
      } else {
        Get.snackbar("REFUSER COURSE",
            "Quelque chose de s'est mal passé, veuillez recommencer svp !");
      }
    });
  }

  /// EFFECTUER PAIEMENT EN ESPECE
  Future<Resultat> paiementEspeceCourse(BuildContext context) async {
    isRequesting.value = true;

    Resultat _res =
        await proPaiement.postPaiement(commande_id: commande.value.id!.toInt());

    return _res;
    //     await proPaiement.postPaiement(commande_id: commande.value.id!.toInt());
  }

  /// TERMINER COURSE
  terminerCourse() async {
    Resultat _res = await postManagerCmde(
        driver_id: ctlHome.driver.value.id as int,
        cmde_id: commande.value.id!.toInt(),
        status: CMDSTATUS.COMMAND_TERMINEE);

    if (_res.bSuccess) {
      ctlHome.rebaseCommandes();
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar("TERMINER COURSE",
          "Quelque chose de s'est mal passé, veuillez recommencer svp !");
    }
  }

  Future procederAuPaiment() async {
    isRequesting.value = true;
    Resultat _res = await postManagerCmde(
        driver_id: ctlHome.driver.value.id as int,
        cmde_id: commande.value.id!.toInt(),
        status: CMDSTATUS.COMMAND_PAIEMENT);
    isRequesting.value = false;
    return _res;
  }

  Future<Resultat> postManagerCmde(
      {required int driver_id,
      required int cmde_id,
      required int status}) async {
    Resultat res = await proCommande.putManagerCommande(
        status: status, cmde_id: cmde_id, driver_id: driver_id);
    return res;
  }

  /// SHOW AWAIT DIALOG
  showEndedCoursetDialog({
    required context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 25.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                "Patientez svp",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 4,
                ),
              ),
              Center(
                child: SpinKitDualRing(
                  color: AppColors.DRED1,
                  lineWidth: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeZoom(int status) {
    switch (status) {
      case CMDSTATUS.COMMAND_EMPTY:
        ctlHome.testZoom.value = 15;
        break;
      case CMDSTATUS.COMMAND_ACCEPTEE:
        ctlHome.testZoom.value = 17;
        break;
      case CMDSTATUS.COMMAND_COMMENCEE:
        ctlHome.testZoom.value = 19;
        break;
      case CMDSTATUS.COMMAND_TRAITEMENT:
        ctlHome.testZoom.value = 14;
        break;
      case CMDSTATUS.COMMAND_PAIEMENT:
        ctlHome.testZoom.value = 19;
        break;
      default:
        ctlHome.testZoom.value = 15;
    }
  }
}
