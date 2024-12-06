const fs = require("fs");

function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    let questionCount = 0;
    const allGroups = createStrings(data);
    // Once per group
    allGroups.forEach(group => {
      const peopleInGroup = group.length;
      const firstPersonAnswers = group[0].length;
      if (peopleInGroup <= 1) {
        questionCount += firstPersonAnswers;
      } else {
        for (let i = 0; i < firstPersonAnswers; i++) {
          const currentAnswer = group[0][i];
          let foundCount = 0;
          for (let j = 1; j < peopleInGroup; j++) {
            const found = group[j].find(answer => answer === currentAnswer);
            if (found !== undefined) foundCount++;
          }
          if (foundCount === peopleInGroup - 1) questionCount++;
        }
      }
    });
    console.log(questionCount);
  }
}



function createStrings(data) {
  let dataString = [];
  const allDataStrings = [];

  if (data[data.length - 1] !== "\n") data += "\n";
  const dataSplitByNewline = data.split("\n");
  dataSplitByNewline.forEach(line => {
    if (line !== "") {
      dataString.push([...line]);
    } else {
      allDataStrings.push(dataString);
      dataString = [];
    }
  });
  return allDataStrings;
}

fs.readFile("Day\ 6/advent-6-input.txt", "UTF-8", readData);