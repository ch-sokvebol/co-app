// ignore_for_file: must_be_immutable

import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SfPdfViewerScreen extends StatefulWidget {
  SfPdfViewerScreen({super.key});

  @override
  State<SfPdfViewerScreen> createState() => _SfPdfViewerScreenState();
}

class _SfPdfViewerScreenState extends State<SfPdfViewerScreen> {
  @override
  void initState() {
    pdfViewerController = PdfViewerController();
    super.initState();
  }

  PdfViewerController? pdfViewerController;
  double zoomPercentage = 100;
  int totalPages = 0;
  int currentPageNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: logolightGreen,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          '$currentPageNumber/$totalPages Sf PDF Viewer $zoomPercentage%',
        ),
      ),
      body: SfPdfViewerTheme(
        data: SfPdfViewerThemeData(backgroundColor: Colors.white),
        child: SfPdfViewer.asset(
          'assets/pdf/oop.pdf',
          pageSpacing: 1,
          controller: pdfViewerController,
          onPageChanged: (PdfPageChangedDetails details) {
            setState(() {
              currentPageNumber = details.newPageNumber;
            });
          },
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            setState(() {
              totalPages = details.document.pages.count;
            });
          },
          onZoomLevelChanged: (PdfZoomDetails details) {
            setState(() {
              zoomPercentage = details.newZoomLevel * 100;
            });
          },
        ),
      ),
    );
  } //
}
