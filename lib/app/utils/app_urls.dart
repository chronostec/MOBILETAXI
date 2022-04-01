class APPURL {
  ///`BASE URL`
  // static const BASE_URL = "http://192.168.1.5:8000/api/";
  // static const BASE_URL = "http://192.168.1.102:8000/api/";

  static const BASE_URL = "http://160.238.36.155/api/";

  ///`MESSAGE`
  static const MESSAGE_SUPPORT_URL = "messageSupport?";
  static const MESSAGE_OBJET_URL = "getObjet?";

  ///`CATEGORIE`
  static const GET_CATEGORIE = "GetListerCategorie";

  ///`AUTHENTIFICATION`
  static const POST_INSCRIPTION = "PostInscription?";
  static const GET_OLD_PASSWORD = "GetOlpassword?";
  static const PUT_NEW_PASSWORD = "PutNewPassword?";
  static const GET_CONNEXION = "GetConnexion?";

  ///`DASHBOARD`
  static const GET_DASHBOARD_RESUME = "GetDashboardResumer?";
  static const GET_RAPPORT_JOURNEE = "GetRapportJournee?";

  ///`FINANCE`
  static const GET_FINANCE_RESUME = "GetFinanceResume?";
  static const POST_REVERSEMENT = "ReversementProprio?";

  ///`DRIVER`
  static const GET_LISTER_DRIVERS = "GetListerDrivers?";
  static const GET_LISTER_HISTORIQUE_DRIVERS =
      "GetListeDriverHistoriqueCourse?";
  static const POST_DRIVER = "PostDriver?";
  static const PUT_DRIVER = "PutDriver?";
  static const PUT_ATTRIBUER_VEHICULE = "UpdateVehicule?";
  static const GET_VEHICULE_LIBRE = "VehiculeLibre?";

  ///`VEHICULE`
  static const GET_VEHICULE_RESUME = "GetVehiculeResume?";
  static const GET_LISTER_VEHICULE = "GetListerVehicules?";
  static const GET_VEHICULE_HISTORIQUE_COURSE =
      "GetListerVehiculeHistoriqueCourse?";
  static const POST_VEHICULE = "PostVehicule?";
  static const PUT_VEHICULE = "PutVehicule?";

  ///`RECHARGEMENT`
  static const GET_LIEN_RECHARGE = "getLienRechargementProprio?";
  static const GET_LISTER_HISTORIQUE_RECHARGE = "getListerHistoriqueOperation?";
}
