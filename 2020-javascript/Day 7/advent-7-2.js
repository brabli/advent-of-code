const fs = require("fs");
let counter = 0;

function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {
    const rules = ruleParser(data);
    countBags(rules, "shinygold");
    console.log(counter);
  }
}

/* Psuedo Code

Determine the bag you are looking for. (EG starting point is a shiny gold bag.)
Loop over the colours that the lookup bag can contain the number of times that bag must be contained. EG, if the gold bag contains 2 blue bags and 3 orange bags, find blue twice and orange thrice.
Once no more colours are found, add one to counter and continue.

*/

// Recursive function that counts the total number of bags required inside the target bag colour.
function countBags(rules, lookupColour) {
  const innerColoursAndAmounts = rules[lookupColour];
  // Loop over bags that must be contained within the current bag.
  for (let i = 0; i < innerColoursAndAmounts.length; i++) {
    const innerColour = innerColoursAndAmounts[i][1];
    const innerColourAmount = innerColoursAndAmounts[i][0];
    // Loop over each inner bag the number of times it must be contained within it's parent bag.
    for (let j = 0; j < innerColourAmount; j++) {
      countBags(rules, innerColour);
      counter++;
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
    const sanitisedColourParts = unsanitisedColour.match(/\s?(\d+)\s(\w+\s\w+)(\s.{3,4})/);
    const sanitisedColourNames = sanitisedColourParts[2].split(" ");
    const sanitisedColour = sanitisedColourNames[0] + sanitisedColourNames[1];
    const numberOfColours = sanitisedColourParts[1];
    return [numberOfColours, sanitisedColour];
  });

  return containedColoursSanitised;
}

fs.readFile("Day\ 7/advent-7-input.txt", "UTF-8", readData);