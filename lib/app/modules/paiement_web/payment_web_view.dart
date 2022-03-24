// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaiementWeb extends StatefulWidget {
  const PaiementWeb({Key? key, required this.url}) : super(key: key);

  final String url;
  @override
  _PaiementWebState createState() => _PaiementWebState();
}

class _PaiementWebState extends State<PaiementWeb> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String _url = "www.google.ci";
  @override
  void initState() {
    ctlMapCourse.ISWEBVIEW.value = true;
    _url = widget.url;
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  int _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Builder(builder: (BuildContext context) {
              return WebView(
                initialUrl: '$_url',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) async {
                  setState(() {
                    _progress = progress;
                    if (_progress < 80) {
                      ctlMapCourse.ISCHARGING.value = true;
                    } else {
                      ctlMapCourse.ISCHARGING.value = false;
                    }
                  });
                  print('WebView is loading (progress : $progress%)');
                },
                javascriptChannels: <JavascriptChannel>{
                  _toasterJavascriptChannel(context),
                },
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('encore : $_progress%)');
                  // ctlMapCourse.ISCHARGING.value == true
                  //     ? showEndedCoursetDialog(context: context)
                  //     : null;
                  ctlMapCourse.ISWEBVIEW.value = true;
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
                backgroundColor: Colors.white,
              );
            }),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 10.h,
              color: Colors.deepOrange,
              child: const Center(
                child: Text(
                  "TERMINER",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  //
}

Future<void> _onShowUserAgent(
    WebViewController controller, BuildContext context) async {
  // Send a message with the user agent string to the Toaster JavaScript channel we registered
  // with the WebView.
  await controller.runJavascript(
      'Toaster.postMessage("User Agent: " + navigator.userAgent);');
}

Future<void> _onListCookies(
    WebViewController controller, BuildContext context) async {
  final String cookies =
      await controller.runJavascriptReturningResult('document.cookie');
  // ignore: deprecated_member_use
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Cookies:'),
        _getCookieList(cookies),
      ],
    ),
  ));
}

Future<void> _onAddToCache(
    WebViewController controller, BuildContext context) async {
  await controller.runJavascript(
      'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
  Scaffold.of(context).showSnackBar(const SnackBar(
    content: Text('Added a test entry to cache.'),
  ));
}

Future<void> _onListCache(
    WebViewController controller, BuildContext context) async {
  await controller.runJavascript('caches.keys()'
      '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
      '.then((caches) => Toaster.postMessage(caches))');
}

Future<void> _onClearCache(
    WebViewController controller, BuildContext context) async {
  await controller.clearCache();
  // ignore: deprecated_member_use
  Scaffold.of(context).showSnackBar(const SnackBar(
    content: Text('Cache cleared.'),
  ));
}

Future<void> _onSetCookie(
    WebViewController controller, BuildContext context) async {
  await CookieManager().setCookie(
    const WebViewCookie(
        name: 'foo', value: 'bar', domain: 'httpbin.org', path: '/anything'),
  );
  await controller.loadUrl('https://httpbin.org/anything');
}

Future<void> _onDoPostRequest(
    WebViewController controller, BuildContext context) async {
  final WebViewRequest request = WebViewRequest(
    uri: Uri.parse('https://httpbin.org/post'),
    method: WebViewRequestMethod.post,
    headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
    body: Uint8List.fromList('Test Body'.codeUnits),
  );
  await controller.loadRequest(request);
}

Future<void> _onLoadFlutterAssetExample(
    WebViewController controller, BuildContext context) async {
  await controller.loadFlutterAsset('assets/www/index.html');
}

Widget _getCookieList(String cookies) {
  if (cookies == null || cookies == '""') {
    return Container();
  }
  final List<String> cookieList = cookies.split(';');
  final Iterable<Text> cookieWidgets =
      cookieList.map((String cookie) => Text(cookie));
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: cookieWidgets.toList(),
  );
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoBack()) {
                        await controller.goBack();
                      } else {
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text('No back history item')),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoForward()) {
                        await controller.goForward();
                      } else {
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('No forward history item')),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.replay, color: Colors.black),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller!.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
