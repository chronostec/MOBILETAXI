import 'package:get/get.dart';

import '../resume_test_model.dart';

class ResumeTestProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return ResumeTest.fromJson(map);
      if (map is List)
        return map.map((item) => ResumeTest.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<ResumeTest?> getResumeTest(int id) async {
    final response = await get('resumetest/$id');
    return response.body;
  }

  Future<Response<ResumeTest>> postResumeTest(ResumeTest resumetest) async =>
      await post('resumetest', resumetest);
  Future<Response> deleteResumeTest(int id) async =>
      await delete('resumetest/$id');
}
