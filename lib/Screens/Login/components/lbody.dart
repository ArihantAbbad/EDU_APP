import 'package:edu_app/Screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/Screens/Login/components/background.dart';
import 'package:edu_app/Screens/Signup/signup_screen.dart';
import 'package:edu_app/components/already_have_an_account_acheck.dart';
import 'package:edu_app/components/rounded_button.dart';
import 'package:edu_app/components/rounded_input_field.dart';
import 'package:edu_app/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String msg = " ";
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  String eerr = " ";
  String perr = " ";

  String e_validator(email) {
    if (email ==
        "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
      return "Incorrect Email address";
    } else {
      return " ";
    }
  }

  String p_validator(pass) {
    if (pass ==
        "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
      return "Incorrect password";
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
                "LOG IN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                icon: Icons.email,
                hintText: "Your Email",
                onChanged: (value) {
                  email = value;
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
                text: "LOGIN",
                press: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('email', email);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
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
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
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
