import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/driver_model.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';
import 'package:fredy_proprio/app/utils/app_styles.dart';
import 'package:fredy_proprio/app/utils/modals/modal_with_nested_scroll.dart';

import 'package:get/get.dart';

import 'driver_add_view.dart';
import 'driver_detail_modal_with_nested_scroll copy.dart';

class DriverItemsView extends GetView {
  final onPressed;
  final Driver driver;
  DriverItemsView({
    Key? key,
    this.onPressed,
    required this.driver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: MaterialButton(
          padding: const EdgeInsets.all(0),
          elevation: 0.5,
          // color: Colors.white,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: onPressed as void Function()?,
          child: Row(
            children: <Widget>[
              Ink(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage(AppImage.person1Image),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("${driver.nom}", style: priceTextStyle3),
                              Text(" ${driver.prenom}", style: priceTextStyle2),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              Text("${driver.telephone}", style: priceTextStyle)
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(CupertinoIcons.app_badge),
                          onPressed: () {
                            ctlDriver.getVehiculeResume(driver.vehiculeId).then(
                                (value) =>
                                    showMoreAboutDriver(context, driver));
                          },
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showMoreAboutDriver(BuildContext context, Driver driver) {
    return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => driverDetailNestedScrollModal(
              driver: driver,
            ));
  }
}
