import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results(
      {@required this.total, @required this.correct, @required this.incorrect});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${widget.correct}/${widget.total}",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "You answered ${widget.correct} answers correctly and ${widget.incorrect} incorrectly.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 14,
            ),
            RaisedButton(
              color: Colors.cyan,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Go to Home"),
            ),
          ],
        )),
      ),
    );
  }
}
