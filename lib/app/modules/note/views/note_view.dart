import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/note_controller.dart' show NoteController, ctlSearch;

class NoteView extends GetView<NoteController> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
            top: false,
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(FontAwesomeIcons.chevronDown)),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ListTile(
                          title: Text(
                            "Bonne arrivée !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          subtitle:
                              Text("Laissez nous une note de votre course",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person_pin_circle_sharp,
                      color: AppColor.CGREEN,
                    ),
                    title: Text(
                      'De ${ctlMapCourse.distMatrix.value.originAddresses![0]}',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person_pin_circle_sharp,
                      color: AppColor.CRED,
                    ),
                    title: Text(
                      'A ${ctlMapCourse.distMatrix.value.destinationAddresses![0]}',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    child: SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (var i = 0; i < ctlNote.noteList.length; i++)
                            InkWell(
                                onTap: () {
                                  ctlNote.noteIndex.value = i;
                                  if (ctlNote.noteList[i].details!.length ==
                                      1) {
                                    ctlNote.groupvalue.value =
                                        ctlNote.noteList[i].details![0].iD!;
                                  }
                                },
                                child: Container(
                                  child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: CircleAvatar(
                                          backgroundColor: AppColor.CGREYLIGHT,
                                          radius: 30.sp,
                                          backgroundImage: AssetImage(
                                              ctlNote.noteimage[i]))),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          Colors.pinkAccent.withOpacity(0.80),
                                      width: 0,
                                    ),
                                  ),
                                )
                                /*  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: CircleAvatar(
                                      backgroundColor: AppColor.CGREYLIGHT,
                                      backgroundImage:
                                          AssetImage(ctlNote.noteimage[i]),
                                    ),
                                  )), */
                                ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 50,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (var i = 0;
                            i <
                                ctlNote.noteList[ctlNote.noteIndex.value]
                                    .details!.length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: ctlNote.groupvalue.value ==
                                          ctlNote
                                              .noteList[ctlNote.noteIndex.value]
                                              .details![i]
                                              .iD
                                      ? AppColor.CGREYLIGHT
                                      : AppColor.CWHITE,
                                ),
                                child: ListTile(
                                  onTap: () => ctlNote.groupvalue.value =
                                      ctlNote.noteList[ctlNote.noteIndex.value]
                                          .details![i].iD!,
                                  leading: Icon(ctlNote.groupvalue.value ==
                                          ctlNote
                                              .noteList[ctlNote.noteIndex.value]
                                              .details![i]
                                              .iD
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank),
                                  title: Text(
                                      "${ctlNote.noteList[ctlNote.noteIndex.value].details![i].libelle}"),
                                )),
                          ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 100.w,
                    child: CupertinoButton(
                      onPressed: () async {
                        ctlNote.isSendingNote.value
                            ? Get.defaultDialog(
                                title: "Envoi en cours...",
                                content: const SpinKitWave(
                                  color: Colors.blueGrey,
                                  type: SpinKitWaveType.center,
                                ),
                              )
                            : null;
                        await ctlNote.postNotationsToApi().then((value) async {
                          if (value == "succes") {
                            ctlNote.isNoted.value = true;
                            Get.back();
                          }
                        });
                      },
                      child: Text(
                        "ENVOYER",
                        style: TextStyle(
                            color: AppColor.CBLACK,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      color: AppColor.CGREY,
                    ),
                  )
                ],
              ),
            )));
  }
}
