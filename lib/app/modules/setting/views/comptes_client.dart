import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Compteclient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Card(
          color: Colors.blueGrey[50],
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 6.h,
                  width: 100.w,
                  color: Colors.blueGrey[200],
                  child: Text('compte')),
              Container(
                  height: 6.h,
                  width: 100.w,
                  child: TextField(
                    //controller: settingCTL.nameTC,
                    onChanged: (value) {},
                    decoration: InputDecoration(filled: true, hintText: 'nom'),
                  )),
              Container(
                  height: 6.h,
                  width: 100.w,
                  child: TextField(
                    //controller: clientCTL.phoneTC,
                    onChanged: (value) {},
                    decoration:
                        InputDecoration(filled: true, hintText: 'téléphone'),
                  )),
              Container(
                  height: 6.h,
                  width: 100.w,
                  child: TextField(
                    //controller: clientCTL.phoneTC,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        filled: true, hintText: 'code immatriculation'),
                  )),
              Container(
                height: 6.5.h,
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () async {
                          // clientCTL.addClient();
                        },
                        child: Text(
                          "s'enregistrer",
                          style: TextStyle(color: Colors.green),
                        )),
                    Card(
                      child: TextButton.icon(
                        onPressed: () {
                          // settingCTL.generateTextCode();
                          // Get.to(GenerateCustomerView());
                        },
                        label: Text(
                          "générer qrcode",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        icon: Icon(Icons.qr_code, color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
