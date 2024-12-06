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
  var illegalCharacters = findAllIllegalChars(input);
  var score = tallyCharScrore(illegalCharacters);
  print('The total score is: $score');
}

List<String> findAllIllegalChars(List<String> lines) {
  var illegalChars = '';
  for (var line in lines) {
    var illegalChar = findIllegalChar(line);
    illegalChars += illegalChar;
  }

  return illegalChars.split('');
}

String findIllegalChar(String line) {
  final stack = Stack<String>();
  final lineAsList = line.split('');
  const openingChars = '([{<';

  for (var char in lineAsList) {
    if (openingChars.contains(char)) {
      stack.push(char);
    } else {
      var openingChar = stack.pop();
      if (!checkBracesMatch(openingChar, char)) {
        return char;
      }
    }
  }

  return '';
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

int tallyCharScrore(List<String> illegalChars) {
  int total = 0;
  for (var char in illegalChars) {
    switch (char) {
      case ')':
        {
          total += 3;
          break;
        }

      case ']':
        {
          total += 57;
          break;
        }

      case '}':
        {
          total += 1197;
          break;
        }

      case '>':
        {
          total += 25137;
          break;
        }
    }
  }

  return total;
}
