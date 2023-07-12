
import 'package:flutter/material.dart';
import 'package:order/screen/new_order.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewData extends StatefulWidget {
  final String url;
  const WebViewData({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewData> createState() => _WebViewDataState();
}

class _WebViewDataState extends State<WebViewData> {



  var controller;

  @override
  void initState() {
    super.initState();
     controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://${widget.url}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewOrder(url: widget.url),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        body: WebViewWidget(controller: controller));
  }
}
