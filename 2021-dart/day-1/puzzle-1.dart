import 'dart:io';

void main() {
  List<String> input = getInput();

  int? lastChecked = null;
  int numberOfIncrements = 0;

  for (String strNum in input) {
    int num = int.parse(strNum);
    print(num);

    if (lastChecked == null) {
      lastChecked = num;
      continue;
    }

    if (num > lastChecked) {
      numberOfIncrements++;
    }

    lastChecked = num;
  }

  print('Total number of increments: $numberOfIncrements');
}

List<String> getInput() {
  String contents = File('day-1/input.txt').readAsStringSync().trim();
  List<String>? input = contents.split('\n');
  if (input.length == 0) throw Error();
  return input;
}
