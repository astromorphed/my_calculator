import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'My Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String calcResult = "0";
  String _calcResult = "0";
  double n1 = 0.0;
  double n2 = 0.0;
  String operator = "";

  buttonPressed(String buttonTextValue) {
    if (buttonTextValue == "CE") {
      _calcResult = "0";
      n1 = 0.0;
      n2 = 0.0;
      operator = "";
    } else if (buttonTextValue == "+" ||
        buttonTextValue == "-" ||
        buttonTextValue == "*" ||
        buttonTextValue == "/") {
      n1 = double.parse(calcResult);
      operator = buttonTextValue;
      _calcResult = "0";
    } else if (buttonTextValue == ".") {
      if (_calcResult.contains(".")) {
        _showSnackAlert(context);
        return;
      } else {
        _calcResult += buttonTextValue;
      }
    } else if (buttonTextValue == "=") {
      n2 = double.parse(calcResult);

      if (operator == "+") {
        _calcResult = (n1 + n2).toString();
      } else if (operator == "-") {
        _calcResult = (n1 - n2).toString();
      } else if (operator == "*") {
        _calcResult = (n1 * n2).toString();
      } else if (operator == "/") {
        _calcResult = (n1 / n2).toString();
      }

      n1 = 0;
      n2 = 0;
      operator = "";
    } else {
      _calcResult += buttonTextValue;
    }

    print(_calcResult);
    setState(() {
      calcResult = double.parse(_calcResult).toStringAsFixed(2);
    });
  }

  Widget makeAButton(String buttonTextValue) {
    return Expanded(
        child: MaterialButton(
            onPressed: () => buttonPressed(buttonTextValue),
            child: Text(buttonTextValue,
                style: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold)),
            textColor: Colors.white,
            color: Colors.deepOrangeAccent,
            padding: const EdgeInsets.all(20)));
  }

  void _showSnackAlert(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text("There is already a decimal point."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerRight,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Text(
                    calcResult,
                    style: const TextStyle(
                        fontSize: 35.0, fontWeight: FontWeight.bold),
                  )),
              const Expanded(child: Divider()),
              Row(
                children: [
                  makeAButton("7"),
                  makeAButton("8"),
                  makeAButton("9"),
                  makeAButton("-")
                ],
              ),
              Row(
                children: [
                  makeAButton("4"),
                  makeAButton("5"),
                  makeAButton("6"),
                  makeAButton("+")
                ],
              ),
              Row(
                children: [
                  makeAButton("3"),
                  makeAButton("2"),
                  makeAButton("1"),
                  makeAButton("*")
                ],
              ),
              Row(
                children: [
                  makeAButton("."),
                  makeAButton("0"),
                  makeAButton("00"),
                  makeAButton("/")
                ],
              ),
              Row(
                children: [makeAButton("CE"), makeAButton("=")],
              )
            ],
          ),
        ));
  }
}
