import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Comptestructure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: Text('compte')),
                    TextButton(
                        onPressed: () {},
                        child: Text("enregistrer vos infos",
                            style: TextStyle(color: Colors.green))),
                  ],
                ),
              ),
              Container(
                  height: 6.h,
                  width: 100.w,
                  child: TextField(
                    decoration: InputDecoration(filled: true, hintText: 'nom'),
                  )),
              Container(
                  height: 6.h,
                  width: 100.w,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'lieu',
                    ),
                  )),
              Container(
                  height: 6.h,
                  width: 100.w,
                  child: TextField(
                    decoration:
                        InputDecoration(filled: true, hintText: 'telephone'),
                  )),
              
              Container(
                height: 6.h,
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "s'inscrire en ligne",
                          style: TextStyle(color: Colors.green),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "déconnexion",
                          style: TextStyle(color: Colors.redAccent),
                        )),
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
