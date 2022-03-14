import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<dynamic> AppDialog({
  required BuildContext context,
  String title = 'Traitement en cours....',
  Color spinColor = Colors.amber,
}) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(title),
      children: <Widget>[
        Center(
          child: SpinKitDualRing(color: spinColor),
        )
      ],
    ),
  );
}
