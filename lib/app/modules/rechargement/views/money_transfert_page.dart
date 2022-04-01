import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/modules/rechargement/views/webview_pay.dart';
import 'package:alfred_taxi_driver/app/themes/colors/light_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'payment_web_view.dart';
import 'widgets/title_text.dart';

class MoneyTransferPage extends StatefulWidget {
  const MoneyTransferPage({Key? key}) : super(key: key);

  @override
  _MoneyTransferPageState createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends State<MoneyTransferPage> {
  Align _buttonWidget() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 48.h,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Obx(() => Column(
                  children: <Widget>[
                    SizedBox(height: 1.h),
                    Expanded(
                        child: GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                            padding: EdgeInsets.symmetric(horizontal: 30.sp),
                            children: <Widget>[
                          _countButton(1),
                          _countButton(2),
                          _countButton(3),
                          _countButton(4),
                          _countButton(5),
                          _countButton(6),
                          _countButton(7),
                          _countButton(8),
                          _countButton(9),
                          Container(),
                          _countButton(0),
                          ctlRechargement.saisie.value > 0
                              ? _icon(Icons.backspace, false)
                              : const SizedBox()
                        ])),
                    ctlRechargement.saisie.value >= 10
                        ? _transferButton()
                        : const SizedBox()
                  ],
                ))));
  }

  Widget _transferButton() {
    return InkWell(
      child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: const BoxDecoration(
              color: LightColor.navyBlue2,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Wrap(
            children: <Widget>[
              Transform.rotate(
                angle: 70,
                child: const Icon(
                  Icons.swap_calls,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              const TitleText(text: "Valider", color: Colors.white),
            ],
          )),
      onTap: () {
        ctlRechargement
            .demanderUrlRecharge(ctlRechargement.saisie.value >= 10
                ? ctlRechargement.saisie.value
                : 0)
            .then((value) {
          if (value.lien != null && value.lien!.isNotEmpty) {
            Get.to(() => PaiementWeb(url: value.lien ?? ""));
          } else {
            Get.snackbar("Echec ouverture",
                "La page de rechargement n'est pas disponible actuellement, veuillez réessayer svp!",
                duration: const Duration(seconds: 4));
          }
        });
      },
    );
  }

  Widget _icon(IconData icon, bool isBackground) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                      color: LightColor.lightGrey,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Icon(icon)),
              onTap: () {
                ctlRechargement.enleverChiffre();
              },
            ),
          ],
        ));
  }

  Widget _countButton(int text) {
    return Material(
        child: InkWell(
            onTap: () {
              ctlRechargement.ajouterChiffre(text);
              print(text);
            },
            child: Container(
              alignment: Alignment.center,
              child: TitleText(
                text: '$text',
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    const Text(
                      'Saisir le montant',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 80.w,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: LightColor.navyBlue2,
                            borderRadius:
                                BorderRadius.all(const Radius.circular(15))),
                        child: Obx(() => TitleText(
                            text: ctlRechargement.saisie.value > 0
                                ? ctlRechargement.saisie.value.toString()
                                : '0.00',
                            color: ctlRechargement.saisie.value > 0
                                ? Colors.white
                                : Colors.white30))),
                    const Expanded(flex: 2, child: SizedBox())
                  ],
                ),
              ),
              const Positioned(
                left: -140,
                top: -270,
                child: CircleAvatar(
                    radius: 190, backgroundColor: LightColor.lightBlue2),
              ),
              const Positioned(
                left: -130,
                top: -300,
                child: CircleAvatar(
                    radius: 190, backgroundColor: LightColor.lightBlue1),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .4,
                right: -150,
                child: const CircleAvatar(
                    radius: 130, backgroundColor: LightColor.yellow2),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .4,
                right: -180,
                child: const CircleAvatar(
                    radius: 130, backgroundColor: LightColor.yellow),
              ),
              Positioned(
                  left: 0,
                  top: 40,
                  child: Row(
                    children: const <Widget>[
                      BackButton(
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      TitleText(text: "Rechargez-vous!", color: Colors.white)
                    ],
                  )),
              _buttonWidget(),
            ],
          ),
        ));
  }
}
