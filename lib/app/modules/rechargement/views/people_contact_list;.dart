import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/driver_model.dart';
import 'package:fredy_proprio/app/data/models/rechargement_model.dart';
import 'package:fredy_proprio/app/modules/rechargement/views/money_transfert_page.dart';
import 'package:fredy_proprio/app/themes/colors/light_color.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class PeopleListPage extends StatefulWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  _PeopleListPageState createState() => _PeopleListPageState();
}

class _PeopleListPageState extends State<PeopleListPage> {
  List<Driver> _contacts = [];
  bool _loading = false;
  String? searchTerm;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    refreshDriver();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refreshDriver([bool showIndicator = true]) async {
    if (showIndicator) {
      setState(() {
        _loading = true;
      });
    }
    List<Driver> _newList = <Driver>[];
    if (_searchTerm.isNotEmpty) {
      _newList = await ctlRechargement.chercherContact(_searchTerm.trim());
    } else {
      _newList = ctlDriver.driversList;
    }
    setState(() {
      if (showIndicator) {
        _loading = false;
      }
      _contacts = _newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await refreshDriver();
        },
        child: Obx(() => CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _loading == true
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
                SliverToBoxAdapter(
                  key: const Key('searchBox'),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: PlatformTextField(
                        cupertino: (context, platform) =>
                            CupertinoTextFieldData(
                          placeholder: 'Chercher',
                        ),
                        material: (context, platform) => MaterialTextFieldData(
                          decoration:
                              const InputDecoration(hintText: 'Chercher'),
                        ),
                        onChanged: (term) async {
                          _searchTerm = term;
                          await refreshDriver(false);
                        },
                      ),
                    ),
                  ),
                ),
                ..._contacts.map((contact) {
                  return SliverToBoxAdapter(
                    child: ListTile(
                        leading: (contact.nom != null &&
                                contact.nom!.isNotEmpty)
                            ? CircleAvatar(
                                child: Text(
                                    contact.nom.toString().substring(0, 1),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold)),
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)]),
                        title: Text("${contact.nom} ${contact.prenom}"),
                        subtitle: Text("${contact.telephone}"),
                        trailing: IconButton(
                            onPressed: () {
                              ctlRechargement.driver.value = Driver(
                                  nom: contact.nom,
                                  prenom: contact.prenom,
                                  telephone: contact.telephone,
                                  id: contact.id);
                              Get.to(() => const MoneyTransferPage());
                            },
                            icon: Icon(CupertinoIcons.bitcoin_circle,
                                size: 32.sp, color: LightColor.navyBlue1))),
                  );
                }),
              ],
            )),
      ),
    );
  }
}
