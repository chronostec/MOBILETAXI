import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:webviewx/webviewx.dart';

import 'helpers.dart';

class PaiementWebviewPage extends StatefulWidget {
  const PaiementWebviewPage({Key? key}) : super(key: key);

  @override
  State<PaiementWebviewPage> createState() => _PaiementWebviewPageState();
}

class _PaiementWebviewPageState extends State<PaiementWebviewPage> {
  late WebViewXController webviewController;
  final initialContent =
      '<h2>Chargement en cours<h2> <h4>Veuuillez patienter pendant que la page de paiement se recharge<h4>';

  Size get screenSize => MediaQuery.of(context).size;
  String urlpage = 'https://flutter.dev';

  @override
  void initState() {
    urlpage = ctlReversement.urlPaiement.value;
    super.initState();
  }

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            buildSpace(direction: Axis.vertical, amount: 10.0, flex: false),
            Container(
              // height: 90.h,
              margin: const EdgeInsets.only(bottom: 32),
              child: ListView(
                children: [
                  _buildWebViewX(),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: InkWell(
            //     onTap: () {
            //       Get.back();
            //       // Get.back();
            //     },
            //     child: Container(
            //       height: 10.h,
            //       color: Colors.deepOrange,
            //       child: const Center(
            //         child: Text(
            //           "TERMINER",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 28,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('mesabo'),
      initialContent: initialContent,
      initialSourceType: SourceType.html,
      height: 100.h,
      width: 100.w,
      onWebViewCreated: (controller) {
        webviewController = controller;
        _setUrl();
      },
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) =>
          debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },
      dartCallBacks: {
        DartCallback(
          name: 'TestDartCallback',
          callBack: (msg) => showSnackBar(msg.toString(), context),
        )
      },
      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }

  void _setUrl() {
    webviewController.loadContent(
      urlpage,
      SourceType.url,
    );
  }

  void _setHtml() {
    webviewController.loadContent(
      initialContent,
      SourceType.html,
    );
  }

  Widget buildSpace({
    Axis direction = Axis.horizontal,
    double amount = 0.2,
    bool flex = true,
  }) {
    return flex
        ? Flexible(
            child: FractionallySizedBox(
              widthFactor: direction == Axis.horizontal ? amount : null,
              heightFactor: direction == Axis.vertical ? amount : null,
            ),
          )
        : SizedBox(
            width: direction == Axis.horizontal ? amount : null,
            height: direction == Axis.vertical ? amount : null,
          );
  }
}
