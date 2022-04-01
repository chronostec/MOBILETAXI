// import 'package:alfred_taxi_driver/app/modules/rechargement/views/people_contact_list;.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:get/get.dart';
// import 'package:logging/logging.dart';
// import 'package:logging_config/logging_config.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ContacterParticulier extends StatefulWidget {
//   @override
//   _ContacterParticulierState createState() => _ContacterParticulierState();

//   const ContacterParticulier();
// }

// class _ContacterParticulierState extends State<ContacterParticulier> {
//   bool? _hasPermission;
//   @override
//   void initState() {
//     super.initState();
//     _askPermissions();
//   }

//   Future<void> _askPermissions() async {
//     PermissionStatus? permissionStatus;
//     while (permissionStatus != PermissionStatus.granted) {
//       try {
//         permissionStatus = await _getContactPermission();
//         if (permissionStatus != PermissionStatus.granted) {
//           _hasPermission = false;
//           _handleInvalidPermissions(permissionStatus);
//         } else {
//           _hasPermission = true;
//         }
//       } catch (e) {
//         if (await showPlatformDialog(
//                 context: context,
//                 builder: (context) {
//                   return PlatformAlertDialog(
//                     title: const Text('Contact Permissions'),
//                     content: const Text(
//                         'We are having problems retrieving permissions.  Would you like to '
//                         'open the app settings to fix?'),
//                     actions: [
//                       PlatformDialogAction(
//                         onPressed: () {
//                           Navigator.pop(context, false);
//                         },
//                         child: const Text('Close'),
//                       ),
//                       PlatformDialogAction(
//                         onPressed: () async {
//                           await openAppSettings();
//                         },
//                         child: const Text('Settings'),
//                       ),
//                     ],
//                   );
//                 }) ==
//             true) {
//           await openAppSettings();
//         }
//       }
//     }

//     // await Get.to(() => PeopleListPage());
//   }

//   Future<PermissionStatus> _getContactPermission() async {
//     final status = await Permission.contacts.status;
//     if (!status.isGranted) {
//       final result = await Permission.contacts.request();
//       return result;
//     } else {
//       return status;
//     }
//   }

//   void _handleInvalidPermissions(PermissionStatus permissionStatus) {
//     if (permissionStatus == PermissionStatus.denied) {
//       throw PlatformException(
//           code: 'PERMISSION_DENIED',
//           message: 'Access to location data denied',
//           details: null);
//     } else if (permissionStatus == PermissionStatus.restricted) {
//       throw PlatformException(
//           code: 'PERMISSION_DISABLED',
//           message: 'Location data is not available on device',
//           details: null);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('Appeler un particulier')),
//         body: const PeopleListPage());
//   }
// }
