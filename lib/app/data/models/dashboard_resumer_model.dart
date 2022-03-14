class DashboardResumer {
  int? montantJour;
  int? courseJour;
  int? apercevoir;
  int? areverser;
  int? nombreDriver;
  int? nombreVehicule;
  int? nombreVehculeActif;

  DashboardResumer(
      {this.montantJour,
      this.courseJour,
      this.apercevoir,
      this.areverser,
      this.nombreDriver,
      this.nombreVehicule,
      this.nombreVehculeActif});

  DashboardResumer.fromJson(Map<String, dynamic> json) {
    montantJour = json['montant_jour'];
    courseJour = json['course_jour'];
    apercevoir = json['apercevoir'];
    areverser = json['areverser'];
    nombreDriver = json['nombre_driver'];
    nombreVehicule = json['nombre_vehicule'];
    nombreVehculeActif = json['nombre_vehcule_actif'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['montant_jour'] = montantJour;
    data['course_jour'] = courseJour;
    data['apercevoir'] = apercevoir;
    data['areverser'] = areverser;
    data['nombre_driver'] = nombreDriver;
    data['nombre_vehicule'] = nombreVehicule;
    data['nombre_vehcule_actif'] = nombreVehculeActif;
    return data;
  }
}
