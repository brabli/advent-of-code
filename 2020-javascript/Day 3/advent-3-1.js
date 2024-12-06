const fs = require("fs");

function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    const linesArray = data.split("\n");
    const area = linesArray.map(line => line.split(""));

    const lineLength = area[0].length;
    const numOfLines = area.length;
    const openSquare = ".";
    const tree = "#";
    let counter = 0;

    // 90  1 - 1
    // 274 3 - 1
    // 82  5 - 1
    // 68  7 - 1
    // 44  1 - 2

    const right = 1;
    const down = 2;

    let horizontalPos = 0;
    for (let verticalPos = 0; verticalPos < numOfLines;) {
    
      horizontalPos += right;
      verticalPos += down;

      if (horizontalPos >= lineLength) horizontalPos -= lineLength;

      let currentSquare;
      try {
        currentSquare = area[verticalPos][horizontalPos];
      } catch {
        break;
      }

      if (currentSquare === tree) counter++;
    }

    console.log(`Trees counted: ${counter}`);

  }
}

fs.readFile("Day\ 3/advent-3-input.txt", "UTF-8", readData);