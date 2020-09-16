import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class ViewPdf extends StatefulWidget {
  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context).settings.arguments;
    print(data);
    return Scaffold(
      body: Center(
        child: PDF.network(
          data,
          height: 700,
          width: 500,
        ),
      ),
    );
  }
}
