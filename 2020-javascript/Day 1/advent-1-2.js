const fs = require("fs");

function readData(err, data) {
    if (err) {
        console.log("Error!" + "\n" + err.message);
    } else {

        const stringNumbersArray = data.split("\n");
        const numbersArray = stringNumbersArray.map(num => Number(num));

        for (let i = 0; i < numbersArray.length; i++) {
            const numOne = numbersArray[i];

            for (let j = 0; j < numbersArray.length; j++) {
                const numTwo = numbersArray[j];

                for (let k = 0; k < numbersArray.length; k++) {
                    const numThree = numbersArray[k];
                    if (numOne + numTwo + numThree === 2020) {
                        const answer = numOne * numTwo * numThree;
                        console.log(`The answer is ${answer}`);
                        break;

                    }
                }
            }
        }
    }
}

fs.readFile("Day\ 1/advent-1-input.txt", "UTF-8", readData);
