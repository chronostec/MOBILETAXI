import 'package:alfred_taxi_client/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage extends GetxController {
  final box = GetStorage();
  var isAuth = false.obs;

  ///`READ USER DATA FROM LOCAL STORAGE AND RETURN`
  ///`USER IF NOT EMPTY ELSE EMPTY USER`
  Future<User> readUserData() async {
    var currentUser = User();
    if (box.read("mesabo_user_data") != null) {
      final data = box.read("mesabo_user_data") as Map<String, dynamic>;

      currentUser = User(
        id: data['id'],
        telephone: data['telephone'],
        status: data['status'],
        materiel: data['materiel'],
        gpsLatitude: data['latitude'],
        gpsLongitude: data['longitude'],
      );
    } else {
      currentUser = User(id: null);
    }
    print("CURRENT USER: ${currentUser.toJson()}");
    return currentUser;
  }

  ///`SAVE USER DATA INTO LOCAL STORAGE`
  Future saveUserData(User model) async {
    box.write(
      'mesabo_user_data',
      {
        "id": model.id,
        "telephone": model.telephone,
        "status": model.status,
        "materiel": model.materiel,
        "latitude": model.gpsLatitude,
        "longitude": model.gpsLongitude,
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
