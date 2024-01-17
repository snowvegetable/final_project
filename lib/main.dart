import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  double? num1;
  double? num2;
  String? operand;

  void _handleClick(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        num1 = null;
        num2 = null;
        operand = null;
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        if (num1 == null) {
          num1 = double.tryParse(input);
          operand = value;
          input = '';
        }
      } else if (value == '=') {
        if (num1 != null && operand != null) {
          num2 = double.tryParse(input);
          double result = _performOperation(num1!, num2!, operand!);
          input = result.toString();
          num1 = null;
          operand = null;
          num2 = null;
        }
      } else {
        input += value;
      }
    });
  }

  double _performOperation(double num1, double num2, String operand) {
    switch (operand) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
        return num1 * num2;
      case '/':
        return num1 / num2;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('計算機'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: Text(
              input,
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('C'),
              _buildButton('0'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () => _handleClick(text),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}
