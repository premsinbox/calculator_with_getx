import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:expressions/expressions.dart';

class CalculatorController extends GetxController {
  var input = ''.obs;
  var output = ''.obs;
  var history = <String>[].obs;

  void appendValue(String value) {
    if (_isOperator(value)) {
      if (input.value.isNotEmpty && _isOperator(input.value.characters.last)) {
        return; 
      }
    }

    if (value == '=' && output.value.isNotEmpty) {
      input.value = output.value;
      output.value = '';
    } else if (value == '.') {
      if (canAddDecimalPoint()) {
        input.value += value;
      }
    } else {
      input.value += value; 
    }

    if (value != '=') {
      calculateRealTime();
    }
  }

  bool canAddDecimalPoint() {
    
    List<String> numbers = input.value.split(RegExp(r'[+\-*/]'));
 
    String lastNumber = numbers.last;
   return !lastNumber.contains('.');
  }

  void calculateRealTime() {
    try {
      String expressionToEvaluate = input.value;
      if (expressionToEvaluate.isNotEmpty && !RegExp(r'[+\-*/]$').hasMatch(expressionToEvaluate)) {
        double result = _evaluateExpression(expressionToEvaluate);
        output.value = _formatResult(result);
      }
    } catch (e) {
      output.value = '';
    }
  }

  void calculateResult() {
    try {
      double result = _evaluateExpression(input.value);
      output.value = _formatResult(result);
      history.add('${input.value} = ${output.value}');
    } catch (e) {
      output.value = 'Error';
    }
  }

  String _formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      String formatted = result.toStringAsFixed(8);
      return formatted.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
  }

  void clearLast() {
    if (input.value.isNotEmpty) {
      input.value = input.value.substring(0, input.value.length - 1);
      calculateRealTime();
    }
  }

  void clearAll() {
    input.value = '';
    output.value = '';
  }

  void clearHistory() {
    history.clear();
  }

  void clearHistoryEntry(int index) {
    history.removeAt(index);
  }

  double _evaluateExpression(String expression) {
    try {
      Expression exp = Expression.parse(expression);
      final evaluator = const ExpressionEvaluator();
      var result = evaluator.eval(exp, {});

      if (result is num) {
        return result.toDouble();
      }
    } catch (e) {
      throw Exception('Invalid Expression');
    }
    throw Exception('Invalid Expression');
  }

  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/';
  }
}
