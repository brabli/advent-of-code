const fs = require("fs");


function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    const dataSplit = data.split("\n");
    const instructions = dataSplit.map(line => {
      const lineMatches = line.match(/(\w{3})\s(.\d+)/);
      const command = lineMatches[1];
      const value = Number(lineMatches[2]);
      return [command, value];
    });
    
    const executedInstructions = [];
    let index = 0;
    let acc = 0;
    let execute = true;

    while (execute) {
      if (instructions[index] === undefined) {
        execute = false;
        console.log("Instructions run out! Acc value: " + acc);
      }
      const command = instructions[index][0];
      const value = instructions[index][1];
      const executedBefore = executedInstructions.find(runCmd => runCmd === index);
      if (executedBefore !== undefined) {
        execute = false;
        console.log("Accumulator value is " + acc)
      } else {
        executedInstructions.push(index);
        console.log("Executing index " + index);
        switch (command) {
          case "nop":
            index++;
            break;
          case "acc":
            acc += value;
            index++;
            break;
          case "jmp":
            index += value;
            break;
          default:
            console.log("ERROR");
            execute = false;
        }
      }    
    }
  }
}


fs.readFile("Day\ 8/advent-8-input.txt", "UTF-8", readData);