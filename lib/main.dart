import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState(); // Removed the underscore here
}

class MyAppState extends State<MyApp> {
  // Removed the underscore here
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Calculator',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey,
        buttonTheme: const ButtonThemeData(buttonColor: Colors.blueGrey),
      ),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
      ),
      home: CalculatorScreen(
        toggleDarkMode: (bool value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  final Function(bool) toggleDarkMode;
  const CalculatorScreen({super.key, required this.toggleDarkMode});

  @override
  CalculatorScreenState createState() =>
      CalculatorScreenState(); // Removed the underscore here
}

class CalculatorScreenState extends State<CalculatorScreen> {
  // Removed the underscore here
  String input = ''; // User input
  String output = ''; // Result output

  // Function to handle input change
  void _updateInput(String value) {
    setState(() {
      input += value;
    });
  }

  // Function to calculate the result
  void _calculate() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(input);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        output = result.toString();
      });
    } catch (e) {
      setState(() {
        output = 'Error';
      });
    }
  }

  // Function to clear the input and output
  void _clear() {
    setState(() {
      input = '';
      output = '';
    });
  }

  // Function to delete the last character of input
  void _delete() {
    setState(() {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.wb_sunny
                : Icons.nightlight_round),
            onPressed: () {
              widget.toggleDarkMode(
                  Theme.of(context).brightness == Brightness.dark
                      ? false
                      : true);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display input and result
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  input,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  output,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              // Buttons Row 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculatorButton(
                      label: '7', onPressed: () => _updateInput('7')),
                  CalculatorButton(
                      label: '8', onPressed: () => _updateInput('8')),
                  CalculatorButton(
                      label: '9', onPressed: () => _updateInput('9')),
                  CalculatorButton(
                      label: '/', onPressed: () => _updateInput('/')),
                ],
              ),
              // Buttons Row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculatorButton(
                      label: '4', onPressed: () => _updateInput('4')),
                  CalculatorButton(
                      label: '5', onPressed: () => _updateInput('5')),
                  CalculatorButton(
                      label: '6', onPressed: () => _updateInput('6')),
                  CalculatorButton(
                      label: '*', onPressed: () => _updateInput('*')),
                ],
              ),
              // Buttons Row 3
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculatorButton(
                      label: '1', onPressed: () => _updateInput('1')),
                  CalculatorButton(
                      label: '2', onPressed: () => _updateInput('2')),
                  CalculatorButton(
                      label: '3', onPressed: () => _updateInput('3')),
                  CalculatorButton(
                      label: '-', onPressed: () => _updateInput('-')),
                ],
              ),
              // Buttons Row 4
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculatorButton(
                      label: '0', onPressed: () => _updateInput('0')),
                  CalculatorButton(
                      label: '.', onPressed: () => _updateInput('.')),
                  CalculatorButton(label: '=', onPressed: _calculate),
                  CalculatorButton(
                      label: '+', onPressed: () => _updateInput('+')),
                ],
              ),
              // Buttons Row 5 (Clear/Delete)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CalculatorButton(label: 'C', onPressed: _clear),
                  CalculatorButton(label: 'DEL', onPressed: _delete),
                ],
              ),
              // Footer
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Made by Moxiu - GitHub: https://github.com/moxi-u7',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const CalculatorButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
