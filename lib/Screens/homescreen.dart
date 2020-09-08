import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:edu_app/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Screens/Signup/signup_screen.dart';
import 'package:edu_app/Screens/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  int currentIndex;
  final _auth = FirebaseAuth.instance;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: Text('Test'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.chat,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.chat,
              color: Colors.red,
            ),
            title: Text('Chat'),
          ),
        ],
      ),
      body: (currentIndex == 0)
          ? SignUpScreen()
          : (currentIndex == 1)
              ? LoginScreen()
              : (currentIndex == 2)
                  ? Icon(
                      Icons.access_time,
                      size: 150.0,
                      color: Colors.deepPurple,
                    )
                  : (currentIndex == 3)
                      ? Icon(
                          Icons.book,
                          size: 150.0,
                          color: Colors.deepPurple,
                        )
                      : FlatButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('email');
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
                          child: Icon(
                            Icons.chat,
                            size: 150.0,
                            color: Colors.deepPurple,
                          ),
                        ),
    );
  }
}
