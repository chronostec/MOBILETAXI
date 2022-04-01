import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/themes/colors/light_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Container(
          width: 100.w,
          height: 20.h,
          color: LightColor.navyBlue1,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Solde actuel',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (ctlRechargement.rechargements.value.solde !=
                                null)
                              if (ctlRechargement.rechargements.value.solde! >=
                                  0)
                                Text(
                                  ctlRechargement.currency.format(
                                      ctlRechargement
                                              .rechargements.value.solde ??
                                          0.0,
                                      ctlRechargement.unitSettings),
                                  style: GoogleFonts.mulish(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w800,
                                      color: LightColor.yellow2),
                                )
                              else
                                Text(
                                  "-${ctlRechargement.currency.format(ctlRechargement.rechargements.value.solde.toString().substring(1, ctlRechargement.rechargements.value.solde.toString().length), ctlRechargement.unitSettings)}",
                                  style: GoogleFonts.mulish(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w800,
                                      color: LightColor.yellow2),
                                )
                            else
                              Text(
                                ctlRechargement.currency
                                    .format(0.0, ctlRechargement.unitSettings),
                                style: GoogleFonts.mulish(
                                    textStyle:
                                        Theme.of(context).textTheme.headline4,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w800,
                                    color: LightColor.yellow2),
                              )
                          ]))
                ],
              ),
              const Positioned(
                left: -170,
                top: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.lightBlue2,
                ),
              ),
              const Positioned(
                left: -160,
                top: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.lightBlue1,
                ),
              ),
              const Positioned(
                right: -170,
                bottom: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow2,
                ),
              ),
              const Positioned(
                right: -160,
                bottom: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow,
                ),
              )
            ],
          ),
        ));
  }
}
