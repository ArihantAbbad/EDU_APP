import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizId) async {
    final _firestore = await FirebaseFirestore.instance;
    await _firestore
        .collection('Quiz')
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    final _firestore = await FirebaseFirestore.instance;
    await _firestore
        .collection("Quiz")
        .doc(quizId)
        .collection('QnA')
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizesData() async {
    final _firestore = await FirebaseFirestore.instance;
    return await _firestore.collection("Quiz").snapshots();
  }

  getQuizData(String quizId) async {
    final _firestore = await FirebaseFirestore.instance;
    return await _firestore
        .collection("Quiz")
        .doc(quizId)
        .collection("QnA")
        .get();
  }

  Future<void> addUserDataAboutTest(Map studentData, String quizId) async {
    final _firestore = await FirebaseFirestore.instance;
    await _firestore
        .collection("Quiz")
        .doc(quizId)
        .collection('AttemptedByStudents')
        .add(studentData)
        .catchError((e) {
      print(e.toString());
    });
  }
}
