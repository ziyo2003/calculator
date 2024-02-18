import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double _result = 0.0;
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();


  Future<void> _calculate(String operation) async {
    final double a = double.parse(_controllerA.text);
    final double b = double.parse(_controllerB.text);
    final Map<String, dynamic> args = {'a': a, 'b': b, 'operation': operation};

    // Perform calculation on a separate isolate
    final double result = await compute(_performCalculation, args);
    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.only(top: 90,left: 20,right: 20),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 150,right: 150),
                    child: TextField(
                      controller: _controllerA,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '       A '),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150,right: 150),
                    child: TextField(
                      controller: _controllerB,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: '       B '),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60,right: 60,top: 10),
              child: Center(
                child: Wrap(
                  children: <Widget>[
                    ElevatedButton(onPressed: () => _calculate('add'), child: Text('+')),
                    ElevatedButton(onPressed: () => _calculate('subtract'), child: Text('-')),
                    ElevatedButton(onPressed: () => _calculate('multiply'), child: Text('*')),
                    ElevatedButton(onPressed: () => _calculate('divide'), child: Text('/')),
                    ElevatedButton(onPressed: () => _calculate('sqrt'), child: Text('√')),
                    ElevatedButton(onPressed: () => _calculate('square'), child: Text('x²')),
                    ElevatedButton(onPressed: () => _calculate('power'), child: Text('^')),
                  ],
                ),
              ),
            ),
            Text('-> $_result <-',style:TextStyle(color: Colors.white,fontSize: 40)),
          ],
        ),
      ),
    );
  }
}


double _performCalculation(Map<String, dynamic> args) {
  final double a = args['a'];
  final double b = args['b'];
  final String operation = args['operation'];

  switch (operation) {
    case 'add':
      return a + b;
    case 'subtract':
      return a - b;
    case 'multiply':
      return a * b;
    case 'divide':
      return a / b;
    case 'sqrt':
      return sqrt(a);
    case 'square':
      return pow(a, 2).toDouble();
    case 'power':
      return pow(a, b).toDouble();
    default:
      return 0.0;
  }
}
