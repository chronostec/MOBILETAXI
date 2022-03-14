import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/images_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    this.title = "Votre texte",
    this.color = AppColors.DBLUE,
    this.textcolor = AppColors.DWHITE0,
    this.actionPrincipale,
    this.actionSecondaire,
  }) : super(key: key);

  final title, color, textcolor, actionPrincipale, actionSecondaire;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: color,
      child: Text(
        '$title',
        style: TextStyle(fontSize: 13),
      ),
      onPressed: actionPrincipale,
    );
  }
}

class BigButton extends StatelessWidget {
  const BigButton({
    Key? key,
    this.title = "Votre texte",
    this.color = AppColors.DBLUE,
    this.textcolor = AppColors.DWHITE0,
    this.actionPrincipale,
    this.actionSecondaire,
  }) : super(key: key);

  final title, color, textcolor, actionPrincipale, actionSecondaire;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: actionPrincipale,
      onTap: actionPrincipale,
      onLongPress: actionPrincipale,
      child: Container(
        height: 10.h,
        width: 100.w,
        color: AppColors.DBLACK,
        child: Image.asset(
          PathImage.more,
          width: double.maxFinite,
        ),
      ),
    );
  }
}
