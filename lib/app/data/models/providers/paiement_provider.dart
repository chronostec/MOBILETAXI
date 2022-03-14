import 'package:get/get.dart';

import '../paiement_model.dart';

class PaiementProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Paiement.fromJson(map);
      if (map is List)
        return map.map((item) => Paiement.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Paiement?> getPaiement(int id) async {
    final response = await get('paiement/$id');
    return response.body;
  }

  Future<Response<Paiement>> postPaiement(Paiement paiement) async =>
      await post('paiement', paiement);
  Future<Response> deletePaiement(int id) async => await delete('paiement/$id');
}
