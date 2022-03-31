import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:full_text_search/searches.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:logging_config/logging_config.dart';
import 'package:sizer/sizer.dart';
import 'package:sunny_dart/sunny_dart.dart';
import 'package:url_launcher/url_launcher.dart';

class PeopleListPage extends StatefulWidget {
  const PeopleListPage({Key? key}) : super(key: key);

  @override
  _PeopleListPageState createState() => _PeopleListPageState();
}

class _PeopleListPageState extends State<PeopleListPage> {
  late ContactService _contactService;
  List<Contact> _contacts = [];
  bool _loading = false;
  String? searchTerm;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    configureLogging(LogConfig.root(Level.INFO, handler: LoggingHandler.dev()));
    _contactService = UnifiedContacts;
    refreshContacts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refreshContacts([bool showIndicator = true]) async {
    if (showIndicator) {
      setState(() {
        _loading = true;
      });
    }
    List<Contact> _newList;
    if (_searchTerm.isNotEmpty) {
      _newList = [
        ...await FullTextSearch<Contact>.ofStream(
          term: _searchTerm,
          items: _contactService.streamContacts(),
          tokenize: (contact) {
            return [
              contact.givenName,
              contact.familyName,
              ...contact.phones
                  .expand((number) => tokenizePhoneNumber(number.value)),
            ].where((s) => s != null && s != '').toList();
          },
          ignoreCase: true,
          isMatchAll: true,
          isStartsWith: true,
        ).execute().then((results) => [
              for (var result in results) result.result,
            ])
      ];
    } else {
      final contacts = _contactService.listContacts(
          withUnifyInfo: true,
          withThumbnails: true,
          withHiResPhoto: false,
          sortBy: const ContactSortOrder.firstName());
      var tmp = <Contact>[];
      while (await contacts.moveNext()) {
        (await contacts.current)?.let((self) => tmp.add(self));
      }
      _newList = tmp;
    }
    setState(() {
      if (showIndicator) {
        _loading = false;
      }
      _contacts = _newList;
    });
  }

  Future updateContact() async {
    final ninja = _contacts.toList().firstWhere(
        (contact) => contact.familyName?.startsWith('Ninja') == true);
    ninja.avatar = null;
    await _contactService.updateContact(ninja);

    await refreshContacts();
  }

  Future _openContactForm() async {
    final contact = await Contacts.openContactInsertForm();
    if (contact != null) {
      await refreshContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await refreshContacts();
        },
        child: CustomScrollView(
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
                    cupertino: (context, platform) => CupertinoTextFieldData(
                      placeholder: 'Chercher',
                    ),
                    material: (context, platform) => MaterialTextFieldData(
                      decoration: const InputDecoration(hintText: 'Chercher'),
                    ),
                    onChanged: (term) async {
                      _searchTerm = term;
                      await refreshContacts(false);
                    },
                  ),
                ),
              ),
            ),
            ..._contacts.map((contact) {
              return SliverToBoxAdapter(
                child: ListTile(
                    leading:
                        (contact.avatar != null && contact.avatar!.isNotEmpty)
                            ? CircleAvatar(
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)])
                            : CircleAvatar(
                                child: Text(contact.initials()),
                                backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              ),
                    title: Text(contact.displayName ?? ''),
                    trailing: IconButton(
                        onPressed: () {
                          print(contact.phones.first.value.toString());
                          _makePhoneCall(contact.phones.first.value.toString());
                        },
                        icon: Icon(CupertinoIcons.phone_down_circle,
                            size: 28.sp, color: Colors.green))),
              );
            }),
          ],
        ),
      ),
    );
  }

  void contactOnDeviceHasBeenUpdated(Contact contact) {
    setState(() {
      var id = _contacts.indexWhere((c) => c.identifier == contact.identifier);
      _contacts[id] = contact;
    });
  }

  Future<void> _makePhoneCall(String url) async {
    String _url = "tel:$url";
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      Get.snackbar("Appeler", "impossible de lancer ce appel");
    }
  }
}
