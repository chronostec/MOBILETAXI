import 'package:get/get.dart';

import '../commande_model.dart';

class CommandeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Commande.fromJson(map);
      if (map is List)
        return map.map((item) => Commande.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Commande?> getCommande(int id) async {
    final response = await get('commande/$id');
    return response.body;
  }

  Future<Response<Commande>> postCommande(Commande commande) async =>
      await post('commande', commande);
  Future<Response> deleteCommande(int id) async => await delete('commande/$id');
}
