import 'package:alfred_taxi_client/app/data/models/historique_model.dart';
import 'package:alfred_taxi_client/app/modules/chatbox/controllers/chatbox_controller.dart';
import 'package:alfred_taxi_client/app/modules/history/controllers/history_controller.dart';
import 'package:alfred_taxi_client/app/modules/home/controllers/home_controller.dart';
import 'package:alfred_taxi_client/app/modules/login/controllers/login_controller.dart';
import 'package:alfred_taxi_client/app/modules/ma_course/controllers/annulation_controller.dart';
import 'package:alfred_taxi_client/app/modules/ma_course/controllers/ma_course_controller.dart';
import 'package:alfred_taxi_client/app/modules/ma_course/controllers/partage_controller.dart';
import 'package:alfred_taxi_client/app/modules/map_course/controllers/map_course_controller.dart';
import 'package:alfred_taxi_client/app/modules/note/controllers/note_controller.dart';
import 'package:alfred_taxi_client/app/modules/recherche/controllers/negociation_controller.dart';
import 'package:alfred_taxi_client/app/modules/recherche/controllers/recherche_controller.dart';
import 'package:alfred_taxi_client/app/modules/support/controllers/support_controller.dart';
import 'package:get/get.dart';

HomeController ctlHome = Get.put(HomeController());
LoginController ctlLogin = Get.put(LoginController());
RechercheController ctlRecherche = Get.put(RechercheController());
PartageController ctlPartage = Get.put(PartageController());
MapCourseController ctlMapCourse = Get.put(MapCourseController());
MaCourseController ctlMaCourse = Get.put(MaCourseController());
ChatboxController ctlEchange = Get.put(ChatboxController());
AnnulationController ctlAnnuler = Get.put(AnnulationController());
NoteController ctlNote = Get.put(NoteController());
HistoryController ctlHistorique = Get.put(HistoryController());
SupportController ctlSupport = Get.put(SupportController());
NegociationController ctlNegociation = Get.put(NegociationController());