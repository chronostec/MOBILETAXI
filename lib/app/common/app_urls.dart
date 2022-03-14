class MAPSURL {
  static const MAP_PLACE_URL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const MAP_PLACE_ID_URL =
      'https://maps.googleapis.com/maps/api/place/details/json';

  static const MAP_DISTANCEMATRIX_URL =
      'https://maps.googleapis.com/maps/api/distancematrix/json';
}

class APPURL {
  // static const BASE_URL = "http://192.168.1.5:8000/api/";
  // static const BASE_URL = "http://192.168.1.102:8000/api/";
  static const BASE_URL = "http://160.238.36.155/api/";

  ///`VEHICULE`
  static const GET_VEHICULE_PROXIMITE_URL = "getVehiculesLibre?";

  ///`COMMANDE`
  static const ENREGISTRER_COMMANDE_URL = "enregistrerCommande?";
  static const RECHERCHE_EVALUATION_URL = "rechercheEvaluation_post?";
  static const RECUP_DRIVER_URL = "getInformationCommande?";

  ///`ANNULATION`
  static const ANNULATION_TAXI_URL = "annulationTaxi?";
  static const MOTIF_ANNULATION_URL = "getMotifAnnulation?";

  ///`NOTE`
  static const NOTE_CLIENT_URL = "InsertNoteDetail?";
  static const NOTATIONS_URL = "listeNote?";

  ///`ADRESSE`
  static const ADRESSE_URL = "getAdresse?";

  ///`PARTAGE`
  static const PARTAGE_URL = "partage?";

  ///`MESSAGE`
  static const MESSAGE_SUPPORT_URL = "messageSupport?";
  static const MESSAGE_OBJET_URL = "getObjet?";

  ///`RECHERCHE`
  static const RECHERCHE_CLIENT_URL = "rechercheClient?";

  ///`TRAJET`
  static const HISTORIQUE_TRAJET_URL = "historiqueTrajet?";

  ///`ECHANGES`
  static const POST_CLIENT_ECRIRE = "clientEcrireMessage?";
  static const GET_CLIENT_LIRE = "getEchangeMessage?";

  ///`PAIEMENT`
  static const PAIEMENT_URL = "recuperationInfoPaiement?";

  ///`LOGIN`
  static const LOGIN_PHONE_URL = "set_soumettre_contact?";
  static const LOGIN_OTP_URL = "updateOtp?";
}
