// main.dart
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ariana Ruiz-Lopez',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _result = result.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String value, {Color color = Colors.black}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(20.0),
          ),
          onPressed: () => _onButtonPressed(value),
          child: Text(
            value,
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ariana Ruiz-Lopez'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: TextStyle(fontSize: 32.0, color: Colors.black54),
                  ),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 48.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('C', color: Colors.grey),
                  _buildButton('=', color: Colors.grey),
                  _buildButton('+', color: Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}