import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/notes_model.dart';
import 'package:alfred_taxi_client/app/data/models/partage_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotesProvider extends GetConnect {
  Future<Partage> postNotes({
    required note_id,
    required libelle,
    required client_id,
    required commande_id,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.NOTE_CLIENT_URL +
        "note_id=$note_id&libelle=$libelle&client_id=$client_id&commande_id=$commande_id";
    var _res = Partage();

    final response = await http.post(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      _res = parsePartages(response.body);
    } else {
      throw Exception('Failed to load predictions');
    }

    return _res;
  }

  Partage parsePartages(responseBody) {
    final parsed = json.decode(responseBody);

    return Partage.fromJson(parsed);
  }

  Future<List<Notes>> getNotes({
    required client_id,
  }) async {
    var url = APPURL.BASE_URL + APPURL.NOTATIONS_URL;

    var _list = <Notes>[];

    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      _list = parseNotess(response.body);
    }
    return _list;
  }

  List<Notes> parseNotess(responseBody) {
    final parsed =
        json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

    return parsed.map<Notes>((json) => Notes.fromJson(json)).toList();
  }
}
