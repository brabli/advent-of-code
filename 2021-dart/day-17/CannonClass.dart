class Cannon {
  var targetX = {'min': 96, 'max': 125};
  var targetY = {'min': -144, 'max': -98};
  int velocityX = 0;
  int velocityY = 0;
  int positionX = 0;
  int positionY = 0;
  List successfulTrajectories = [];
  List highestYValues = [];

  void stepForward() {
    positionX += velocityX;
    positionY += velocityY;
    if (velocityX > 0) velocityX -= 1;
    velocityY -= 1;
  }

  bool fire(int velocityX, int velocityY) {
    positionX = 0;
    positionY = 0;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    int highestYValue = 0;

    while (!passedTargetArea()) {
      stepForward();
      if (positionY > highestYValue) highestYValue = positionY;
      if (inTargetArea()) {
        highestYValues.add(highestYValue);
        return true;
      }
    }

    return false;
  }

  void findSuccessfulTrajectories() {
    // x loop
    for (int x = 0; x < targetX['max']! + 100; x++) {
      // y loop
      for (int y = targetY['min']!; y <= 3000; y++) {
        if (fire(x, y))
          successfulTrajectories.add([x, y]);
        else
          continue;
      }
    }
  }

  void printData() {
    print('XY Velocity: $velocityX, $velocityY');
    print('XY Position: $positionX, $positionY');
    print('____________');
  }

  int findHighestYValue() {
    int highest = -10000;
    for (var trajectory in successfulTrajectories) {
      if (trajectory[1] > highest) highest = trajectory[1];
    }
    highestYValues.sort();

    return highestYValues.last;
  }

  bool inTargetArea() => _inTargetX(positionX) && _inTargetY(positionY);

  bool passedTargetArea() =>
      positionX > targetX['max']! || positionY < targetY['min']!;

  bool _inTargetX(int posX) =>
      positionX >= targetX['min']! && positionX <= targetX['max']!;

  bool _inTargetY(int posY) =>
      positionY >= targetY['min']! && positionY <= targetY['max']!;
}
