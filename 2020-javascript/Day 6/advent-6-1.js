const fs = require("fs");


function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    let questionCount = 0;
    const dataStrings = createStrings(data);
    dataStrings.forEach(dataString => {
      const spreadStringArray = [...dataString];
      const uniqueAnswersArray = [...new Set(spreadStringArray)];
      questionCount += uniqueAnswersArray.length;
    });
    
    console.log(questionCount);
  }
}



function createStrings(data) {
  let currentString = "";
  const dataStrings = [];
  if (data[data.length - 1] !== "\n") data += "\n";
  const dataSplitByNewline = data.split("\n");
  dataSplitByNewline.forEach(line => {
    if (line !== "") {
      currentString += line;
    } else {
      dataStrings.push(currentString);
      currentString = "";
    }
  });
  return dataStrings;
}

fs.readFile("Day\ 6/advent-6-input.txt", "UTF-8", readData);