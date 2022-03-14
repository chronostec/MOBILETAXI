import 'package:google_maps_flutter/google_maps_flutter.dart';

class MAPSKEY {
  static const String GMKEY = "AIzaSyC0FbHA9SZBofCJ1H98ifZe90XcmHc_iU0";
}

class MAPSMARKERS {
  static const MarkerId driverMarkerId = MarkerId("origin");
  static const MarkerId rdvMarkerId = MarkerId("rdv");
  static const MarkerId destinationMarkerId = MarkerId("destination");
}

class KEYWORD {
  static const String YES = "yes";
  static const String NO = "no";
  static const String ACCEPTER = "accepter";
  static const String REFUSER = "refuser";
  static const String REVENIR = "revenir";
  static const String COMMENCER = "commencer";
  static const String RECUPERER = "recuperer";
  static const String APPELER = "appeler";
  static const String TERMINER = "terminer";
  static const String ECHANGER = "echanger";
  static const String ANNULER = "annuler";
  static const String ESPECE = "espece";
  static const String ELECTRONIQUE = "electronique";
  static const String QUITTER = "quitter";
  static const String PAYER = "payer";
}

/* class STATUS {
  ///`status: 1000 --> aucune commande`
  static const int COMMAND_EMPTY = 1000;

  ///`status: 0 --> commande en cours de traitement`
  static const int COMMAND_PROCESSING = 0;

  ///`status: 1 --> commande acceptée`
  // static const int COMMAND_ACCEePTED = 1;

  ///`status: 2 --> commande annulée`
  // static const int COMMAND_CANCELD = 2;

  ///`status: 3 --> course commencée`
  // static const int COMMAND_PENDING = 3;

  ///`status: 4 --> commande en cours de paiement dématérialisé`
  // static const int COMMAND_SOLDING = 4;

  ///`status: 5 --> course terminée`
  // static const int COMMAND_ENDED = 5;

  ///`status: 6 --> attentr fin paiement`
  // static const int COMMAND_AWAIT_PAIEMENT = 6;
} */

class CMDSTATUS {
  ///`status: 0 --> aucune commande`
  static const int COMMAND_EMPTY = 1000;
  static const int COMMAND_DETAIL = 999;

  ///`status: 1 --> commande en cours de traitement`
  static const int COMMAND_TRAITEMENT = 1;

  ///`status: 2 --> commande annulée`
  static const int COMMAND_ANNULEE = 2;

  ///`status: 3 --> commande acceptée`
  static const int COMMAND_ACCEPTEE = 3;

  ///`status: 4 --> course commencée`
  static const int COMMAND_COMMENCEE = 4;

  ///`status: 5 --> commande en cours de paiement dématérialisé`
  static const int COMMAND_PAIEMENT = 5;

  ///`status: 6 --> course terminée`
  static const int COMMAND_TERMINEE = 6;
}


class DIALOGSTATUS {
  ///`status: true --> show dialog`
  static const bool SHOW = true;

  ///`status: false --> dismiss dialog`
  static const bool DISMISS = false;
}

class PERIODTYPE {
  static const String TODAY = "TODAY";
  static const String YESTERDAY = "YESTERDAY";
  static const String THISWEEK = "THISWEEK";
  static const String LASTWEEK = "LASTWEEK";
  static const String THISMONTH = "THISMONTH";
  static const String LASTMONTH = "LASTMONTH";
  static const String THISYEAR = "THISYEAR";
  static const String LASTYEAR = "LASTYEAR";
  static const String ALLTIME = "ALLTIME";
  static const String PERIODIC = "PERIODIC";
}

class PERIODTITLE {
  static const String TODAY = "Point du jour";
  static const String YESTERDAY = "Point d'hier";
  static const String THISWEEK = "Point de la semaine";
  static const String LASTWEEK = "Point de la semaine passée";
  static const String THISMONTH = "Point de ce mois";
  static const String LASTMONTH = "Point du mois dernier";
  static const String THISYEAR = "Point de l'année";
  static const String LASTYEAR = "Point de l'an passé";
  static const String ALLTIME = "Point de toutes vos visites";
  static const String PERIODIC = "du au";
}

class DIALOGRESULT {
  static const String OK = "okcancelresult.ok";
  static const String CANCEL = "okcancelresult.cancel";
}

class LANGUAGEKEY {
  static const String ENGLISH = "ENGLISH";
  static const String FRENCH = "FRENCH";
  static const String SPANISH = "SPANISH";
  static const String GERMAN = "GERMAN";
}

class THEMEKEY {
  static const String LIGHT = "LIGHT";
  static const String DARK = "DARK";
}
