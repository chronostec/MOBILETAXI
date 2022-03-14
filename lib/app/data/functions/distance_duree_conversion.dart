double convertDistanceToNumric({
  required String distance,
}) {
  var dist0, dist1, dist2;
  var unite = "", valeur = 0.0;

  for (var i = 0; i < distance.length; i++) {
    dist0 = distance.split(" ");
  }

  if (dist0.length > 0) {
    dist1 = dist0[0].replaceAll(',', '.');
    dist2 = double.parse(dist1);
    unite = dist0[1];
    if (unite == "m") {
      valeur = dist2 / 1000;
    } else {
      valeur = dist2;
    }
  }

  return valeur;
}

double convertDureeToNumric({
  required String duree,
}) {
  var dur0, dur1, dur2;
  var unite = "", valeur = 0.0;

  for (var i = 0; i < duree.length; i++) {
    dur0 = duree.split(" ");
  }

  if (dur0.length > 0) {
    dur1 = dur0[0].replaceAll(',', '.');
    dur2 = double.parse(dur1);
    unite = dur0[1];
    if (unite == "minutes" || unite == "minute" || unite == "min") {
      valeur = dur2;
    } else {
      valeur = dur2 * 60;
    }
  }

  return valeur;
}
