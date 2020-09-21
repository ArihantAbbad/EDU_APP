import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:edu_app/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:edu_app/Pdf/Modal.dart';
import 'package:edu_app/Pdf/viewpdf.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

DatabaseReference mainReference = FirebaseDatabase.instance.reference();
List<Modal> itemList = List();

class Add extends StatefulWidget {
  final String dbename;
  const Add({Key key, @required this.dbename}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  Color color;
  String pdfName;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    color = Colors.pink[200];
  }

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Pdf"),
          backgroundColor: kPrimaryColor,
        ),
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) => ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Choose an PDF file format only',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )),

              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          pdfName = value;
                        });
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'TITLE',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.black,
                          fontSize: 13.0,
                        ), //textstyle
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[400])), //inputborder
                      ), //inputdecoration
                    ), //textfield
                  ], //column widget
                ), //column
              ), //container

              SizedBox(height: 70),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                height: 160.0,
                width: 80.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/pdflogo.png"),
                  ),
                  // shape: BoxShape.circle,
                ),
              ),
              SpinKitPumpingHeart(
                color: Colors.red,
                size: 50.0,
              ), //container
              SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  if (pdfName == null) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(
                          seconds: 3,
                          milliseconds: 500,
                        ),
                        content: Text(
                          "Name of pdf cant be empty!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        backgroundColor: kPrimaryColor,
                      ),
                    );
                  } else {
                    getPdfAndUpload();
                  }
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                      color: Colors.pink[300],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: InkWell(
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                            child: Icon(
                              Icons.file_upload,
                              color: Colors.white,
                              size: 25,
                            ), // icon is 48px widget.
                          ), //padding
                          Padding(
                              padding: EdgeInsets.only(
                                left: 50,
                              ),
                              child: Center(
                                child: Text(
                                  'Add File',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )), //center
                        ], //row widget
                      ), //row
                    ), //center
                  ), //inkwell
                ), //container
              ), //gesture
            ], //widget
          ),
        ), //listview
      ),
    );
  }

  Future getPdfAndUpload() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    File file = File(result.files.single.path);
    String fileName = '${pdfName}.pdf';
    setState(() {
      showSpinner = true;
    });
    savePdf(file.readAsBytesSync(), fileName);
  }

  savePdf(List<int> asset, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    documentFileUpload(url);
  }

  String CreateCryptoRandomString([int length = 32]) {
    final Random _random = Random.secure();
    var values = List<int>.generate(length, (i) => _random.nextInt(256));
    return base64Url.encode(values);
  }

  void documentFileUpload(String str) {
    var data = {
      "PDF": str,
      "FileName": pdfName,
    };
    mainReference
        .child(widget.dbename)
        .child(CreateCryptoRandomString())
        .set(data)
        .then((v) {
      print("Store Successfully");
    });
    setState(() {
      showSpinner = false;
      Navigator.pop(context);
    });
  }
}

class PdfPage extends StatefulWidget {
  final String dbname;
  final String imgName;
  PdfPage({@required this.dbname, @required this.imgName});
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    bool showSpin = false;
    return ModalProgressHUD(
      inAsyncCall: showSpin,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(widget.dbname),
        ),
        body: itemList.length == 0
            ? Container(
                child: Center(
                  child: Text("Loading"),
                ),
              )
            : ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          String passData = itemList[index].link;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewerPage(
                                pdfPath: passData,
                                pdfname: itemList[index].name,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/${widget.imgName}.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 120,
                                child: Card(
                                  color: Colors.amber,
                                  margin: EdgeInsets.all(30),
                                  elevation: 7.0,
                                  child: Center(
                                    child: Text(
                                      itemList[index].name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Add(
                    dbename: widget.dbname,
                  );
                },
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainReference
        .child(widget.dbname)
        .orderByPriority()
        .once()
        .then((DataSnapshot snap) {
      var data = snap.value;
      itemList.clear();
      data.forEach((key, value) {
        Modal m = new Modal(value['PDF'], value['FileName']);
        itemList.add(m);
      });
      setState(() {});
    });
  }
}
