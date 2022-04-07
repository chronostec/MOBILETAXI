import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/drawer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/home_controller.dart';
import 'command_dispo_card.dart';
import 'popscopr_dialog.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key, this.gmapStyle}) : super(key: key);
  final gmapStyle;
  @override
  Widget build(BuildContext context) {
    // print(gmapStyle);
    return WillPopScope(
        onWillPop: () async {
          return await popscopeDialog(context);
        },
        child: Obx(
          () => Scaffold(
            backgroundColor: AppColors.DGREEN1,
            key: ctlHome.ghomeKey,
            appBar: AppBar(
              title: const Text('ALFRED DRIVER'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () => checkCommandedisponiblePeriodicEvent(),
                    icon: const Icon(CupertinoIcons.refresh_bold))
              ],
              leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    ctlHome.ghomeKey.currentState!.openDrawer();
                  }),
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.orange,
                    child: ListTile(
                      title: (ctlcommande.listCommande.value.compte != null &&
                              ctlcommande.listCommande.value.compte!.isNotEmpty)
                          ? Text(
                              "Solde:  ${ctlRechargement.currency.format(ctlcommande.listCommande.value.compte!.first.solde ?? 0, ctlRechargement.unitSettings)}",
                              style: TextStyle(fontSize: 20.sp),
                            )
                          : Text(
                              "Solde:  ${ctlRechargement.currency.format(0, ctlRechargement.unitSettings)}",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                      subtitle: (ctlcommande.listCommande.value.commande !=
                                  null &&
                              ctlcommande.listCommande.value.compte != null &&
                              ctlcommande
                                  .listCommande.value.compte!.isNotEmpty &&
                              ctlcommande.listCommande.value.compte!.first
                                      .statusCompte ==
                                  1)
                          ? const SizedBox()
                          : (ctlcommande.listCommande.value.commande != null &&
                                  ctlcommande.listCommande.value.compte !=
                                      null &&
                                  ctlcommande
                                      .listCommande.value.compte!.isNotEmpty &&
                                  ctlcommande.listCommande.value.compte!.first
                                          .statusCompte ==
                                      0)
                              ? SizedBox(
                                  child: Column(children: [
                                  Text(
                                      "Pensez à le recharger pour continuer de recevoir des commandes",
                                      style: TextStyle(fontSize: 12.sp))
                                ]))
                              : SizedBox(
                                  child: Column(children: [
                                  Text("Votre solde est bas!",
                                      style: TextStyle(fontSize: 12.sp))
                                ])),
                      trailing: Icon(
                        CupertinoIcons.link_circle_fill,
                        size: 32.sp,
                      ),
                      onTap: () => Get.toNamed(Routes.RECHARGEMENT),
                    ),
                  ),
                  preferredSize: Size.fromHeight(70.sp)),
            ),
            drawer: BuildDrawer(),
            body: RefreshIndicator(
              onRefresh: () async {
                await ctlcommande.getCommandeDisponible();
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    if (ctlcommande.listCommande.value.commande != null &&
                        ctlcommande.listCommande.value.commande!.isNotEmpty)
                      for (var commande
                          in ctlcommande.listCommande.value.commande!)
                        ComandeDispoCard(commande)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
