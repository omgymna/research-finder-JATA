import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatefulWidget {
  final String course, file;
  const PDFScreen({super.key, required this.course, required this.file});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {

  String localPath = '';

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    debugPrint("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = widget.file;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      debugPrint("Download files");
      debugPrint("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((value){
      setState(() {
        localPath = value.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course),
      ),
      body:  localPath.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PDFView(
        filePath: localPath,
        autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        swipeHorizontal: false,
        fitEachPage: true,
        fitPolicy: FitPolicy.BOTH,
        nightMode: false,
        onError: (e) {
          debugPrint('error in loadIn $e');
        },
        onRender: (pages) {
          setState(() {

          });
        },
        onViewCreated: (PDFViewController vc) {
          setState(() {

          });
        },
        onPageChanged: (page, total) {

        },
        onPageError: (page, e) {},
      ),
    );
  }
}
