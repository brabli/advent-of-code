const fs = require("fs");
const readline = require('readline');

let counter = 0;

const lineInterface = readline.createInterface({
  input: fs.createReadStream("Day\ 2/advent-2-input.txt")
});

lineInterface.on("line", line => {
  const matchArray = line.match(/(\d+)-(\d+)\s(\w):\s(\w*)/);
  const lowNum = matchArray[1];
  const highNum = matchArray[2];
  const letter = matchArray[3];
  const password = matchArray[4];
  const numOfLetterOccurences = (password.split(letter).length - 1);
  if (numOfLetterOccurences >= lowNum && numOfLetterOccurences <= highNum) {
    counter++;
  }
});

setTimeout(() => {
  console.log(counter);
}, 1000);