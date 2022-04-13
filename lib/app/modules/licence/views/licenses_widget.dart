import 'package:flutter/material.dart';
import 'package:alfred_taxi_driver/app/data/models/licence_model.dart';

class LicencesWidget extends StatelessWidget {
  final List<Licence> licences;

  const LicencesWidget({Key? key, required this.licences}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 24),
        itemCount: licences.length,
        itemBuilder: (context, index) {
          final licence = licences[index];

          return ListTile(
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "${licence.title}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Text(
              "${licence.text}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          );
        },
      );
}
