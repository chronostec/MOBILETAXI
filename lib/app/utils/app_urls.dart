class MAPSURL {
  static const MAP_PLACE_URL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const MAP_PLACE_ID_URL =
      'https://maps.googleapis.com/maps/api/place/details/json';

  static const MAP_DESTINATION_URL =
      'https://maps.googleapis.com/maps/api/distancematrix/json';
}

class APPURL {
  ///`BASE URL`
  // static const BASE_URL = "http://192.168.1.5:8000/api/";
  // static const BASE_URL = "http://192.168.1.102:8000/api/";
  static const BASE_URL = "http://160.238.36.155/api/";

  ///`MESSAGE`
  static const MESSAGE_SUPPORT_URL = "messageSupport?";
  static const MESSAGE_OBJET_URL = "getObjet?";

  ///`LOGIN`
  static const GET_DRIVER_INFO = "postLoginDriverInfo?";
  static const PUT_DRIVER_GPS = "vehiculePosition?";
  static const PUT_DRIVER_POSITION = "setPostion?";

  ///`ECHANGES`
  static const POST_DRIVER_ECRIRE = "driverEcrireMessage?";
  static const GET_DRIVER_LIRE = "getEchangeMessage?";

  ///` COMMANDE`
  static const PUT_MANAGER_CMDE = "postManagerCommande?";
  static const GET_LISTER_CMDE = "getListerCommandeDisponible?";
  static const GET_DETAIL_CMDE = "getDetailCommande?";
  static const GET_DETAIL_CMDE_ACCEPTEE = "getCommandeAccepter?";

  ///`HISTOIQUE`
  static const GET_HISTORIQUE = "driverGetHistorique?";

  ///`PAIEMENT`
  static const POST_ESPECE = "paiement?";
  static const GET_ESPECE = "recuperationInfoPaiement?";
}
