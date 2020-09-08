import 'dart:async';
import 'package:edu_app/Screens/Welcome/welcome_screen.dart';
import 'package:edu_app/Screens/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Future<void> getnextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (email == null) {
            return WelcomeScreen();
          } else {
            return HomePage();
          }
        },
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 4), () {
      getnextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.10),
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: size.height * 0.45,
          ),
          SizedBox(height: size.height * 0.10),
          Center(
            child: ColorizeAnimatedTextKit(
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "EDU APP",
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
                totalRepeatCount: 1,
                speed: Duration(seconds: 1, milliseconds: 300),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                ),
          ),
          SizedBox(height: size.height * 0.02),
          TypewriterAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: [
                "Place where all your doubts get cleared!",
              ],
              totalRepeatCount: 1,
              textStyle: TextStyle(fontSize: 16.0, fontFamily: "Agne"),
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
        ],
      ),
    );
  }
}
