import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/modules/chatbox/views/chatbox_view.dart';
import 'package:alfred_taxi_client/app/modules/ma_course/views/share_view.dart';
import 'package:alfred_taxi_client/app/modules/note/views/note_view.dart';
import 'package:alfred_taxi_client/app/modules/utils/images_path.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class DrivingModalFit extends StatelessWidget {
  const DrivingModalFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.white),
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
                        '${ctlRecherche.maCommande.value.montantNegocie} Fcfa',
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
                            fontSize: 14,
                            color: Color.fromARGB(255, 42, 7, 102)),
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
              ListTile(
                leading:
                    CircleAvatar(backgroundImage: AssetImage(AppImage.person)),
                trailing: Chip(label: Text('Bon voyage! ')),
                title: Text("${ctlRecherche.maCommande.value.driverNom}"),
                subtitle: Text(
                    "${ctlRecherche.maCommande.value.modele}, ${ctlRecherche.maCommande.value.immatriculation}"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          showNoteView(context);
                        },
                        icon:
                            Icon(FontAwesomeIcons.star, color: AppColor.CGREY),
                        label:
                            Text('', style: TextStyle(color: AppColor.CGREY))),
                    TextButton.icon(
                        onPressed: () {
                          Get.to(ShareView());
                          // showShareView(context);
                        },
                        icon: Icon(Icons.share_sharp, color: AppColor.CGREY),
                        label:
                            Text('', style: TextStyle(color: AppColor.CGREY))),
                    TextButton.icon(
                        onPressed: () {
                          showEchangeView(context);
                        },
                        icon: Icon(Icons.message, color: AppColor.CGREY),
                        label:
                            Text('', style: TextStyle(color: AppColor.CGREY))),
                    TextButton.icon(
                        onPressed: () {
                          launch(
                              ('tel://${ctlRecherche.maCommande.value.telephone}'));
                        },
                        icon: Icon(Icons.call, color: AppColor.CGREY),
                        label:
                            Text('', style: TextStyle(color: AppColor.CGREY))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  showNoteView(context) async {
    await ctlNote.getNotationFromApi();
    return await showMaterialModalBottomSheet(
      expand: false,
      bounce: true,
      isDismissible: false,
      elevation: 20,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => NoteView(),
    );
  }

  showShareView(context) async {
    return await showMaterialModalBottomSheet(
      expand: false,
      bounce: true,
      isDismissible: true,
      elevation: 20,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareView(),
    );
  }
}
