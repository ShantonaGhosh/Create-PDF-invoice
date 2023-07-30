import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../utils/util.dart';



class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {

  PrintingInfo? printingInfo;
  
  @override
  void initState() {
  super.initState();
    _init();
  }

  Future<void> _init()async{
    final info =  await Printing.info();
    setState(() {
      printingInfo = info;
    });


  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final action =<PdfPreviewAction>[
    if(!kIsWeb)
 
    PdfPreviewAction(onPressed: saveAsFile ,icon: Icon(Icons.save))
    ];
    return Scaffold(
      //appBar: AppBar(title: Text('pdf'),),

      body:  PdfPreview(
        maxPageWidth: 700,
        actions: [],
        onPrinted:ShowPrintedToast ,
        onShared:ShowSharedToast,
         build: genaratedPdf
        ),



      
    );
  }



}