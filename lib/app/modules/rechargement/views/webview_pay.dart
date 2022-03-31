import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class WebViewPay extends StatefulWidget {
  const WebViewPay({Key? key}) : super(key: key);

  @override
  State<WebViewPay> createState() => _WebViewPayState();
}

class _WebViewPayState extends State<WebViewPay> {
  WebViewPlusController? _controller;
  double _height = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Effectuer un rechargement",
            style: TextStyle(fontSize: 13.sp)),
        // leading: const SizedBox(),
        // actions: [
        //   IconButton(
        //       onPressed: () => Get.back(),
        //       icon: const Icon(CupertinoIcons.clear_fill))
        // ],
      ),
      body: SizedBox(
        height: _height,
        child: WebViewPlus(
          serverPort: 5353,
          javascriptChannels: null,
          initialUrl: 'www.stackoverflow.com',
          onWebViewCreated: (controller) {
            _controller = controller;
            controller.loadUrl('https://pub.dev/packages/webview_flutter_plus');
          },
          onPageFinished: (url) {
            _controller?.getHeight().then((double height) {
              debugPrint("Height: " + height.toString());
              setState(() {
                _height = height;
              });
            });
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
