import 'package:edu_app/constants.dart';
import 'package:flutter/material.dart';

class Noticedetail extends StatefulWidget {
  final String head;
  final String body;

  Noticedetail({@required this.head, @required this.body});
  @override
  _NoticedetailState createState() => _NoticedetailState();
}

class _NoticedetailState extends State<Noticedetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Notice!'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_backspace)),
      ), //appbar
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: ScrollController(
                  initialScrollOffset: 0.0,
                ), //scrollcontrol
                child: Text(
                  widget.head,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ), //textstyle
                ), //text
              ), //singlechildscrollview
            ), //center
          ), //ctext container
          //SizedBox(height:150),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xffcaf0f8),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ), //boxdeco
            height: 400,

            child: Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical, //.horizontal
                child: Text(
                  widget.body,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ), //textstyle
                ), //text
              ), //scroll
            ), //ctext container
          ), //container
        ], //widget
      ), //listviewscaffold
    );
  }
}
