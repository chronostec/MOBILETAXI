import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/data/models/notes_model.dart';
import 'package:alfred_taxi_client/app/data/models/partage_model.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final noteIndex = 0.obs;
  final groupvalue = 0.obs;
  final currentNote = "".obs;
  final cmdId = 0.obs;

  final isGettingNote = false.obs;
  final isSendingNote = false.obs;
final isNoted = false.obs;
  /// NOTE IMAGE
  var noteimage = [
    "assets/images/emoji_tres_satisfait.jpg",
    "assets/images/emoji_satisfait.jpg",
    "assets/images/emoji_angry.jpg",
    "assets/images/emoji_tres_satisfait.jpg",
    "assets/images/emoji_satisfait.jpg",
    "assets/images/emoji_angry.jpg",
    "assets/images/emoji_tres_satisfait.jpg",
    "assets/images/emoji_satisfait.jpg",
    "assets/images/emoji_angry.jpg",
  ].obs;

  /// NOTEs LIST
  var noteList = <Notes>[
    // Notes(
    //   id: 1,
    //   libelle: "Tres Satisfait",
    //   details: [
    //     Details(
    //       iD: 1,
    //       noteId: 1,
    //       libelle: "Très satisfait",
    //     ),
    //   ],
    // ),
    // Notes(
    //   id: 2,
    //   libelle: "Moins",
    //   details: [
    //     Details(
    //       iD: 2,
    //       noteId: 2,
    //       libelle: "Passable",
    //     ),
    //   ],
    // ),
    // Notes(
    //   id: 3,
    //   libelle: "Deçu",
    //   details: [
    //     Details(
    //       iD: 3,
    //       noteId: 3,
    //       libelle: "Chauffeur désagréable",
    //     ),
    //     Details(
    //       iD: 4,
    //       noteId: 3,
    //       libelle: "Véhicule inconfortable",
    //     ),
    //   ],
    // ),
  ].obs;

  @override
  void onInit() {
    // getNotationFromApi();
    super.onInit();
  }

  @override
  void onReady() {
    getNotationFromApi();
    super.onReady();
  }

  @override
  void onClose() {}

  changeGroupValue(value) {
    groupvalue.value = value;
  }

  Future<String> postNotationsToApi() async {
    isSendingNote.value = true;

    Partage result = await provNote.postNotes(
      note_id: groupvalue.value,
      libelle: currentNote.value,
      client_id: ctlHome.user.value.id,
      commande_id: ctlRecherche.maCommande.value.id,
    );

    isSendingNote.value = false;
    return result.message.toString();
  }

  Future<List<Notes>> getNotationFromApi() async {
    isGettingNote.value = true;
    noteList.value = await provNote.getNotes(client_id: ctlHome.user.value.id);
    isGettingNote.value = false;
    return noteList;
  }
}
