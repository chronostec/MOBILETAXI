import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/themes/colors/light_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key, this.montant}) : super(key: key);

  final montant;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: 15.h,
          color: LightColor.navyBlue1,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Solde actuel',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          ctlRechargement.currency.format(
                              montant ?? 0, ctlRechargement.unitSettings),
                          style: GoogleFonts.mulish(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                              color: LightColor.yellow2),
                        )
                      ])
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
