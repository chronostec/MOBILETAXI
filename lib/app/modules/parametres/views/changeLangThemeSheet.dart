import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// SHOW BOTTOM SHEET TO CHANGE LANGUAGE
Future<String?> showChangeLanguage(BuildContext context) {
  return showModalActionSheet<String>(
    context: context,
    title: 'Choisir une langue',
    message:
        'La langue actuelle est: ${ctlParametre.language.value.toUpperCase()}',
    actions: [
      const SheetAction(
        icon: Icons.language,
        label: 'Anglais',
        key: LANGUAGEKEY.ENGLISH,
      ),
      const SheetAction(
        icon: Icons.language,
        label: 'Français',
        key: LANGUAGEKEY.FRENCH,
      ),
      const SheetAction(
        icon: Icons.language,
        label: 'Espagnol',
        key: LANGUAGEKEY.SPANISH,
      ),
      const SheetAction(
        icon: Icons.language,
        label: 'Allemand',
        key: LANGUAGEKEY.GERMAN,
      ),
    ],
  );
}

/// SHOW BOTTOM SHEET TO CHANGE THEME
Future<String?> showChangeTheme(BuildContext context) {
  return showModalActionSheet<String>(
    context: context,
    title: 'Choisir une thème',
    message:
        'Le thème actuelle est: ${ctlParametre.apptheme.value.toUpperCase()}',
    actions: [
      const SheetAction(
        icon: FontAwesomeIcons.moon,
        label: 'Clair',
        key: THEMEKEY.LIGHT,
      ),
      const SheetAction(
        icon: FontAwesomeIcons.moon,
        label: 'Sombre',
        key: THEMEKEY.DARK,
      ),
    ],
  );
}
