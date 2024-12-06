const fs = require("fs");

function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    const numbers = parseData(data);
    const preamble = numbers.splice(0, 25);
    let target = numbers[0];
    
    while (bruteForcer(preamble, target)) {
      preamble.shift();
      preamble.push(target);
      numbers.shift();
      target = numbers[0];
      if (target === undefined) break;
    }
    console.log("WHILE LOOP OVER")
  }
}

// Returns true if target is found from the preamble numbers
function bruteForcer(preamble, target) {
  let found = false;
  for (let i = 0; i < preamble.length; i++) {
    const firstNum = preamble[i];
    for (let j = 0; j < preamble.length; j++) {
      if (i === j) continue;
      const secondNum = preamble[j];
      if (firstNum + secondNum === target) {
        found = true;
        break;
      }
    }
    if (found === true) return true;
  }
  if (found === false) {
    console.log(target);
    return false;
  }
}

// Parse Data
function parseData(data) {
  splitData = data.split("\n");
  numbers = splitData.map(stringNum => Number(stringNum));
  return numbers;
}

fs.readFile("Day\ 9/advent-9-input.txt", "UTF-8", readData);