import 'package:alfred_taxi_client/app/themes/styles/styles.dart';
import 'package:flutter/material.dart';

/// `BOUTON POUR AFFICHER LE TYPE DE CATEGORIE A CHOISIR`
/// Il contient le nom et le montant de la categorie
/// parametres[title, color] de type chaine
class categoryBTN extends StatelessWidget {
  const categoryBTN({
    Key? key,
    this.title = 'CATEGORIE 1',
    this.montant = 'MT: 35000 F',
    this.color = Colors.orange,
    this.ontap,
  }) : super(key: key);
  final title, montant, color, ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toString().toUpperCase(),
                  style: categorybtnStyle(),
                ),
                Text(montant, style: categorybtnStyle()),
              ],
            ),
          ),
          // QUELLE ACTION EFFECTUER?
          onTap: ontap,
        ),
      ),
    );
  }
}

/// `BOUTON POUR S'AUTHENTIFIER`
/// parametres[title, color] de type chaine
class athenticationBTN extends StatelessWidget {
  const athenticationBTN({
    Key? key,
    this.title = 'SUIVANT',
    this.color = Colors.orange,
    this.ontap,
    this.iscancelling = false,
    this.oncancel,
  }) : super(key: key);

  final title, color, ontap, oncancel, iscancelling;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        child: iscancelling == true
            ? Row(
                children: [
                  IconButton(
                    onPressed: oncancel,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  // : const SizedBox(),
                  InkWell(
                    child: Center(
                      child: Text(
                        title.toString().toUpperCase(),
                        style: categorybtnStyle(),
                      ),
                    ),
                    // QUELLE ACTION EFFECTUER?
                    onTap: ontap,
                  ),
                ],
              )
            : InkWell(
                child: Center(
                  child: Text(
                    title.toString().toUpperCase(),
                    style: categorybtnStyle(),
                  ),
                ),
                // QUELLE ACTION EFFECTUER?
                onTap: ontap,
              ),
      ),
    );
  }
}
