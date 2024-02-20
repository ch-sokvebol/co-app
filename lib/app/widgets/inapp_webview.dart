import 'package:chokchey_finance/app/utils/colors/app_color.dart';
import 'package:chokchey_finance/app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebviewScreen extends StatefulWidget {
  final String? url, title;
  const InAppWebviewScreen({super.key, this.url, this.title});

  @override
  State<InAppWebviewScreen> createState() => _InAppWebviewScreenState();
}

class _InAppWebviewScreenState extends State<InAppWebviewScreen> {
  InAppWebViewController? webViewController;
  String url = "";
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        backgroundColor: AppColors.logolightGreen,
        title: '${widget.title}',
      ),
      body: Column(children: <Widget>[
        // Container(
        //   padding: const EdgeInsets.all(20.0),
        //   child: Text(
        //       "CURRENT URL\n${(url.length > 50) ? "${url.substring(0, 50)}..." : url}"),
        // ),
        Container(
            // padding: const EdgeInsets.all(10.0),
            child: progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container()),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10.0),
            // decoration:
            //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse('${widget.url}')),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
      ]),
    );
  }
}
