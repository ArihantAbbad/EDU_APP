import 'package:edu_app/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_app/components/notice_detail.dart';

final _firestore = FirebaseFirestore.instance;

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key key}) : super(key: key);
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final messageTextController = TextEditingController();
  final messageTextController1 = TextEditingController();
  String ntitle;
  String nmessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notice"),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_backspace)),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                      child: Text(
                        'New Notice',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50.0,
                            letterSpacing: 3.5), //textstyle
                      ), //text
                    ), //container
                  ), //center
                ], //stack widget
              ), //stack

              Container(
                padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        ntitle = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'TITLE',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.black,
                          fontSize: 15.0,
                        ), //textstyle
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[400])), //inputborder
                      ), //inputdecoration
                    ), //textfield
                    SizedBox(height: 30.0), //sizedbox
                    TextField(
                      controller: messageTextController1,
                      onChanged: (value) {
                        nmessage = value;
                      },
                      autofocus: true,
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: 'NOTICE',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.black,
                          fontSize: 15.0,
                        ), //textstyle
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[400])), //inputborder
                      ), //inputdecoration
                    ), //textfield
                  ], //column widget
                ), //column
              ), //container
              SizedBox(height: 50.0),
              Center(
                child: RoundedButton(
                  press: () {
                    messageTextController.clear();
                    messageTextController1.clear();
                    if (ntitle != null && nmessage != null) {
                      _firestore.collection('notices').add({
                        'title': ntitle,
                        'message': nmessage,
                      });
                      Navigator.pop(context);
                    } else if (ntitle == null) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Title can't be empty!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          backgroundColor: kPrimaryColor,
                        ),
                      );
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Notice can't be empty!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          backgroundColor: kPrimaryColor,
                        ),
                      );
                    }
                  },
                  text: "Send Notice",
                ),
              ), //container
            ], //column widget
          ),
        ),
      ), //column
    );
  }
}

class YellowBird extends StatefulWidget {
  const YellowBird({Key key}) : super(key: key);

  @override
  _YellowBirdState createState() => _YellowBirdState();
}

class _YellowBirdState extends State<YellowBird> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("EDUAPP NOTICES"),
          backgroundColor: kPrimaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.keyboard_backspace)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return NoticeScreen();
                },
              ),
            );
          },
          child: Icon(Icons.add_box),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Center(
              child: Container(
                child: ColorizeAnimatedTextKit(
                    text: [
                      "Notice Board",
                    ],
                    textStyle: TextStyle(
                        fontSize: 50.0,
                        fontFamily: "Horizon",
                        fontWeight: FontWeight.bold),
                    colors: [
                      Colors.black,
                      Colors.purple,
                      Colors.blue,
                      Colors.green,
                      Colors.pink,
                      Colors.lightGreenAccent,
                      Colors.red,
                    ],
                    speed: Duration(seconds: 1, milliseconds: 300),
                    textAlign: TextAlign.start,
                    repeatForever: true,
                    alignment:
                        AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              ),
            ), //container
            NoticeStreams(),
          ], //widget//smal conta
        ),
      ), //scaffold
    );
  }
}

class NoticeStreams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('notices').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final notices = snapshot.data.docs.reversed;
        List<NoticeTile> noticetiles = [];
        for (var notice in notices) {
          final title = notice.data()['title'];
          final messag = notice.data()['message'];
          var id = notice.id;
          final noticetile = NoticeTile(title: title, message: messag, id: id);
          noticetiles.add(noticetile);
        }
        return Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            children: noticetiles,
          ),
        );
      },
    );
  }
}

class NoticeTile extends StatelessWidget {
  final String title;
  final String message;
  final id;
  NoticeTile({@required this.title, @required this.message, this.id});
  @override
  Widget build(BuildContext context) {
    String mintil;
    void getminiMsg() {
      if (title.length > 25) {
        mintil = title.substring(0, 25) + "..";
      } else {
        mintil = title;
      }
    }

    getminiMsg();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 30),
        GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  "Do you want to Delete the notice?",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                actions: <Widget>[
                  FlatButton(
                    hoverColor: Colors.grey,
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  FlatButton(
                    hoverColor: Colors.grey,
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      await _firestore
                          .collection("notices")
                          .doc(id)
                          .delete()
                          .then((_) {});
                      Navigator.pop(context, false);
                    },
                  ),
                ],
              ),
            );
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Noticedetail(
                    head: title,
                    body: message,
                  );
                },
              ),
            );
          },
          child: Container(
            //color:Colors.blueGrey[100],
            decoration: BoxDecoration(
              boxShadow: [
                //color: Colors.white, //background color of box
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    10.0, // Move to right 10  horizontally
                    10.0, // Move to bottom 10 Vertically
                  ),
                ),
              ], //shadow
              color: Color(0xffcaf0f8),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Noticedetail(
                          head: title,
                          body: message,
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),

                  child: Column(
                    children: <Widget>[
                      Text(
                        mintil,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tap to view complete Notice!",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ), //text
                ), //padding
              ),
            ), //smal container
            height: 100,
          ),
        ),
      ],
    );
  }
}
