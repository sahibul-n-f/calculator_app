import 'package:calculator_app/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '',
    '0',
    '.',
    '=',
  ];

  String finalQuestion;
  int count = 4;
  double mar = 8;
  var question = '';
  var answer = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: Column(
        children: [
          Flexible(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      alignment: Alignment.centerRight,
                      child: Text(
                        question,
                        style: GoogleFonts.poppins(
                            fontSize: (question.length <= 16) ? 32 : 24,
                            color: Colors.deepPurple[500]),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        answer,
                        style: GoogleFonts.poppins(
                            fontSize: (answer.length <= 10)
                                ? 48
                                : (answer.length <= 16)
                                    ? 32
                                    : 24,
                            color: (answer == "FORMAT BERMASALAH")
                                ? Colors.pink[400]
                                : Colors.deepPurple[600]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                color: Colors.indigo[200],
                // padding: EdgeInsets.only(bottom: 10, left: 8, right: 8),
                child: Stack(
                  children: [
                    GridView.builder(
                      itemCount: buttons.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: (count == 4) ? 30 : 8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: (count == 5) ? 12 : 8,
                        mainAxisSpacing: 8,
                        crossAxisCount: count,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        // Reset
                        if ((index == 0 && buttons[index] == "C") ||
                            (index == 11 && buttons[index] == "C")) {
                          return MyButtons(
                            buttonTap: () {
                              setState(() {
                                question = '';
                                answer = '0';
                              });
                            },
                            mar: mar,
                            textButton: buttons[index],
                            color: Colors.teal,
                            textColor: Colors.white,
                          );
                        }

                        // Delete
                        else if ((index == 1 && buttons[index] == "DEL") ||
                            (index == 12 && buttons[index] == "DEL")) {
                          return MyButtons(
                            textButton: buttons[index],
                            color: Colors.pink[400],
                            textColor: Colors.white,
                            mar: mar,
                            buttonTap: () {
                              setState(() {
                                question =
                                    question.substring(0, question.length - 1);
                              });
                            },
                          );
                        }

                        // Equal
                        else if (index == buttons.length - 1) {
                          return MyButtons(
                            textButton: buttons[index],
                            color: Colors.deepPurple,
                            textColor: Colors.white,
                            mar: mar,
                            buttonTap: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                          );
                        } else if ((index == buttons.length - 4 &&
                                count == 4) ||
                            (index == buttons.length - 5 && count == 5)) {
                          return Container(
                            // margin: EdgeInsets.all(mar),
                            decoration: BoxDecoration(
                              color: (count == 5)
                                  ? Colors.transparent
                                  : Colors.white12,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    menu();
                                  });
                                },
                                child: Center(
                                  child: Icon(Icons.now_widgets_rounded,
                                      color: Colors.white, size: 30),
                                ),
                              ),
                            ),
                          );
                        } else if (((index == 0 ||
                                index == 1 ||
                                index == 2 ||
                                index == 3 ||
                                index == 4 ||
                                index == 5 ||
                                index == 6 ||
                                index == 7 ||
                                index == 8 ||
                                index == 9 ||
                                index == 10 ||
                                index == 15 ||
                                index == 20 ||
                                index == 25) &&
                            count == 5)) {
                          return MyButtons(
                            textButton: buttons[index],
                            color: isOperator(buttons[index])
                                ? Colors.deepPurple
                                : Colors.white.withOpacity(0.0),
                            textColor: Colors.white,
                            font: 14,
                            // mar: mar,
                            buttonTap: () {
                              setState(() {
                                question += buttons[index]
                                    .replaceAll("x^", "^")
                                    .replaceAll("1/x", "^-1")
                                    .replaceAll("PI", "3.14")
                                    .replaceAll("e", "2.71828183")
                                    .replaceAll("x!", "!");
                              });
                            },
                          );
                        } else {
                          return MyButtons(
                            textButton: buttons[index],
                            color: isOperator(buttons[index])
                                ? Colors.deepPurple
                                : Colors.white12,
                            textColor: Colors.white,
                            // mar: mar,
                            buttonTap: () {
                              setState(() {
                                question += buttons[index];
                                showToast(buttons[index],
                                    gravity: Toast.BOTTOM, duration: 1);
                              });
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '+' || x == '-' || x == '%' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    finalQuestion = question;
    finalQuestion = finalQuestion.replaceAll('x', '*').replaceAll("(", "*(");

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      answer = '= ' + eval.toString();
    } catch (e) {
      answer = 'FORMAT BERMASALAH';
    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context,
        duration: duration,
        gravity: gravity,
        backgroundColor: Colors.pink[400]);
  }

  void menu() {
    if (count == 4) {
      count = 5;
      mar = 4;
      buttons.insert(0, "2nd");
      buttons.insert(1, "deg");
      buttons.insert(2, "sin");
      buttons.insert(3, "cos");
      buttons.insert(4, "tan");
      buttons.insert(5, "x^");
      buttons.insert(6, "log");
      buttons.insert(7, "ln");
      buttons.insert(8, "(");
      buttons.insert(9, ")");
      buttons.insert(10, "x!");
      buttons.insert(15, "1/x");
      buttons.insert(20, "PI");
      buttons.insert(25, "e");
      buttons.insert(31, "00");

      print(buttons);
    } else {
      count = 4;
      buttons.removeRange(0, 11);
      buttons.remove("1/x");
      buttons.remove("PI");
      buttons.remove("e");
      buttons.remove("00");

      print(buttons);
    }
  }
}
