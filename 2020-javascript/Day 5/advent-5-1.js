const fs = require("fs");

function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    let currentHighestSeatId = 0;
    const boardingPasses = data.split("\n");

    boardingPasses.forEach(pass => {
     
      const row = findRow(pass);
      const col = findCol(pass);
      const seatId = getSeatId(row, col);
      if (seatId > currentHighestSeatId) currentHighestSeatId = seatId;
    });

    console.log(currentHighestSeatId);

  }
}

function getSeatId(row, col) {
  return row * 8 + col;
}

function findCol(pass) {
  const colCharacters = [...pass.slice(7)];
  let possibleCols = [];
  for (let i = 0; i <= 7; i++) {
    possibleCols.push(i);
  }

  colCharacters.forEach(letter => {
    const halfwayIndex = possibleCols.length / 2;
    if (letter === "L") {
      possibleCols = possibleCols.slice(0, halfwayIndex);
    } else {
      possibleCols = possibleCols.slice(halfwayIndex);
    }
  });

  return possibleCols[0];

}

function findRow(pass) {
  const rowCharacters = [...pass.slice(0, 7)];
  let possibleRows = [];
  for (let i = 0; i <= 127; i++) {
    possibleRows.push(i);
  }
  
  rowCharacters.forEach(letter => {
    const halfwayIndex = possibleRows.length / 2;
    if (letter === "F") {
      possibleRows = possibleRows.slice(0, halfwayIndex);
    } else {
      possibleRows = possibleRows.slice(halfwayIndex);
    }
  });

  return possibleRows[0];
}



fs.readFile("Day\ 5/advent-5-input.txt", "UTF-8", readData);