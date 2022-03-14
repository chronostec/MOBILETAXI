import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/modules/driver_map/views/driver_map_view.dart';
import 'package:alfred_taxi_driver/app/modules/driver_map/views/driving_map_view.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../themes/colors/app_colors.dart';
import '../controllers/commande_controller.dart';
import 'app_bar_view.dart';
import 'commande_button_small.dart';
import 'plus_option_button_bottom.dart';

class CommandeView extends GetView<CommandeController> {
  @override
  Widget build(BuildContext context) {
   
    return Obx(() => Scaffold(
          appBar: CommandeAppBarView(),
          body: CupertinoPageScaffold(
            backgroundColor: AppColors.DBLACK,
            child: SizedBox.expand(
              child: SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    /// GOOGLE MAPS VIEW
                    const Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: DrivingMapView(),
                    ),

                    ///COMMAND DAITAILS BOTTOM SMALL BUTTONS
                    ctlcommande.statuscommand.value == CMDSTATUS.COMMAND_EMPTY
                        ? const CommandeDetailBottomButtons()
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
