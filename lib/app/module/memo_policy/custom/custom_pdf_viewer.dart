import 'dart:async';
import 'dart:io';

import 'package:chokchey_finance/app/module/memo_policy/screen/pdf_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class CustomPdfViewer extends StatefulWidget {
  CustomPdfViewer({
    super.key,
  });
  @override
  _CustomPdfViewerState createState() => _CustomPdfViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  late PDFViewController pdfViewController;
  String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  String corruptedPathPDF = "";

  @override
  void initState() {
    super.initState();
    fromAsset('assets/pdf/oraccccccc.pdf', 'oraccccccc.pdf').then((f) {
      setState(() {
        corruptedPathPDF = f.path;
      });
    });
    fromAsset('assets/pdf/oraccccccc.pdf', 'oraccccccc.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
    fromAsset('assets/pdf/oraccccccc.pdf', 'oraccccccc.pdf').then((f) {
      setState(() {
        landscapePathPdf = f.path;
      });
    });

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(child: Builder(
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              TextButton(
                child: Text("Open PDF"),
                onPressed: () {
                  if (pathPDF.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFScreen(path: pathPDF),
                      ),
                    );
                  }
                },
              ),
              TextButton(
                child: Text("Open Landscape PDF"),
                onPressed: () {
                  if (landscapePathPdf.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFScreen(path: landscapePathPdf),
                      ),
                    );
                  }
                },
              ),
              TextButton(
                child: Text("Remote PDF"),
                onPressed: () {
                  if (remotePDFpath.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFScreen(path: remotePDFpath),
                      ),
                    );
                  }
                },
              ),
              TextButton(
                child: Text("Open Corrupted PDF"),
                onPressed: () {
                  if (pathPDF.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFScreen(path: corruptedPathPDF),
                      ),
                    );
                  }
                },
              )
            ],
          );
        },
      )),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("My PDF Document"),
    //   ),
    //   body: PDFView(
    //     filePath: 'assets/pdf/oraccccccc.pdf',
    //     // autoSpacing: true,
    //     // enableSwipe: true,
    //     // pageSnap: true,
    //     // swipeHorizontal: true,
    //     onError: (error) {
    //       print(error);
    //     },
    //     onPageError: (page, error) {
    //       print('$page: ${error.toString()}');
    //     },
    //     onViewCreated: (PDFViewController vc) {
    //       setState(() {
    //         pdfViewController = vc;
    //       });
    //     },
    //     onPageChanged: (int? page, int? total) {
    //       setState(() {
    //         print('page change: $page/$total');
    //       });
    //     },
    //   ),
    // );
  }
}
