import 'package:alfred_taxi_driver/app/modules/rechargement/views/contacter_particulier.dart';
import 'package:alfred_taxi_driver/app/modules/rechargement/views/money_transfert_page.dart';
import 'package:alfred_taxi_driver/app/themes/colors/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controllers/rechargement_controller.dart';
import 'widgets/balance_card.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'widgets/title_text.dart';

class RechargementView extends StatefulWidget {
  const RechargementView({Key? key}) : super(key: key);

  @override
  State<RechargementView> createState() => _RechargementViewState();
}

class _RechargementViewState extends State<RechargementView> {
  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _icon(Icons.mobile_friendly, "Mobile money",
            () => Get.to(() => const MoneyTransferPage())),
        _icon(Icons.phone, "Particulier",
            () => Get.to(() => const ContacterParticulier())),
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

  Widget _transectionList() {
    return Column(
      children: <Widget>[
        _transection("+2250102030405", "23 Mar 2022"),
        _transection("+2250102030405", "25 Fev 2022"),
        _transection("+2250102030405", "03 Jan 2022"),
      ],
    );
  }

  Widget _transection(String text, String time) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: text,
        fontSize: 14,
      ),
      subtitle: Text(time),
      trailing: Container(
          height: 30,
          width: 30.w,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text('+1700 F',
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
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(CupertinoIcons.left_chevron)),
                  const TitleText(text: "Mon solde"),
                ],
              ),
              const BalanceCard(),
              const SizedBox(height: 10),
              const TitleText(
                text: "Operations",
              ),
              _operationsWidget(),
              ListView(shrinkWrap: true, children: [
                const SizedBox(
                  height: 40,
                ),
                const TitleText(
                  text: "Historique Transactions",
                ),
                const Divider(thickness: 2),
                _transectionList()
              ])
            ],
          ),
        ],
      ),
    )));
  }
}
