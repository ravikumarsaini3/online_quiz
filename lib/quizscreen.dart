import 'package:flutter/material.dart';
import 'package:online_quiz/quizmodel.dart';
import 'package:online_quiz/resultscreen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuestionModel> questions = [
    QuestionModel(
      question: "What is Flutter?",
      options: ["Framework", "Language", "IDE", "Library"],
      correctOptionIndex: 0,
    ),
    QuestionModel(
      question: "Which language is used to write Flutter apps?",
      options: ["Java", "Swift", "Dart", "Kotlin"],
      correctOptionIndex: 2,
    ),
    QuestionModel(
      question: "Flutter is developed by which company?",
      options: ["Apple", "Microsoft", "Google", "Facebook"],
      correctOptionIndex: 2,
    ),
    QuestionModel(
      question:
          "Which widget is used to create a scrollable list of items in Flutter?",
      options: ["Column", "Row", "ListView", "Stack"],
      correctOptionIndex: 2,
    ),
    QuestionModel(
      question: "What is the default root widget in a Flutter app?",
      options: ["MaterialApp", "Scaffold", "Container", "AppBar"],
      correctOptionIndex: 0,
    ),
    QuestionModel(
      question: "Which command is used to create a new Flutter project?",
      options: [
        "flutter new",
        "flutter create",
        "flutter init",
        "flutter start"
      ],
      correctOptionIndex: 1,
    ),
  ];

  int currentQuestionIndex = 0;
  int score = 0;

  void nextQuestion(int selectedOption) {
    if (selectedOption == questions[currentQuestionIndex].correctOptionIndex) {
      score++;
    }

    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultScreen(score: score, total: questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz App",
          style: TextStyle(
            fontSize: isTablet ? 28 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Question ${currentQuestionIndex + 1}/${questions.length}",
              style: TextStyle(
                fontSize: isTablet ? 28 : 18,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: isTablet ? 20 : 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.deepPurple[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  questions[currentQuestionIndex].question,
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: isTablet ? 20 : 10),
            Expanded(
              child: ListView.builder(
                itemCount: questions[currentQuestionIndex].options.length,
                itemBuilder: (context, idx) {
                  String option = questions[currentQuestionIndex].options[idx];
                  return GestureDetector(
                    onTap: () => nextQuestion(idx),
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: isTablet ? 22 : 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
