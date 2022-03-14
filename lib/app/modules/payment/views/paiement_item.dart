import 'package:alfred_taxi_driver/app/themes/styles/app_styles.dart';
import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  final image;
  final title;
  final subtitle;
  final color;

  const HistoryItem(
      {Key? key, this.image, this.title, this.subtitle, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 83,
        width: 365,
        color: whiteColor,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              '$image',
              width: 62,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title',
                    style: mediaumTextStyle.copyWith(fontSize: 18),
                  ),
                  Text(
                    '$subtitle',
                    style: softpurpleColorTextStyle.copyWith(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
