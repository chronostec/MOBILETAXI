import 'dart:ui';

import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/modules/chatbox/views/chatbox_view.dart';
import 'package:alfred_taxi_client/app/modules/utils/images_path.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import 'annuler_cmde_dialog.dart';

class DriverDetailModalFit extends StatelessWidget {
  const DriverDetailModalFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Wrap(children: [
                  Text(
                    'MT: ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoMusic(
                      fontSize: 14,
                      color: Color.fromARGB(255, 42, 7, 102),
                    ),
                  ),
                  Text(
                    '${ctlRecherche.maCommande.value.montantNegocie ?? ''} Fcfa',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoMusic(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromARGB(255, 42, 7, 102)),
                  )
                ]),
                Wrap(children: [
                  Text(
                    'durée course: ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoMusic(
                        fontSize: 14, color: Color.fromARGB(255, 42, 7, 102)),
                  ),
                  Text(
                    '${ctlRecherche.maCommande.value.dureeEffective ?? '...'} minute',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoMusic(
                        fontSize: 14,
                        color: Color.fromARGB(255, 42, 7, 102),
                        fontWeight: FontWeight.bold),
                  )
                ]),
              ],
            ),
          ),
          Card(
            // color: Color.fromARGB(255, 241, 243, 245),
            child: ListTile(
              leading: Icon(
                Icons.person_pin_circle_sharp,
                color: Color.fromARGB(255, 79, 209, 129),
              ),
              title: Wrap(children: [
                Text(
                  'De:  ',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.notoMusic(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color.fromARGB(255, 76, 71, 85)),
                ),
                Text(
                  '${ctlRecherche.maCommande.value.rdvLibelle ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoMusic(
                      fontSize: 14, color: Color.fromARGB(255, 42, 7, 102)),
                )
              ]),
            ),
          ),
          Card(
            // color: Color.fromARGB(255, 241, 243, 245),
            child: ListTile(
              leading: Icon(
                Icons.person_pin_circle_sharp,
                color: Color.fromARGB(255, 252, 52, 92),
              ),
              title: Wrap(children: [
                Text(
                  'A:  ',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.notoMusic(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color.fromARGB(255, 76, 71, 85)),
                ),
                Text(
                  '${ctlRecherche.maCommande.value.destLibelle ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoMusic(
                      fontSize: 14, color: Color.fromARGB(255, 42, 7, 102)),
                )
              ]),
            ),
          ),
          /////////////////////////////////////////////////////////////////////
          Card(
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: AssetImage(
                AppImage.person,
              )),
              trailing: Column(children: [
                Chip(
                    label: Text(
                        'est là dans ${ctlMapCourse.rdvDistMatrix.value.rows![0].elements![0].duration!.text ?? '...'} minute',
                        style: GoogleFonts.notoMusic(
                            fontSize: 11,
                            color: Color.fromARGB(255, 42, 7, 102))))
              ]),
              title: Text(
                "${ctlRecherche.maCommande.value.driverNom}",
                style: GoogleFonts.notoMusic(
                    fontSize: 12, color: Color.fromARGB(255, 42, 7, 102)),
              ),
              subtitle: Text(
                "${ctlRecherche.maCommande.value.modele}, ${ctlRecherche.maCommande.value.immatriculation}",
                style: GoogleFonts.notoMusic(
                    fontSize: 11, color: Color.fromARGB(255, 42, 7, 102)),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () => annulerCmde(context: context),
                      icon: Icon(Icons.close)),
                  TextButton.icon(
                      onPressed: () {
                        showEchangeView(context);
                      },
                      icon: Icon(Icons.message, color: AppColor.CBLUE),
                      label: Text('message',
                          style: TextStyle(color: AppColor.CGREY))),
                  TextButton.icon(
                      onPressed: () {
                        launch(
                            ('tel://${ctlRecherche.maCommande.value.telephone}'));
                      },
                      icon: Icon(Icons.call, color: AppColor.CBLUE),
                      label: Text('appeler',
                          style: TextStyle(color: AppColor.CGREY))),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  showEchangeView(context) async {
    return await showMaterialModalBottomSheet(
      expand: false,
      bounce: true,
      isDismissible: false,
      elevation: 20,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ChatboxView(),
    );
  }
}
