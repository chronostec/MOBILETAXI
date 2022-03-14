class URLS {
  static const BASE_URL = "http://192.168.1.102:8000/api/";

  static const MAP_PLACE_URL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const MAP_PLACE_ID_URL =
      'https://maps.googleapis.com/maps/api/place/details/json';

  static const MAP_DISTANCEMATRIX_URL =
      'https://maps.googleapis.com/maps/api/distancematrix/json';

  ///`VEHICULE`
  static const GET_VEHICULE_PROXIMITE_URL = "getVehiculesLibre?";

  ///`COMMANDE`
  static const ENREGISTRER_COMMANDE_URL = "enregistrerCommande?";
  static const RECHERCHE_EVALUATION_URL = "rechercheEvaluation?";
  static const RECUP_DRIVER_URL = "getInformationCommande?";

  ///`ANNULATION`
  static const ANNULATION_TAXI_URL = "annulationTaxi?";
  static const MOTIF_ANNULATION_URL = "getMotifAnnulation?";

  ///`NOTE`
  static const NOTE_URL = "listeNote?";
  static const NOTE_DETAIL_URL = "listeDetailsNote?";

  ///`ADRESSE`
  static const ADRESSE_URL = "getAdresse?";

  ///`PARTAGE`
  static const PARTAGE_URL = "partage?";

  ///`MESSAGE`
  static const MESSAGE_SUPPORT_URL = "messageSupport?";
  static const MESSAGE_OBJET_URL = "getObjet?";

  ///`NOTATION`
  static const NOTATION_URL = "getNotation?";
  // static const GET_VEHICULE_PROXIMITE_URL = "getVehiculesLibre?";

  ///`RECHERCHE`
  static const RECHERCHE_CLIENT_URL = "rechercheClient?";

  ///`TRAJET`
  static const HISTORIQUE_TRAJET_URL = "historiqueTrajet?";

  ///`LOGIN`
  static const LOGIN_URL = "login?";
}
