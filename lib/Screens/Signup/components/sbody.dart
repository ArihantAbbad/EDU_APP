import 'package:flutter/material.dart';
import 'package:edu_app/Screens/Login/login_screen.dart';
import 'package:edu_app/Screens/Signup/components/background.dart';
import 'package:edu_app/components/already_have_an_account_acheck.dart';
import 'package:edu_app/components/rounded_button.dart';
import 'package:edu_app/components/rounded_input_field.dart';
import 'package:edu_app/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String msg = " ";
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String name;
  String number;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGN UP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.25,
              ),
              RoundedInputField(
                hintText: "Your Name",
                onChanged: (value) {
                  name = value;
                },
              ),
              RoundedInputField(
                icon: Icons.email,
                hintText: "Your Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedInputField(
                icon: Icons.phone,
                hintText: "Your Phone",
                onChanged: (value) {
                  number = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password = value;
                },
              ),
              Text(
                msg,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      _firestore.collection('Students').add({
                        'name': name,
                        'email': email,
                        'number': number,
                        'password': password,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                      msg = e.toString();
                    });
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//     .then(
// (value) async {
// SharedPreferences prefs =
//     await SharedPreferences.getInstance();
// prefs.setString('email', email);
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) {
// return HomePage();
// },
// ),
// );
// },
// );
