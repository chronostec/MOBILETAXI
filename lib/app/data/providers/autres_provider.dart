import 'dart:convert';

import 'package:fredy_proprio/app/data/models/categorie_model.dart';
import 'package:fredy_proprio/app/data/models/objet_message_model.dart';
import 'package:fredy_proprio/app/utils/app_urls.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../models/message_support_model.dart';
import 'decoder_retour.dart';

class MessageSupportProvider extends GetConnect {
  Future<MessageSupport> postMessageSupport(
      {required proprio_id, required objetc, required contenu}) async {
    var url = APPURL.BASE_URL +
        APPURL.MESSAGE_SUPPORT_URL +
        "objet=$objetc&contenu=$contenu&client_id=$proprio_id";
    var _res = MessageSupport();
    final response = await http.post(Uri.parse(url));
    // print(response.body);
    _res = parseMessageSupport(response.body);
    return _res;
  }

  Future<List<ObjetMessage>> getObjetMessage() async {
    var url = APPURL.BASE_URL + APPURL.MESSAGE_OBJET_URL;
    var _res = <ObjetMessage>[];
    final response = await http.get(Uri.parse(url));
    // print(response.body);
    _res = parseObjetMessages(response.body);
    return _res;
  }
}

class Categorieprovider {
    Future<List<Categorie>> getCategorie() async {
    var url = APPURL.BASE_URL + APPURL.GET_CATEGORIE;
    final response = await http.get(Uri.parse(url));
    // print(response.body);
    return  parseCategories(response.body);
  }
}