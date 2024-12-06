const fs = require("fs");
const readline = require('readline');

let counter = 0;

const lineInterface = readline.createInterface({
  input: fs.createReadStream("Day\ 2/advent-2-input.txt")
});

lineInterface.on("line", line => {
  const matchArray = line.match(/(\d+)-(\d+)\s(\w):\s(\w*)/);
  const indexOne = matchArray[1] - 1;
  const indexTwo = matchArray[2] - 1;
  const letter = matchArray[3];
  const password = matchArray[4];

  const posOneExists = password[indexOne] === letter;
  const posTwoExists = password[indexTwo] === letter;
 
  if (posOneExists ? !posTwoExists : posTwoExists) {
    counter++;
  }
});

setTimeout(() => {
  console.log(counter);
}, 2000);