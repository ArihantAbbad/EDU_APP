import 'package:flutter/material.dart';
import 'package:edu_app/Screens/Welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class AccountDetail extends StatefulWidget {
  @override
  _AccountDetailState createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  @override
  String uemail = " ";
  String uname = " ";
  String uphone = " ";
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');
      var phone = prefs.getString('phone');
      var name = prefs.getString('name');
      setState(() {
        uemail = email;
        uphone = phone;
        uname = name;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 300,
            color: Colors.pinkAccent,
          ), //container
          ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                width: 190.0,
                height: 190.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      //fit: BoxFit.fill,
                      image:
                          AssetImage('assets/images/profile.png')), //decoimage
                ), //boxdecoration
              ), //container
              SizedBox(height: 10),
              Center(
                //padding:EdgeInsets.symmetric(horizontal:25),
                child: Text(
                  uname,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                  ), //textstyle
                ), //text
              ), //center
              SizedBox(height: 40),
              Center(
                //padding:EdgeInsets.symmetric(horizontal:25),
                child: Text(
                  'EMAIL',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 25,
                    fontFamily: "Horizon",
                    fontWeight: FontWeight.w900,
                  ), //textstyle
                ), //text
              ), //center
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
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
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      //print("physics");
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),

                      child: Text(
                        uemail,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ), //text
                    ), //padding
                  ),
                ), //smal container
                height: 45,
              ),
              SizedBox(height: 20),
              Center(
                //padding:EdgeInsets.symmetric(horizontal:25),
                child: Text(
                  'PHONE',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 25,
                    fontFamily: "Horizon",
                    fontWeight: FontWeight.w900,
                  ), //textstyle
                ), //text
              ), //center
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
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
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      //print("physics");
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),

                      child: Text(
                        uphone,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ), //text
                    ), //padding
                  ),
                ), //smal container
                height: 45,
              ),

              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.fromLTRB(250, 0, 20, 0),
                //color:Colors.blueGrey[100],
                decoration: BoxDecoration(
                  boxShadow: [
                    //color: Colors.white, //background color of box
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    ),
                  ], //shadow
                  color: Colors.redAccent[400],
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Container(
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('email');
                      prefs.remove('phone');
                      prefs.remove('name');
                      _auth.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WelcomeScreen();
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),

                      child: Text(
                        'LOGOUT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ), //text
                    ), //padding
                  ),
                ), //smal container
                height: 45,
              ),
            ], //widget
          ), //listview
        ], //widget stack
      ), //stack
    );
  }
}
