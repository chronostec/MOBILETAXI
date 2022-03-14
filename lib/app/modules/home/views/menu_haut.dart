import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/modules/paiement_web/payment_web_view.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MENUHAUT extends StatelessWidget {
  const MENUHAUT({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        backgroundColor: AppColor.CGREY,
        onPressed: () {
          ctlHome.ghomeKey.currentState!.openDrawer();
        },
        child: Icon(
          Icons.menu,
          color: AppColor.CBLACK,
        ),
      ),
    );
  }
}

class PAIEMENTBTN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        // color: AppColor.CREDO,
        onPressed: () {
          print("ouverture page de paiement");
          ctlHome.urlpaiement.value.isNotEmpty
              ? Get.to((() => PaiementWeb(url: ctlHome.urlpaiement.value)))
              : Get.snackbar("ALERTE PAIEMENT",
                  "Aucun paiement n'a encore été demandé. Veuillez demander au chauffeur de relancer la demande svp",
                  duration: const Duration(seconds: 10),
                  colorText: AppColor.CWHITE,
                  backgroundColor: AppColor.CRED);
        },
        icon: const Icon(CupertinoIcons.money_dollar_circle_fill,
            color: AppColor.CREDO, size: 70));
  }
}

/* FloatingActionButton(
        backgroundColor: AppColor.CREDO,
        onPressed: () {
          ctlHome.urlpaiement.value.isNotEmpty
              ? Get.to((() => PaiementWeb(url: ctlHome.urlpaiement.value)))
              : Get.snackbar("ALERTE PAIEMENT",
                  "Aucun paiement n'a encore été demandé. Veuillez demander au chauffeur de relancer la demande svp",
                  duration: const Duration(seconds: 10),
                  colorText: AppColor.CWHITE,
                  backgroundColor: AppColor.CRED);
        },
        child: Icon(
          CupertinoIcons.money_dollar_circle,
          color: AppColor.CWHITE,
          size: 50,
        ),
      ), */