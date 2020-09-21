import 'dart:io';
import 'package:edu_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfPath;
  final String pdfname;
  PdfViewerPage({@required this.pdfPath, @required this.pdfname});
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String urlPDFPath;
  bool showSpinner = true;

  @override
  void initState() {
    super.initState();

    getFileFromUrl(widget.pdfPath).then((f) {
      setState(() {
        urlPDFPath = f.path;
        showSpinner = false;
        print(urlPDFPath);
      });
    });
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: AppBar(
            title: Text("EDUAPP NOTES"),
          ),
          body: Center(
            child: Builder(
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/pdflogo.png",
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      widget.pdfname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    color: Colors.amber,
                    child: Text(
                      "Read Online",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (urlPDFPath != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PdfViewPage(path: urlPDFPath)));
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text("Download PDF!"),
                    onPressed: () async {
                      final status = await Permission.storage.request();

                      if (status.isGranted) {
                        final externalDir = await getExternalStorageDirectory();

                        final id = await FlutterDownloader.enqueue(
                          url: widget.pdfPath,
                          savedDir: externalDir.path,
                          fileName: widget.pdfname + ".pdf",
                          showNotification: true,
                          openFileFromNotification: true,
                        );
                        if (id != null) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(
                                seconds: 3,
                                milliseconds: 500,
                              ),
                              content: Text(
                                "Download Completed\nFile saved at android/data/com.eduapp",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              backgroundColor: kPrimaryColor,
                            ),
                          );
                        }
                      } else {
                        print("hello");
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            fitPolicy: FitPolicy.BOTH,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
        ],
      ),
    );
  }
}
