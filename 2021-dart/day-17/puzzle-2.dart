import 'CannonClass.dart';

void main(List<String> args) {
  Cannon cannon = Cannon();
  cannon.findSuccessfulTrajectories();
  int highestY = cannon.findHighestYValue();
  print('Highest Y value: $highestY');
  print('Highest Y value: ${cannon.successfulTrajectories.length}');
}
