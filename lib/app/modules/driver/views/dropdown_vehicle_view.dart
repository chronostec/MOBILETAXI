import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DropdownVehicleView extends GetView {
  final List<Map<String, dynamic>> _roles = [
    for (var i = 10; i < 21; i++)
      {
        "id": i,
        "immatriculation": "10${i}AB$i",
        "marque": "MARKO$i",
        "modele": "M$i",
        "couleur": "noir",
        "annee": "20$i",
        "etat": "Excellent"
      },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: articleTextField(),
    );
  }

  Widget articleTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownFormField<Map<String, dynamic>>(
        onEmptyActionPressed: () async {
          //commonsimpleController.readSearchItems();
        },
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.arrow_drop_down),
          labelText: 'Véhicule',
          hintText: 'ex: honda',
          filled: true,
          // fillColor: Color(0xFFFFFFFF),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 5)),
        ),
        onSaved: (dynamic str) {},
        onChanged: (dynamic str) {
          // commonsimpleController.articleTC.text = str['name'];
          // commonsimpleController.priceTC.text = str['price'].toString();
        },
        validator: (dynamic str) {
          str['immatriculation'].toString().trim().toLowerCase().isNotEmpty
              ? null
              : 'Entrer véhicule svp!';
        },
        displayItemFn: (dynamic item) => Text(
          (item ?? {})['marque'] ?? '',
          // style: TextStyle(fontSize: 16),
        ),
        findFn: (dynamic str) async => _roles,
        selectedFn: (dynamic item1, dynamic item2) {
          if (item1 != null && item2 != null) {
            return item1['marque'] == item2['marque'] ||
                item1['modele'] == item2['modele'] ||
                item1['immatriculation'] == item2['immatriculation'];
          }
          return false;
        },
        filterFn: (dynamic item, str) =>
            item['marque'].toLowerCase().indexOf(str.toLowerCase()) >= 0 ||
            item['immatriculation'].toLowerCase().indexOf(str.toLowerCase()) >=
                0 ||
            item['modele'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
        dropdownItemFn: (dynamic item, int position, bool focused,
                bool selected, Function() onTap) =>
            ListTile(
          title: Text('${item['marque']} - ${item['modele']}'),
          subtitle: Text(
            item['immatriculation'] ?? '',
          ),
          tileColor: focused ? const Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
          onTap: onTap,
        ),
      ),
    );
  }
}
