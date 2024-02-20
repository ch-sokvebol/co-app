import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/colors/app_color.dart'; // ADD

class WebViewAppScreen extends StatefulWidget {
  final String? title;
  final String? url;
  const WebViewAppScreen({super.key, this.url, this.title});

  @override
  State<WebViewAppScreen> createState() => _WebViewAppScreenState();
}

class _WebViewAppScreenState extends State<WebViewAppScreen> {
  Future<void> protectorSceen() async {
    await ScreenProtector.preventScreenshotOn();
  }

  // Add from here...
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    protectorSceen();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('${widget.url}'),
      );
  }

  // ...to here.
  @override
  void dispose() {
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('${widget.title}'),
          backgroundColor: AppColors.logolightGreen,
        ),
        body: WebViewWidget(
          controller: controller,
        ), // MODIFY
      ),
    );
  }
}
