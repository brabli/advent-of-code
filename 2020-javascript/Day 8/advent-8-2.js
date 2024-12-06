const fs = require("fs");
const { parse } = require("path");


function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {

    const instructions = parseDataToInstructions(data);

    let globalNopJmpCounter = 0;

    // Brute force loop
    for (let i = 0; i < 2000; i++) {

      let localNopJmpCounter = 0;
      let accumulator = 0;
      const executedInstructions = [];
      let instructionIndex = 0;

      // Program execution loop
      let execute = true;
      while (execute) {

        // Stop everything if program terminates successfully.
        if (instructions[instructionIndex] === undefined) {
          console.log("Instructions run out! Acc value: " + accumulator);
          execute = false;
          i = 3000;
          break;
        }

        // Terminate current loop if an instruction has been executed before.
        const executedBefore = executedInstructions.find(previouslyRunIndexes => previouslyRunIndexes === instructionIndex);
        if (executedBefore !== undefined) {
          execute = false;
          globalNopJmpCounter++;
          console.log("Loop detected! i value is " + i + " and instructionIndex is " + instructionIndex);
          break;
        } 
 
        // Adds to jmp-nop counter and switches instructions if needs be.\
        let command = instructions[instructionIndex][0];
        const value = instructions[instructionIndex][1];
        if (command === "nop" || command === "jmp") {
          if (localNopJmpCounter === globalNopJmpCounter) {
            command = command === "nop" ? "jmp" : "nop";
          }
          localNopJmpCounter++;
        }

        // Executes instruction.
        executedInstructions.push(instructionIndex);
        console.log("Executing index " + instructionIndex);
        switch (command) {
          case "nop":
            instructionIndex++;
            break;
          case "acc":
            accumulator += value;
            instructionIndex++;
            break;
          case "jmp":
            instructionIndex += value;
            break;
          default:
            console.log("ERROR");
            execute = false;
        } 
      }
    }  
  }
}

function parseDataToInstructions(data) {
  const dataSplit = data.split("\n");
  const instructions = dataSplit.map(line => {
    const lineMatches = line.match(/(\w{3})\s(.\d+)/);
    const command = lineMatches[1];
    const value = Number(lineMatches[2]);
    return [command, value];
  });
  return instructions;
}

fs.readFile("Day\ 8/advent-8-input.txt", "UTF-8", readData);