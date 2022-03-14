import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/proprio_model.dart';

class LocalStorage extends GetxController {
  final box = GetStorage();
  static const String tableName = "proprio_user_data";

  ///`READ USER DATA FROM LOCAL STORAGE AND RETURN`
  ///`IF NOT EMPTY ELSE CLEAR USER`
  Future<Proprio> readUserData() async {
    var currentUser = Proprio();
    if (box.read("proprio_user_data") != null) {
       print("READING CURRENT USER....}");
      final data = box.read("proprio_user_data") as Map<String, dynamic>;

      currentUser = Proprio(
        id: data['id'] ?? 0,
        nom: data['nom'] ?? '',
        prenom: data['prenom'] ?? '',
        telephone: data['telephone'] ?? '',
        email: data['email'] ?? '',
        password: data['password'] ?? '',
        status: data['status'] ?? '',
        // urlien: data['urlien'] ?? '',
      );
    } else {
      currentUser = Proprio(id: null);
    }
    print("CURRENT USER: ${currentUser.toJson()}");
    return currentUser;
  }

  ///`SAVE USER DATA INTO LOCAL STORAGE`
  Future saveUserData(Proprio model) async {
    box.write(
      "proprio_user_data",
      {
        "id": model.id,
        "nom": model.nom ,
        "prenom": model.prenom ,
        "telephone": model.telephone ,
        "password": model.password ,
        "email": model.email,
        "status": model.status,
        // "urlien": model.urlien ?? 0,
      },
    );
    await readUserData();
  }

  ///`SAVE USER DATA INTO LOCAL STORAGE`
  Future eraseUserData() async {
    box.write(
      tableName,
      {
        "id": 0,
        "nom": '',
        "prenom": '',
        "telephone": '',
        "password": '',
        "email": '',
        "status": 0,
        // "urlien": model.urlien ?? 0,
      },
    );
    await readUserData();
  }

  @override
  void onInit() {
    readUserData();
    super.onInit();
  }
}
