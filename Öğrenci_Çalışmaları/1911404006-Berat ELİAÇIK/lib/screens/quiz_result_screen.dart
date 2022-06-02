import 'package:flutter/material.dart';
import 'package:projemmmm/screens/quiz_history_screen.dart';

import '../common/theme_helper.dart';
import '../models/dto/quiz_result.dart';
import '../widgets/disco_button.dart';

class QuizResultScreen extends StatefulWidget {
  static const routeName = '/quizResult';
  QuizResult result;
  QuizResultScreen(this.result, {Key? key}) : super(key: key);

  @override
  _QuizResultScreenState createState() => _QuizResultScreenState(this.result);
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  QuizResult result;
  int totalQuestions = 0;
  double totalCorrect = 0;

  _QuizResultScreenState(this.result);

  @override
  void initState() {
    setState(() {
      totalCorrect = result.totalCorrect;
      totalQuestions = result.quiz.questions.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            quizResultInfo(result),
            bottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Container(
      margin: EdgeInsets.only(left: 30,right: 30,bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      50) //kapat butonunun kenarlarını yumuşak geçişli yaptık.
              ),
              color: ThemeHelper.primaryColor,
              child: Text("Kapat", style: TextStyle(
                color: Colors.white,
              ),)
            // width: 150,
            // height: 50,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, QuizHistoryScreen.routeName);
            },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      50) //cözdüklerim butonunun kenarlarını yumuşak geçişli yaptık.
              ),
              color: ThemeHelper.primaryColor,
              child: Text("Çözdüklerim", style: TextStyle(
                color: Colors.white,
              ),)
            // width: 150,
            // height: 50,
            // isActive: true,
          ),
        ],
      ),
    );
  }

  Widget quizResultInfo(QuizResult result) {
    return Container(
      padding: EdgeInsets.only(top:30),
      child: Column(

        children: [
          SizedBox(height: 40),
          Image(

            image: AssetImage("assets/images/quizResultBadge.png"),
          ),
          SizedBox(height: 20),
          Container(
            //padding: EdgeInsets.only(top:30),
            child: Text(
              "Tebrikler!",
              style: TextStyle(fontSize: 50)//Theme.of(context).textTheme.headline3,
            ),
          ),

          Text(
            "Doğru sayısı:",
            style: TextStyle(fontSize: 20),
          ),
          //SizedBox(height: 20),
          Text(
            "$totalQuestions/$totalCorrect",
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}