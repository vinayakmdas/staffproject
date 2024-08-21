import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
class PdfViewerScreen extends StatelessWidget {
  final File pdfFile;

  const PdfViewerScreen({Key? key, required this.pdfFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfController(
      document: PdfDocument.openFile(pdfFile.path),
    );

    return Scaffold(
    
      body: PdfView(
        controller: pdfController,
      ),
    );
  }
}
