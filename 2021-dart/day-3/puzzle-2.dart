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

  List cols = splitIntoColumns(binaryData);
  for (String col in cols) {
    output += findMostCommonDigit(col);
  }

  Binary gamma = new Binary(output);
  Binary epsilon = new Binary(invertBinaryString(output));
  print(gamma.value * epsilon.value);

  Binary oxy = new Binary(findOxyGen(binaryData));
  Binary co2 = new Binary(findCo2Scrub(binaryData));
  print(oxy.value * co2.value);
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

List<String> splitIntoColumns(List<String> binaryData) {
  List<String> columnNumbers = [];
  for (int i = 0; i < binaryData[0].length; i++) {
    String columnDigits = '';
    for (String binaryNumber in binaryData) {
      List<String> splitBinaryNumber = binaryNumber.split('');
      columnDigits += splitBinaryNumber[i];
    }
    columnNumbers.add(columnDigits);
    columnDigits = '';
  }

  return columnNumbers;
}

String findMostCommonDigit(String binaryNumber) {
  int numZeroes = '0'.allMatches(binaryNumber).length;
  int numOnes = '1'.allMatches(binaryNumber).length;
  if (numOnes >= numZeroes)
    return '1';
  else
    return '0';
}

String findLeastCommonDigit(String binaryNumber) {
  int numZeroes = '0'.allMatches(binaryNumber).length;
  int numOnes = '1'.allMatches(binaryNumber).length;
  if (numZeroes <= numOnes)
    return '0';
  else
    return '1';
}

String findOxyGen(List<String> binaryInput) {
  for (int i = 0; i < 12; i++) {
    List<String> columns = splitIntoColumns(binaryInput);
    String mcd = findMostCommonDigit(columns[i]);

    List<String> filteredBinaryInput = [];
    for (String binaryNumber in binaryInput) {
      List splitNum = binaryNumber.split('');
      if (splitNum[i] == mcd) filteredBinaryInput.add(binaryNumber);
    }

    binaryInput = filteredBinaryInput;
    if (binaryInput.length == 1) return binaryInput[0];
  }

  throw Error();
}

String findCo2Scrub(List<String> binaryInput) {
  for (int i = 0; i < 12; i++) {
    List<String> columns = splitIntoColumns(binaryInput);
    String lcd = findLeastCommonDigit(columns[i]);

    List<String> filteredBinaryInput = [];
    for (String binaryNumber in binaryInput) {
      List splitNum = binaryNumber.split('');
      if (splitNum[i] == lcd) filteredBinaryInput.add(binaryNumber);
    }

    binaryInput = filteredBinaryInput;
    if (binaryInput.length == 1) return binaryInput[0];
  }

  throw Error();
}
