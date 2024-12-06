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
        if (testData(passport)) {
          validPassports++;
          return;
        }
      } 
      invalidPassports++;
    });

    console.log("Valid: " + validPassports);
    console.log("Invalid: " + invalidPassports)

  }
}

// Checks whether passport contains all expected fields.
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

// Checks whether all data from valid passports is valid.
function testData(passport) {

  let byr = false;
  const birthYear = Number(passport["byr"]);
  if (birthYear >= 1920 && birthYear <= 2002) byr = true;

  let iyr = false;
  const issueYear = Number(passport["iyr"]);
  if (issueYear >= 2010 && issueYear <= 2020) iyr = true;

  let eyr = false;
  const expirationYear = Number(passport["eyr"]);
  if (expirationYear >= 2020 && expirationYear <= 2030) eyr = true;

  let hgt = false;
  const heightMatches = passport["hgt"].match(/(\d+)(cm|in)/);
  if (heightMatches !== null) {
    const heightValue = Number(heightMatches[1]);
    const heightUnit = heightMatches[2];
    if (heightUnit === "in") {
      if (heightValue >= 59 && heightValue <= 76) hgt = true;
    } else if (heightUnit === "cm") {
      if (heightValue >= 150 && heightValue <= 193) hgt = true;
    }
  }

  let hcl = false;
  const hairColourMatch = passport["hcl"].match(/#[0-9a-f]*/);
  if (passport["hcl"].length === 7 && hairColourMatch !== null) hcl = true;

  let ecl = false;
  const eyecolourMatch = passport["ecl"].match(/(amb|blu|brn|gry|grn|hzl|oth)/); 
  if (eyecolourMatch !== null) {
    ecl = true;
  }

  let pid = false;
  const passportIdMatch = passport["pid"].match(/[0-9]{9}/);
  if (passport["pid"].length === 9 && passportIdMatch !== null) pid = true;

  if (byr && iyr && eyr && hgt && hcl && ecl && pid) {
    return true;
  } else {
    return false;
  }
}

fs.readFile("Day\ 4/advent-4-input.txt", "UTF-8", readData);

// byr (Birth Year)
// iyr (Issue Year)
// eyr (Expiration Year)
// hgt (Height)
// hcl (Hair Color)
// ecl (Eye Color)
// pid (Passport ID)
// cid (Country ID) Ignore this!