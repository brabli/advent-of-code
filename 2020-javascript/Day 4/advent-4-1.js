const fs = require("fs");

function readData(err, data) {
  if (err) {
    console.log("Error!" + "\n" + err.message);
  } else {

    let validPassports = 0;
    let invalidPassports = 0;
    let currentString = ""
    let passport = {};
    const unparsedPassports = [];
    const parsedPassports= [];
    const dataSplitByNewline = data.split("\n");

    // Create passport strings
    dataSplitByNewline.forEach(line => {
      if (line !== "") {
        currentString += " " + line;
      } else {
        unparsedPassports.push(currentString);
        currentString = "";
      }
    });

    // Parse each passport string into array of objects
    unparsedPassports.forEach(line => {
      const linesSplit = line.trim().split(" ");

      linesSplit.forEach(line => {
        const keyValueArray = line.split(":");
        const key = keyValueArray[0];
        const value = keyValueArray[1];
        passport[key] = value;
      });

      parsedPassports.push(passport);
      passport = {};
    });

    // Check passport keys
    parsedPassports.forEach(passport => {
      if (testForKeys(passport)) {
        console.log("Valid!");
        validPassports++;
      } else {
        console.log("Invalid!");
        console.log(passport);
        invalidPassports++;
      }
    });

    console.log("Valid: " + validPassports);
    console.log("Invalid: " + invalidPassports)

  }
}

fs.readFile("Day\ 4/advent-4-input.txt", "UTF-8", readData);


function testForKeys(passport) {
  const passportKeys = Object.keys(passport);
  const byr = passportKeys.find(key => key === "byr");
  const iyr = passportKeys.find(key => key === "iyr");
  const eyr = passportKeys.find(key => key === "eyr");
  const hgt = passportKeys.find(key => key === "hgt");
  const hcl = passportKeys.find(key => key === "hcl");
  const ecl = passportKeys.find(key => key === "ecl");
  const pid = passportKeys.find(key => key === "pid");
  // This one ignored
  const cid = passportKeys.find(key => key === "cid");
  if (byr && iyr && eyr && hgt && hcl && ecl && pid) {
    return true;
  } else {
    return false;
  }
}

// byr (Birth Year)
// iyr (Issue Year)
// eyr (Expiration Year)
// hgt (Height)
// hcl (Hair Color)
// ecl (Eye Color)
// pid (Passport ID)
// cid (Country ID) Ignore this!