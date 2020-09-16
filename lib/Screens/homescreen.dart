import 'dart:io';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:edu_app/Screens/account_info.dart';
import 'package:edu_app/Screens/subjects.dart';
import 'package:edu_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Screens/notices.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  int currentIndex;

  @override
  void initState() {
    super.initState();

    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Do you want to quit the app?",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
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
                onPressed: () => exit(0),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "EDUAPP",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
          )),
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 5.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return YellowBird();
                      },
                    ),
                  );
                },
                child: Icon(
                  Icons.notifications_active,
                  size: 26.0,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[100],
        bottomNavigationBar: BubbleBottomBar(
          opacity: 0.2,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
          currentIndex: currentIndex,
          hasInk: true,
          inkColor: Colors.black12,
          hasNotch: true,
          onTap: changePage,
          iconSize: 20.0,
          items: [
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text('SignUp'),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.folder_open,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.folder_open,
                color: Colors.indigo,
              ),
              title: Text('SignIn'),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.access_time,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.access_time,
                color: Colors.deepPurple,
              ),
              title: Text('Log'),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.book,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.book,
                color: Colors.red,
              ),
              title: Text('Notes'),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.perm_identity,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.perm_identity,
                color: Colors.red,
              ),
              title: Text('Account'),
            ),
          ],
        ),
        body: (currentIndex == 0)
            ? Icon(
                Icons.dashboard,
                size: 150.0,
                color: Colors.deepPurple,
              )
            : (currentIndex == 1)
                ? Icon(
                    Icons.folder_open,
                    size: 150.0,
                    color: Colors.deepPurple,
                  )
                : (currentIndex == 2)
                    ? Icon(
                        Icons.access_time,
                        size: 150.0,
                        color: Colors.deepPurple,
                      )
                    : (currentIndex == 3)
                        ? Subject()
                        :
                        // : FlatButton(
                        //     onPressed: () async {
                        //       SharedPreferences prefs =
                        //           await SharedPreferences.getInstance();
                        //       prefs.remove('email');
                        //       _auth.signOut();
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) {
                        //             return WelcomeScreen();
                        //           },
                        //         ),
                        //       );
                        //     },
                        //     child: Icon(
                        //       Icons.chat,
                        //       size: 150.0,
                        //       color: Colors.deepPurple,
                        //     ),
                        //   ),
                        AccountDetail(),
      ),
    );
  }
}
