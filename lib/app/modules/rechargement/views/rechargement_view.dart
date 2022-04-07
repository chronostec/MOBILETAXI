import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/rechargement_model.dart';
import 'package:alfred_taxi_driver/app/modules/rechargement/views/money_transfert_page.dart';
import 'package:alfred_taxi_driver/app/themes/colors/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_service_client_view.dart';
import 'widgets/balance_card.dart';
import 'widgets/title_text.dart';

class RechargementView extends StatefulWidget {
  const RechargementView({Key? key}) : super(key: key);

  @override
  State<RechargementView> createState() => _RechargementViewState();
}

class _RechargementViewState extends State<RechargementView> {
  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _icon(Icons.mobile_friendly, "Mobile money",
            () => Get.to(() => const MoneyTransferPage())),
        _icon(Icons.phone, "Propriétaire",
            () => _makePhoneCall('+2250757777500')),
        _icon(Icons.supervised_user_circle_rounded, "Service client",
            () => Get.to(() => ContactServiceClientView())),
        // _icon(Icons.payment, "Pay Bills"),
        // _icon(Icons.code, "Qr Pay"),
      ],
    );
  }

  Widget _icon(IconData icon, String text, openPage) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: openPage,
          child: Container(
            height: 80,
            width: 80,
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
            child: Icon(icon),
          ),
        ),
        Text(text,
            style: GoogleFonts.mulish(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xff76797e))),
      ],
    );
  }

  Widget _transection({required Operation operation}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: operation.telDest ?? "",
        fontSize: 14,
      ),
      subtitle: Text(operation.date ?? ""),
      trailing: Container(
          height: 30,
          width: 30.w,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: operation.montant != null
              ? Text(
                  operation.montant! > 0
                      ? '-${ctlRechargement.currency.format(operation.montant, ctlRechargement.unitSettings)}'
                      : ctlRechargement.currency.format(
                          operation.montant, ctlRechargement.unitSettings),
                  style: GoogleFonts.mulish(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: LightColor.navyBlue2))
              : Text(
                  '-${ctlRechargement.currency.format(operation.montant, ctlRechargement.unitSettings)}',
                  style: GoogleFonts.mulish(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: LightColor.navyBlue2))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              await ctlRechargement.listerHistoriqueRecharges();
              // await ctlRechargement.listercontactServiceRecharge();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  SizedBox(
                    height: 60.h,
                    child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon:
                                      const Icon(CupertinoIcons.left_chevron)),
                              const TitleText(text: "Mon solde"),
                            ],
                          ),
                          const BalanceCard(),
                          const SizedBox(height: 10),
                          const TitleText(
                            text: "Recharger Compte",
                          ),
                          _operationsWidget(),
                          const SizedBox(
                            height: 40,
                          ),
                          const TitleText(
                            text: "Historique Transactions",
                          ),
                          const Divider(thickness: 2)
                        ]),
                  ),
                  Obx(() => Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 40.h,
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            for (var operation in ctlRechargement
                                    .rechargements.value.operation ??
                                [])
                              _transection(operation: operation),
                          ],
                        ),
                      )))
                ],
              ),
            )),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    String _url = "tel:$url";
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      Get.snackbar("Appeler", "impossible de lancer ce appel");
    }
  }
}
