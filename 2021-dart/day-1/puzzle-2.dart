import 'dart:io';

void main() {
  List<String> input = getInput();

  int? lastChecked = null;
  int numberOfIncrements = 0;

  for (int i = 2; i < input.length; i++) {
    int setValue = getSetSum(input[i], input[i - 1], input[i - 2]);

    if (lastChecked == null) {
      lastChecked = setValue;
      continue;
    }

    if (setValue > lastChecked) {
      numberOfIncrements++;
    }

    lastChecked = setValue;
  }

  print('Total number of increments: $numberOfIncrements');
}

List<String> getInput() {
  String contents = File('day-1/input.txt').readAsStringSync().trim();
  List<String>? input = contents.split('\n');
  if (input.length == 0) throw Error();
  return input;
}

int getSetSum(String num1, String num2, String num3) {
  return int.parse(num1) + int.parse(num2) + int.parse(num3);
}
