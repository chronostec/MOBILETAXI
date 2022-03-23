class Reversement {
  bool? bSuccess;
  String? message;
  String? versementUrl;

  Reversement({this.bSuccess, this.message, this.versementUrl});

  Reversement.fromJson(Map<String, dynamic> json) {
    bSuccess = json['bSuccess'];
    message = json['message'];
    versementUrl = json['versement_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bSuccess'] = bSuccess;
    data['message'] = message;
    data['versement_url'] = versementUrl;
    return data;
  }
}
