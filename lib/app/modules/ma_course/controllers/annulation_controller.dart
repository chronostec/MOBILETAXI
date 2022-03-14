import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/data/models/motif_annulation_model.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart'
    show provAnnulation, provMotifAnnulation;
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AnnulationController extends GetxController {
  final is_annulation_requesting = false.obs;

  List<MotifAnnulation> motifList = <MotifAnnulation>[].obs;

  @override
  void onInit() {
    getMotifAnnulationtProviderFromApi();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<String> postAnnulationTaxToApi({
    required motif_id,
    required proposition_id,
  }) async {
    is_annulation_requesting.value = true;
    var resultat = await provAnnulation.postAnnulationTaxi(
        motif_id: motif_id, proposition_id: proposition_id);

    ctlMapCourse.statuscommand.value = CMDSTATUS.COMMAND_EMPTY;
    Get.back();
    ctlHome.reinitialiserTout();
    is_annulation_requesting.value = false;
    return resultat.message;
  }

  Future<List<MotifAnnulation>> getMotifAnnulationtProviderFromApi() async {
    motifList = await provMotifAnnulation.getMotifAnnulationt();
    is_annulation_requesting.value = false;
    return motifList;
  }
}
