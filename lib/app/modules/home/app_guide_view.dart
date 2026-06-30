import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/config/translations/strings_enum.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AppGuideScreen extends StatefulWidget {
  const AppGuideScreen({super.key});

  @override
  State<AppGuideScreen> createState() => _AppGuideScreenState();
}

class _AppGuideScreenState extends State<AppGuideScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appGuide.tr),
      ),
      body: SfPdfViewer.asset(
        'assets/pdfs/appguide.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}
