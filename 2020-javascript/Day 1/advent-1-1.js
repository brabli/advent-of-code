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
                if (numOne + numTwo === 2020) {
                    const answer = numOne * numTwo;
                        console.log(`The answer is ${answer}`);
                    break;
                }
            }
        }
    }
}

// fs.readFile("./advent-1-input.txt", "UTF-8", readData);


// const fs = require("fs");

// function readData(err, data) {
//     if (err) {
//         console.error("Error!" + "\n" + err.message);
//         return;
//     }

//     const numbers = inputStringsToNumbers(data.split("\n"));

//     for (const outerNumber of numbers) {
//         for (const innerNumber of numbers) {
//             const sum = outerNumber + innerNumber;
//             if (2020 === sum) {
//                 console.log(`The answer is ${sum}`);
//                 break;
//             }
//         }
//     }
// }

// function inputStringsToNumbers(stringArray) {
//     return stringArray.map(num => Number(num));
// }

// console.time('a');
// fs.readFile("./advent-1-input.txt", "UTF-8", readData);
// console.timeEnd('a');