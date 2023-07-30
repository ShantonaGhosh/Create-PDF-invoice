import 'dart:io';

import 'package:create_pdf_invoice/utils/url_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> genaratedPdf(final PdfPageFormat format) async {
  final doc = pw.Document(title: 'Flutter School');
  final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/icons.png')).buffer.asUint8List());
  final footerImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/icons.png')).buffer.asUint8List());

  final pageTheme = await _myPageTheme(format);
  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      header: (final context) => pw.Image(
          alignment: pw.Alignment.topLeft,
          logoImage,
          fit: pw.BoxFit.contain,
          width: 100),
      footer: (final context) => pw.Image(
          alignment: pw.Alignment.topLeft,
          footerImage,
          fit: pw.BoxFit.scaleDown),
      build: (context) => [
        pw.Container(
          padding: pw.EdgeInsets.only(left: 30, right: 30),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 20),
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    children: [
                      pw.Text('Phone : '),
                      pw.Text('Email : '),
                      pw.Text('Instagrame : '),
                    ],
                  ),
                  pw.SizedBox(width: 70),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('0156524369 '),
                      UrlText('myFlutterSchool', 'flutterschool@gmail.com'),
                      UrlText(
                          'myFlutterTutorials', 'fluttertuitorials@gmail.com'),
                    ],
                  ),
                  pw.SizedBox(width: 70),
                  pw.BarcodeWidget(
                    barcode: pw.Barcode.qrCode(),
                    data: 'Flutter School',
                    height: 40,
                    width: 40,
                    drawText: false,
                  ),
                  pw.Padding(padding: pw.EdgeInsets.zero),
                ],
              ),
            ],
          ),
        ),
        pw.Center(
          child: pw.Text('in the name of GOD',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 20)),
        ),
        pw.Paragraph(
          margin: pw.EdgeInsets.only(top: 20),
          text: bodyText,
          style: pw.TextStyle(

            lineSpacing: 8, fontSize: 16),
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/icons.png')).buffer.asUint8List());
  return pw.PageTheme(
    margin: pw.EdgeInsets.symmetric(
      horizontal: 1 * PdfPageFormat.cm,
      vertical: 0.5 * PdfPageFormat.cm,
    ),
    textDirection: pw.TextDirection.ltr,
    orientation: pw.PageOrientation.portrait,
    buildBackground: (final context) => pw.FullPage(
      ignoreMargins: true,
      child: pw.Watermark(
        angle: 20,
        child: pw.Opacity(
          opacity: 0.5,
          child: pw.Image(
              alignment: pw.Alignment.center, logoImage, fit: pw.BoxFit.cover),
        ),
      ),
    ),
  );
}

Future<void> saveAsFile(
  final BuildContext context,
  final LayoutCallback build,
  final PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/shantona.pdf');
  print('save as file.......${file.path}');
  await file.writeAsBytes(bytes);
 await OpenFile.open(file.path);
}


// Future<void> saveAsPDF(String content, String fileName) async {
//   final pdf = pw.Document();
//   pdf.addPage(pw.Page(
//     build: (pw.Context context) {
//       return pw.Center(
//         child: pw.Text(content),
//       );
//     },
//   ));
//   final outputDir = await getApplicationDocumentsDirectory();
//   final outputFile = File('${outputDir.path}/$fileName.pdf');

//   await outputFile.writeAsBytes(await pdf.save());
// }










void ShowPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document printed successfully')));
}

void ShowSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document shared successfully')));
}

final String bodyText ='But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure';
    
