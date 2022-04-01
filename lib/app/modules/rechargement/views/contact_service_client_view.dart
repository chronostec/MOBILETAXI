import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/image_path_model.dart';
import 'package:alfred_taxi_driver/app/utils/images_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactServiceClientView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contacter service rechargement'),
          centerTitle: true,
        ),
        body: Card(
          color: Colors.white,
          child: RefreshIndicator(
            onRefresh: () async {
              await ctlRechargement.listercontactServiceRecharge();
            },
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var i = 0; i < ctlRechargement.contacts.length; i++)
                    if (i <= 3)
                      contactCard(
                          image: _images
                                  .firstWhere((element) => element.nom
                                      .toString()
                                      .toLowerCase()
                                      .contains(ctlRechargement
                                          .contacts[i].reseau
                                          .toString()
                                          .toLowerCase()))
                                  .path ??
                              _images.last.path,
                          nom: ctlRechargement.contacts[i].reseau,
                          tel: ctlRechargement.contacts[i].telephone)
                    else
                      const SizedBox()
                ],
              ),
            ),
          ),
        ));
  }

  Center contactCard({image = "", nom = "", tel = ""}) {
    return Center(
      child: Container(
          height: 10.h,
          width: 90.w,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xfff3f3f3),
                    offset: Offset(5, 5),
                    blurRadius: 10)
              ]),
          child: Center(
            child: ListTile(
              leading: Container(
                  width: 48.sp,
                  height: 48.sp,
                  decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage(image)))),
              title: Text(nom),
              subtitle: Text(tel),
              trailing: const Icon(CupertinoIcons.phone_arrow_up_right),
              onTap: () async {
                _makePhoneCall(tel);
              },
            ),
          )),
    );
  }

  final List<ImagePath> _images = [
    ImagePath(nom: "orange", path: PathImage.orange),
    ImagePath(nom: "Moov", path: PathImage.moov),
    ImagePath(nom: "mtn", path: PathImage.mtn),
    ImagePath(nom: "service", path: PathImage.serviceClientele),
  ];

  Future<void> _makePhoneCall(String url) async {
    String _url = "tel:$url";
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      Get.snackbar("Appeler", "impossible de lancer ce appel");
    }
  }
}
