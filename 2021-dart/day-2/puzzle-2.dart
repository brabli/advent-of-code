import 'dart:io';

int depth = 0;
int distance = 0;
int aim = 0;

void main(List<String> args) {
  List<String> rawInstructions = getInput(2);
  List<Map> instructions = getInstructions(rawInstructions);
  executeInstructions(instructions);
  showResults();
}

List<String> getInput(int day) {
  String contents = File('day-$day/input.txt').readAsStringSync().trim();
  List<String> input = contents.split('\n');
  if (input.length == 0) throw Error();

  return input;
}

List<Map> getInstructions(List<String> rawInstructions) {
  List<Map> instructions = [];
  for (String instruction in rawInstructions) {
    Map parsedInstruction = getSingleInstruction(instruction);
    instructions.add(parsedInstruction);
  }

  return instructions;
}

Map getSingleInstruction(String instruction) {
  List<String> splitInstruction = instruction.split(' ');

  return {
    'command': splitInstruction[0],
    'value': int.parse(splitInstruction[1])
  };
}

void executeInstructions(List<Map> instructions) {
  for (Map instruction in instructions) {
    String command = instruction['command'];
    int value = instruction['value'];

    if (command == 'forward') {
      distance += value;
      depth += aim * value;
    }

    if (command == 'down') {
      aim += value;
    }

    if (command == 'up') {
      aim -= value;
    }
  }
}

void showResults() {
  print('Depth: $depth');
  print('Distance: $distance');
  print('Multipled together: ${depth * distance}');
}
