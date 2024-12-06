import 'dart:io';
import 'package:stack/stack.dart';

List<String> getInput() {
  String contents = File('day-10/input.txt').readAsStringSync().trim();
  List<String>? input = contents.split('\n');
  if (input.length == 0) throw Error();
  return input;
}

void main(List<String> args) {
  var input = getInput();
  var incompleteLines = findIncompleteLines(input);
  var closingStrings = findClosingStrings(incompleteLines);
  var score = calculateScore(closingStrings);
  print('The total score is: $score');
}

List<String> findClosingStrings(List<String> incompleteLines) {
  var closingStrings = <String>[];
  for (var line in incompleteLines) {
    closingStrings.add(reverse(findClosingString(line.split(''))));
  }

  return closingStrings;
}

List<String> findIncompleteLines(List<String> lines) {
  var incompleteLines = <String>[];

  for (String line in lines) {
    final stack = Stack<String>();
    final lineAsList = line.split('');
    const openingChars = '([{<';
    bool lineIsValid = true;

    for (var char in lineAsList) {
      if (openingChars.contains(char)) {
        stack.push(char);
      } else {
        if (checkBracesMatch(stack.top(), char)) {
          stack.pop();
        } else {
          lineIsValid = false;
        }
      }
    }

    if (lineIsValid && stack.isNotEmpty)
      incompleteLines.add(stackToString(stack));
  }
  print(incompleteLines);
  return incompleteLines;
}

String stackToString(Stack<String> stack) {
  var stackAsString = '';
  int startLength = stack.length;
  for (var i = 0; i < startLength; i++) {
    stackAsString += stack.pop();
  }

  return reverse(stackAsString);
}

bool checkBracesMatch(String opening, String closing) {
  final together = '$opening$closing';
  if (together == '()' ||
      together == '[]' ||
      together == '{}' ||
      together == '<>') {
    return true;
  }

  return false;
}

String findClosingString(List<String> chars) {
  String output = '';
  for (var char in chars) {
    switch (char) {
      case '(':
        {
          output += ')';
          break;
        }

      case '[':
        {
          output += ']';
          break;
        }

      case '{':
        {
          output += '}';
          break;
        }

      case '<':
        {
          output += '>';
          break;
        }
    }
  }

  return output;
}

int tallyClosingLineScore(List<String> line) {
  var scoreChart = <String, int>{')': 1, ']': 2, '}': 3, '>': 4};
  var total = 0;
  for (var char in line) {
    total *= 5;
    total += scoreChart[char]!;
  }

  return total;
}

int calculateScore(List<String> closingLines) {
  List<int> total = [];

  for (var line in closingLines) {
    total.add(tallyClosingLineScore(line.split('')));
  }

  total.sort();
  print('Length: ${total.length}');
  print(closingLines);
  print(total);
  return total[total.length ~/ 2];
}

String reverse(String input) => input.split('').reversed.join();
