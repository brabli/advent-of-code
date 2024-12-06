import 'dart:io';
import 'package:quantity/number.dart';

List<String> getInput(int day) {
  String contents = File('day-$day/input.txt').readAsStringSync().trim();
  List<String>? input = contents.split('\n');
  if (input.length == 0) throw Error();

  return input;
}

void main(List<String> args) {
  List<String> binaryData = getInput(3);

  String output = '';

  for (int i = 0; i < binaryData[0].length; i++) {
    int total = 0;

    for (String binaryNumber in binaryData) {
      List<String> splitBinaryNumber = binaryNumber.split('');
      total += int.parse(splitBinaryNumber[i]);
    }

    if (total >= binaryData.length / 2) {
      output += '1';
    } else {
      output += '0';
    }
  }

  Binary gamma = new Binary(output);
  Binary epsilon = new Binary(invertBinaryString(output));

  print(gamma.value * epsilon.value);
}

String invertBinaryString(String binaryNum) {
  String output = '';
  List<String> splitBinary = binaryNum.split('');
  for (String digit in splitBinary) {
    if (digit == '0')
      output += '1';
    else
      output += '0';
  }

  return output;
}
