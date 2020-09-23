import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/constants.dart';
import 'package:edu_app/database.dart';
import 'package:edu_app/test/add_question.dart';
import 'dart:math';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  String quizUrl, quizTitle, quizDesc, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isloading = false;

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  createQuizOnline() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isloading = true;
      });
      quizId = generateRandomString(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizTitle": quizTitle,
        "quizDesc": quizDesc,
        "quizUrl": quizUrl,
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isloading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuestion(
                quizId: quizId,
              ),
            ),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Quiz"),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_backspace)),
      ),
      body: _isloading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "enter image url" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Image Url",
                      ),
                      onChanged: (val) {
                        quizUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "enter quiz title" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Title",
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "enter Quiz Description" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Description",
                      ),
                      onChanged: (val) {
                        quizDesc = val;
                      },
                    ),
                    Spacer(),
                    RaisedButton(
                      color: kPrimaryColor,
                      onPressed: () {
                        createQuizOnline();
                      },
                      child: Text("create quiz"),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
