import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorWidget(),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String equ = "0";
  String res = "0";
  String expression = "";

  void onPressedButton(String text) {
    setState(() {
      if (text == "C") {
        equ = "0";
        res = "0";
      } else if (text == "⌫") {
        equ = equ.substring(0, equ.length - 1); //ဖျက်တာ
        if (equ == "") {
          equ = "0";
        }
      } else if (text == "=") {
        expression = equ;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        res = "$eval";
      } else {
        if (equ == "0") {
          equ = text;
        } else {
          equ = equ + text;
        }
      }
    });
  }

  Widget buildButtton(
      double buttonHeight, String buttonText, Color buttonColor) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * 0.1 * buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(
              width: 1,
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          primary: buttonColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
        onPressed: () => onPressedButton(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size; //_size=private
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Calculator App"),
        ),
        body: Column(
          children: [
            Container(
                alignment: Alignment.topRight,
                color: Colors.black12,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(equ,
                    style: TextStyle(
                      fontSize: 40,
                    ))),
            SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topRight,
                color: Colors.black12,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(res,
                    style: TextStyle(
                      fontSize: 40,
                    ))),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: _size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButtton(1, "C", Colors.redAccent),
                        buildButtton(1, "+", Colors.blueAccent),
                        buildButtton(1, "-", Colors.blueAccent),
                      ]),
                      TableRow(children: [
                        buildButtton(1, "7", Colors.grey),
                        buildButtton(1, "8", Colors.grey),
                        buildButtton(1, "9", Colors.grey),
                      ]),
                      TableRow(children: [
                        buildButtton(1, "4", Colors.grey),
                        buildButtton(1, "5", Colors.grey),
                        buildButtton(1, "6", Colors.grey),
                      ]),
                      TableRow(children: [
                        buildButtton(1, "1", Colors.grey),
                        buildButtton(1, "2", Colors.grey),
                        buildButtton(1, "3", Colors.grey),
                      ]),
                      TableRow(children: [
                        buildButtton(1, ".", Colors.grey),
                        buildButtton(1, "0", Colors.grey),
                        buildButtton(1, "00", Colors.grey),
                      ])
                    ],
                  ),
                ),
                Container(
                  width: _size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButtton(1, "x", Colors.blueAccent),
                      ]),
                      TableRow(children: [
                        buildButtton(1, "÷", Colors.blueAccent),
                      ]),
                      TableRow(children: [
                        buildButtton(1, "⌫", Colors.blueAccent),
                      ]),
                      TableRow(children: [
                        buildButtton(2, "=", Colors.redAccent),
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
