import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewPage extends StatelessWidget {
  final String pdfUrl;

  PDFViewPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfUrl,
        autoSpacing: true,
        pageFling: true,
        pageSnap: true,
        defaultPage: 0,
        fitPolicy: FitPolicy.BOTH,
        onPageChanged: (int? current, int? total) {},
        onViewCreated: (PDFViewController pdfViewController) {},
        onError: (error) {
          print(error);
        },
        onPageError: (page, error) {
          print('$page: $error');
        },
      ),
    );
  }
}
