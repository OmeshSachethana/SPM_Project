import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GameReport extends StatefulWidget {
  DocumentSnapshot docid;
  GameReport({required this.docid});
  @override
  State<GameReport> createState() => _GameReportState(docid: docid);
}

class _GameReportState extends State<GameReport> {
  DocumentSnapshot docid;
  _GameReportState({required this.docid});
  final pdf = pw.Document();
  var name;
  var description;
  var imageURL;
  var clicks;

  
  void initState() {
    setState(() {
      name = widget.docid.get('name');
      description = widget.docid.get('description');
      imageURL = widget.docid.get('imageURL');
      clicks = widget.docid.get('clicks');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      // maxPageWidth: 1000,
      // useActions: false,
      // canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.sansitaBoldItalic();
    // final image = await imageFromAssetBundle('assets/r2.svg');

    String? _logo = await rootBundle.loadString('lib/images/LOGO.svg');

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,

        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Flexible(
                child: pw.SvgImage(
                  svg: _logo,
                  height: 400,
                ),
              ),
              pw.SizedBox(
                height: 10,
              ),
			  
              pw.Center(
                child: pw.Text(
                  'Game Details',
                  style: pw.TextStyle(
                    fontSize: 50,
                    font:font2,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Name : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                      font: pw.Font.courierBold()
                    ),
                  ),
                  pw.Text(
                    name,
                    style: pw.TextStyle(
                      fontSize: 25,
                      font: font1
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    'Description & Instructions ',
                    style: pw.TextStyle(
                      fontSize: 30,
                      font: pw.Font.courierBold()
                    ),
                  ),
                  pw.Text(
                    description,
                    style: pw.TextStyle(
                      fontSize: 25,
                      font: font1
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 20,
              ),
              			  pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'No of Clicks : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                      font: pw.Font.courierBold()
                    ),
                  ),
                  pw.Text(
                    clicks.toString(),
                    style: pw.TextStyle(
                      fontSize: 25,
                      font: font1
                    ),
                  ),
                ],
              ),
              
              
            ],
          ));
        },
      ),
    );

    return doc.save();
  }
}