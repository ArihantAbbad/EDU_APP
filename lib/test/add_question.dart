import 'package:flutter/material.dart';
import 'package:edu_app/constants.dart';
import 'package:edu_app/database.dart';

class AddQuestion extends StatefulWidget {
  final quizId;
  AddQuestion({@required this.quizId});
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formkey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isloading = false;

  DatabaseService databaseService = new DatabaseService();
  uploadQuestionData() {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isloading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };

      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        setState(() {
          _isloading = false;
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
                      validator: (val) => val.isEmpty ? "Enter Question" : null,
                      decoration: InputDecoration(
                        hintText: "Question",
                      ),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "enter option1" : null,
                      decoration: InputDecoration(
                        hintText: "Option1 (Correct Answer)",
                      ),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "enter option2" : null,
                      decoration: InputDecoration(
                        hintText: "Option2",
                      ),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "enter option3" : null,
                      decoration: InputDecoration(
                        hintText: "Option3",
                      ),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "enter option4" : null,
                      decoration: InputDecoration(
                        hintText: "Option4",
                      ),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          color: kPrimaryColor,
                          onPressed: () {
                            uploadQuestionData();
                            Navigator.pop(context);
                          },
                          child: Text("Submit"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          color: kPrimaryColor,
                          onPressed: () {
                            uploadQuestionData();
                          },
                          child: Text("Add Question"),
                        ),
                      ],
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
