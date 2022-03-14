class Retour {
  bool? bSuccess;
  String? message;

  Retour({this.bSuccess, this.message});

  Retour.fromJson(Map<String, dynamic> json) {
    bSuccess = json['bSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bSuccess'] = bSuccess;
    data['message'] = message;
    return data;
  }
}
