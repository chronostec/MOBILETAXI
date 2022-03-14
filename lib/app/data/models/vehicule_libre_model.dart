class VehiculeLibre {
  var immatriculation;
  var longitude;
  var latitude;
  var distanceInKm;

  VehiculeLibre(
      {this.immatriculation, this.longitude, this.latitude, this.distanceInKm});

  VehiculeLibre.fromJson(Map<String, dynamic> json) {
    immatriculation = json['immatriculation'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    distanceInKm = json['distance_in_km'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['immatriculation'] = immatriculation;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['distance_in_km'] = distanceInKm;
    return data;
  }
}
