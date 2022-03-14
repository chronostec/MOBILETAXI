import 'package:fredy_proprio/app/data/models/resume_model.dart';
import 'package:get/get.dart';


class ResumeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Resume.fromJson(map);
      if (map is List) return map.map((item) => Resume.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Resume?> getResume(int id) async {
    final response = await get('resume/$id');
    return response.body;
  }

  Future<Response<Resume>> postResume(Resume resume) async =>
      await post('resume', resume);
  Future<Response> deleteResume(int id) async => await delete('resume/$id');
}
