import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String url;

  WebViewWidget({Key key, this.url}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  String title = '';
  WebViewController webViewController;

  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
        name: 'jsBridge',
        onMessageReceived: (JavascriptMessage message) async {
          debugPrint(message.message);
        },
      );

  _buildAppbar() {
    return AppBar(
      centerTitle: true,
      title: Text(this.title),
    );
  }

  _buildBody() {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: <JavascriptChannel>[jsBridge(context)].toSet(),
      onWebViewCreated: (WebViewController controller) {
        this.webViewController = controller;
        controller.loadUrl(widget.url);
        controller.canGoBack().then((value) => debugPrint(value.toString()));
        controller.canGoForward().then((value) => debugPrint(value.toString()));
        controller.currentUrl().then((value) => debugPrint(value));
      },
      onPageFinished: (String value) {
        webViewController.evaluateJavascript('document.title').then((title) {
          title = title.substring(1, title.length - 1);
          this.title = title;
          debugPrint(title);
          setState(() {});
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(), body: _buildBody());
  }
}

class WebViewPage extends StatefulWidget {
  final arguments;
  WebViewPage({Key key, this.arguments}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      // url: 'http://192.168.0.105:3000/v1/work/preview?id=123461',
      // title: 'weview',
      url: widget.arguments['url'],
    );
  }
}
