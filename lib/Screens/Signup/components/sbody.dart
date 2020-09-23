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
import 'package:shared_preferences/shared_preferences.dart';

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
  String eerr = " ";
  String perr = " ";

  String e_validator(email) {
    if (email ==
        "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
      return "Account with E-mail already Exists! Try Logging in.";
    } else if (email ==
        "[firebase_auth/invalid-email] The email address is badly formatted.") {
      return "Please Type E-mail properly!";
    } else {
      return " ";
    }
  }

  String p_validator(pass) {
    if (pass ==
        "[firebase_auth/weak-password] Password should be at least 6 characters") {
      return "Password should be at-least 8 characters long!";
    } else {
      return " ";
    }
  }

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
                height: size.height * 0.30,
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
                textAlign: TextAlign.center,
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
                    eerr = e_validator(e.toString());
                    perr = p_validator(e.toString());
                    setState(() {
                      showSpinner = false;
                      msg = eerr + perr;
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
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
