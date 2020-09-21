import 'package:edu_app/Pdf/pdf.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Subject extends StatefulWidget {
  const Subject({Key key}) : super(key: key);

  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            SizedBox(height: 30),
            Center(
              child: TextLiquidFill(
                text: 'HANDOUTS!',
                waveColor: Color(0xff000000),
                textStyle: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 100,
                boxBackgroundColor: Color(0xffecbcfd),
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PdfPage(
                          dbname: "Physics",
                          imgName: "phy",
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  child: Text(
                    'Physics',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 6,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ), //padding
              ),
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                image: DecorationImage(
                  image: AssetImage('assets/images/phy.jpg'),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                ), //decorationimage
              ), //box deco
            ), //smal conta
            SizedBox(height: 20),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PdfPage(
                          dbname: "Chemistry",
                          imgName: "chem",
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  child: Text(
                    'Chemistry',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 6,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                image: DecorationImage(
                  image: AssetImage('assets/images/chem.jpg'),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                ), //decorationimage
              ), //box deco
            ), //smal conta
            SizedBox(height: 20),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PdfPage(
                          dbname: "Maths",
                          imgName: "math",
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  child: Text(
                    'Maths',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 6,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                image: DecorationImage(
                  image: AssetImage('assets/images/math.jpg'),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                ), //decorationimage
              ), //box deco
            ), //smal conta
          ],
        ), //scaf
      ), //scaffold
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello, World!', style: Theme.of(context).textTheme.headline4);
  }
}
