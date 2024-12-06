const fs = require("fs");


function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    /// Code goes here!
    
  }
}


fs.readFile("Day\ ?/advent-?-input.txt", "UTF-8", readData);