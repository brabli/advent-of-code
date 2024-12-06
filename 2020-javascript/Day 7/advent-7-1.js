const fs = require("fs");
let colours = [];

function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    const rules = ruleParser(data);
    countBags(rules, "shinygold");
    colours = [...new Set(colours)];
    console.log(colours.length);
  }
}

// Recursive function that appends all the colours to an array.
function countBags(rules, lookupColour) {
  const ruleKeys = Object.keys(rules);
  for (let i = 0; i < ruleKeys.length; i++) {
    const keyColour = ruleKeys[i];
    const values = rules[keyColour];
    if (values.find(col => col === lookupColour)) {
      colours.push(keyColour);
      countBags(rules, keyColour);
    } else {
      continue;
    }
  }
}

// Parses input into an object.
function ruleParser(data) {
  const colourRules = {};
  const ruleSentences = data.split("\n");
  ruleSentences.forEach(sentence => {
    const bagColour = getBagColour(sentence);
    if (sentence.indexOf("no other bags") !== -1) {
      colourRules[bagColour] = [];
    } else {
      const containedColours = getContainedColours(sentence);
      colourRules[bagColour] = containedColours;
    }  
  });
  return colourRules;
}

function getBagColour(sentence) {
  const bagColourParts = sentence.split(" bags contain ")[0].split(" ");
  const bagColour = bagColourParts[0] + bagColourParts[1];
  return bagColour;
}

function getContainedColours(sentence) {
  const containedColoursUnsanitised = sentence.split("contain")[1].split(",");
  const containedColoursSanitised = containedColoursUnsanitised.map(unsanitisedColour => {
    const sanitisedColourParts = unsanitisedColour.match(/(\s?\d+\s)(\w+\s\w+)(\s.{3,4})/)[2].split(" ");
    const sanitisedColour = sanitisedColourParts[0] + sanitisedColourParts[1];
    return sanitisedColour;
  });
  return containedColoursSanitised;
}

fs.readFile("Day\ 7/advent-7-input.txt", "UTF-8", readData);

/* Psuedo Code

Determine the bag you are looking for. (EG starting point is a shiny gold bag)
For each colour, look at what bags it can contain and go through list until a colour is found that can contain the bag colour are looking for.

Now go through the list again until you find a colour that can contain that colour.

Repeat this process until no more colours are found, add one to the counter of bags that can store the original bag then continue down the list looking for bags that contain the bag you are looking for. 


*/