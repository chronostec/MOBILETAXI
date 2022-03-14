class Adresse {
  String? street;
  String? subLocality;
  String? locality;
  String? postalCode;
  String? country;

  Adresse(
      {this.street,
      this.subLocality,
      this.locality,
      this.postalCode,
      this.country});

  Adresse.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    subLocality = json['subLocality'];
    locality = json['locality'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['street'] = street;
    data['subLocality'] = subLocality;
    data['locality'] = locality;
    data['postalCode'] = postalCode;
    data['country'] = country;
    return data;
  }
}
