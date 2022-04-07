import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

AppBar CommandeAppBarView() {
  return AppBar(
    title: ctlcommande.commande.value.clientLibelle != null
        ? Text(
            "De ${ctlcommande.commande.value.clientLibelle ?? ''}",
            overflow: TextOverflow.clip,
            maxLines: 1,
          )
        : Text(
            "De ${ctlcommande.commande.value.clientLibelle}",
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
    shape: const RoundedRectangleBorder(

        // borderRadius: BorderRadius.vertical(
        //   bottom: Radius.circular(30),
        // ),
        ),
    bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            width: 80.w,
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      "à",
                      style: TextStyle(color: AppColors.DWHITE0),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "${ctlcommande.commande.value.destLibelle ?? ''}"
                          .split(',')
                          .first
                          .toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: AppColors.DWHITE0),
                    ),
                  ],
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "MT: ",
                          style: TextStyle(color: AppColors.DWHITE0),
                        ),
                        Text(
                          "${ctlcommande.commande.value.montantPercu} F",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppColors.DWHITE0),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "Durée: ",
                          style: TextStyle(color: AppColors.DWHITE0),
                        ),
                        Text(
                          "${ctlcommande.commande.value.duree ?? ''} min",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: AppColors.DWHITE0),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(55.0)),
  );
}

AppBar DrivingAppBarView() {
  return AppBar(
    leading: IconButton(
        onPressed: () {},
        icon: const Icon(CupertinoIcons.location, color: AppColors.DWHITE0)),
    title: Text(
      "${ctlcommande.commande.value.destLibelle ?? ''}",
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: const TextStyle(fontSize: 14),
    ),
    // backgroundColor: AppColors.DBLACK,
    bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            width: 95.w,
            child: Wrap(children: [
              Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text("Dans: ",
                              style: TextStyle(color: AppColors.DWHITE0)),
                          Text(
                            "${ctlDrivermap.distanceDuree.value.duree ?? ''}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: AppColors.DWHITE0),
                          )
                        ]),
                    const SizedBox(width: 30),
                    Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text("Distance: ",
                              style: TextStyle(color: AppColors.DWHITE0)),
                          Text(
                            "${ctlDrivermap.distanceDuree.value.distance ?? ''}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: AppColors.DWHITE0),
                          )
                        ])
                  ]),
              SizedBox(
                width: 99.w,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text("Temps Ecoulé: ",
                        style: TextStyle(color: AppColors.DWHITE0)),

                    /// Display stop watch time
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: StreamBuilder<int>(
                        stream: ctlcommande.stopWatchTimer.rawTime,
                        initialData: ctlcommande.stopWatchTimer.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data!;
                          final displayTime = StopWatchTimer.getDisplayTime(
                              value,
                              hours: ctlcommande.isHours.value);
                          var _chrono = displayTime.length;
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  displayTime.substring(
                                      0, displayTime.length - 3),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                      color: AppColors.DWHITE0),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    IconButton(
                        onPressed: () {
                          /// RECUPERATION DU CLIENT
                          if (ctlcommande.statuscommand.value ==
                              CMDSTATUS.COMMAND_ACCEPTEE) {
                            ctlDrivermap.getPolyline(
                              destination: LatLng(
                                ctlcommande.commande.value.clientLatitude!
                                    .toDouble(),
                                ctlcommande.commande.value.clientLongitude!
                                    .toDouble(),
                              ),
                              color: AppColors.DGREENLIGHT,
                            );
                          }

                          /// COURSE COMMENCEE
                          if (ctlcommande.statuscommand.value ==
                                  CMDSTATUS.COMMAND_COMMENCEE ||
                              ctlcommande.statuscommand.value ==
                                  CMDSTATUS.COMMAND_PAIEMENT) {
                            ctlDrivermap.getPolyline(
                              destination: LatLng(
                                ctlcommande.commande.value.destLatitude!
                                    .toDouble(),
                                ctlcommande.commande.value.destLongitude!
                                    .toDouble(),
                              ),
                              color: AppColors.DORANGE1,
                            );
                          }
                        },
                        icon: const Icon(
                            CupertinoIcons.location_north_line_fill,
                            size: 32,
                            color: AppColors.DRED)),
                  ],
                ),
              ),
            ]),
          ),
        ),
        preferredSize: const Size.fromHeight(80.0)),
  );
}
