import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/modules/driver/views/driver_add_view.dart';
import 'package:fredy_proprio/app/modules/driver/views/driver_items_view.dart';

import 'package:get/get.dart';

import '../controllers/driver_controller.dart';

class DriverView extends GetView<DriverController> {
  const DriverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx(() => Material(
          child: SafeArea(
              child: CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: [
                // The CupertinoSliverNavigationBar
                CupertinoSliverNavigationBar(
                  // backgroundColor: AppBarTheme.of(context).backgroundColor,
                  leading: Row(
                    children: [
                      const Text(
                        'Total: ',
                      ),
                      Text(
                        '${ctlDriver.tempDriverList.length}',
                        style: const TextStyle(
                            // color: Colors.blue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // middle: const Text("Gestion Chauffeurs"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // ctlDriver.ListerDrivers();
                      ctlDriver.isEditing.value = false;
                      Get.to(() => DriverAddView());
                    },
                  ),
                  largeTitle: CupertinoSearchTextField(
                    controller: ctlDriver.searchTextTC,
                    placeholder: 'Chercher ....',
                    onTap: () {
                      ctlDriver.tempDriverList.value = ctlDriver.driversList;
                    },
                    onChanged: (value) {
                      ctlDriver.tempDriverList.value = ctlDriver
                          .driversList.reversed
                          .toList()
                          .where((p0) =>
                              p0.nom!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              p0.prenom!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              p0.telephone!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .toList();
                    },
                    onSuffixTap: () {
                      ctlDriver.searchTextTC.text = "";
                      ctlDriver.tempDriverList.value = ctlDriver.driversList;
                    },
                  ),
                ),

                // Other sliver elements
                SliverList(
                    // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    //   maxCrossAxisExtent: 200.0,
                    //   mainAxisSpacing: 10.0,
                    //   crossAxisSpacing: 10.0,
                    //   childAspectRatio: 3 / 2,
                    // ),
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      DriverItemsView(driver: ctlDriver.tempDriverList[index]),
                  childCount: ctlDriver.tempDriverList.length,
                )),
              ],
            ),
          )),
        ));
  }

  // Widget listItems() {
  //   return Expanded(
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: <Widget>[
  //           for (var i = 0; i < 50; i++) DriverItemsView(() {})
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
