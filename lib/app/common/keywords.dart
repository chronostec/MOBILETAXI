import 'package:google_maps_flutter/google_maps_flutter.dart';

class MAPSKEY {
  static const String GMKEY = "AIzaSyDBOybkxzy-Hd28PaVHt20eKbu-S4IvB4g";
}

class MAPSMARKERS {
  static const MarkerId driverMarkerId = MarkerId("origin");
  static const MarkerId rdvMarkerId = MarkerId("rdv");
  static const MarkerId destinationMarkerId = MarkerId("destination");
}

class WIDGET_ {
  static const String FAB = "FAB";
  static const String SEARCH = "SEARCH";
  static const String CATEGORY = "CATEGORY";
  static const String CATEGORY_DETAILS = "CATEGORY_DETAILS";
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

class CMDSTATUS {
  ///`status: 0 --> aucune commande`
  static const int COMMAND_EMPTY = 1000;

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
