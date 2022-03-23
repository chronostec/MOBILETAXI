import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/modules/dashboard/children/rapportactivite/views/rapportactivite_view.dart';
import 'package:fredy_proprio/app/routes/app_pages.dart';
import 'package:fredy_proprio/app/themes/colors/app_colors.dart';
import 'package:fredy_proprio/app/utils/app_images.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final TextStyle whiteText = const TextStyle(color: Colors.white);

  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  "Rapport d'activités",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: OutlinedButton(
                    onPressed: () {
                      ctlDashboard.montantTC.text = ctlDashboard
                          .dashboardResume.value.areverser
                          .toString();
                      reverserMontantDialog(context);
                    },
                    child: const Text("Reverser")),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              // await myAwaitingDialog(context: context);
              await ctlRapportActivite.getRapportJournee();
              Get.to(RapportactiviteView());
            },
            child: rapportActivite(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _buildTile(
                    color: Colors.pink,
                    icon: Icons.monetization_on,
                    title: "Montant à percevoir",
                    data:
                        "${ctlDashboard.dashboardResume.value.apercevoir ?? 0} F",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.green,
                    icon: Icons.done_all,
                    title: "Montant à reverser",
                    data:
                        "${ctlDashboard.dashboardResume.value.areverser ?? 0} F",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: Icons.group,
                    title: "Chauffeurs",
                    data:
                        "${ctlDashboard.dashboardResume.value.nombreDriver ?? 0}",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.pink,
                    icon: Icons.drive_eta_rounded,
                    title: "Véhicules",
                    data:
                        "${ctlDashboard.dashboardResume.value.nombreVehicule ?? 0}",
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildTile(
                    color: Colors.blue,
                    icon: FontAwesomeIcons.car,
                    title: "Véhicules actifs",
                    data:
                        "${ctlDashboard.dashboardResume.value.nombreVehculeActif ?? 0}",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Future<dynamic> reverserMontantDialog(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Effectuer reversement"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// MONEY FIELD
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: TextFormField(
                      controller: ctlDashboard.montantTC,
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            ctlDashboard.montantTC.text.isNotEmpty &&
                            double.parse(ctlDashboard
                                    .montantTC.text.removeAllWhitespace
                                    .toString()) <=
                                double.parse(
                                    ctlDashboard.montantTC.text.toString())) {
                          return null;
                        } else {
                          return "Montant invalide!";
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        labelText: "Montant",
                        hintText: "0.00",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      style: const TextStyle(
                          color: AppColor.PBLACK,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Get.back(), child: const Text("retour")),
              OutlinedButton(
                  onPressed: () {
                    if (ctlDashboard.montantTC.text.isNotEmpty &&
                        double.parse(ctlDashboard
                                .montantTC.text.removeAllWhitespace
                                .toString()) <=
                            double.parse(
                                ctlDashboard.montantTC.text.toString())) {
                      ctlReversement.genererLienPaiement(
                          helper.proprioInfo.value.id ?? 0,
                          ctlDashboard.montantTC.text);
                      Get.toNamed(Routes.REVERSEMENT);
                      Get.snackbar("Merci",
                          "Veuillez à présent valider votre paiement via votre service mobile money!",
                          colorText: AppColor.PWHITE0,
                          duration: const Duration(seconds: 5),
                          backgroundColor: AppColor.PRED1,
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      Get.snackbar("Oups!!", "Saisissez une valeur valide");
                    }
                    // Get.back();
                  },
                  child: const Text("valider"))
            ],
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
  }

  Card rapportActivite() {
    return Card(
      elevation: 4.0,
      color: Colors.white,
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: Container(
                alignment: Alignment.bottomCenter,
                width: 45.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: 8.0,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 4.0),
                    Container(
                      height: 25,
                      width: 8.0,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 4.0),
                    Container(
                      height: 40,
                      width: 8.0,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 4.0),
                    Container(
                      height: 30,
                      width: 8.0,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
              title: const Text(
                "Journée",
                style: TextStyle(fontSize: 13),
              ),
              subtitle: Text(
                  "${ctlDashboard.dashboardResume.value.courseJour ?? 0} Courses",
                  style: const TextStyle(fontSize: 13)),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: ListTile(
              leading: Container(
                alignment: Alignment.bottomCenter,
                width: 45.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: 8.0,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 4.0),
                    Container(
                      height: 25,
                      width: 8.0,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 4.0),
                    Container(
                      height: 40,
                      width: 8.0,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 4.0),
                    Container(
                      height: 30,
                      width: 8.0,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
              title: const Text("Montant", style: TextStyle(fontSize: 13)),
              subtitle: Text(
                "${ctlDashboard.dashboardResume.value.montantJour ?? 0} Fcfa",
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              "Bienvenue !",
              style: whiteText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "${helper.proprioInfo.value.nom} ${helper.proprioInfo.value.prenom}",
                      style: whiteText.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "${helper.proprioInfo.value.telephone}",
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 2),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _buildTile(
      {Color? color,
      IconData? icon,
      required String title,
      required String data}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: whiteText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            style:
                whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
