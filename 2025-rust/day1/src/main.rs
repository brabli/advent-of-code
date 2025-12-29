use std::fs;

fn main() {
    let file_contents = fs::read_to_string("input.txt").expect("File to be read.");

    let mut dial = Dial::new();
    let mut zero_counter = 0;

    for line in file_contents.lines().into_iter() {
        let turn = Turn::from(line);

        let full_cycles = turn.amount / 100;
        let amount = turn.amount % 100;

        dbg!(full_cycles, amount);

        zero_counter += full_cycles;

        if 0 == amount {
            continue;
        }

        match turn.direction {
            Direction::Left => {
                if dial.value - amount <= 0 && dial.value != 0 {
                    zero_counter += 1;
                }
            }
            Direction::Right => {
                if dial.value + amount >= 100 {
                    zero_counter += 1;
                }
            }
        }

        let pre_turn_value = dial.value;
        dial.turn(turn);

        println!(
            "Zeroes: {}    Dial pre: {}    Dial post: {}",
            zero_counter, pre_turn_value, dial.value,
        );
    }

    // dbg!(zero_counter);
}

#[derive(Debug)]
struct Turn {
    direction: Direction,
    amount: Degrees,
}

#[derive(Debug, PartialEq)]
enum Direction {
    Left,
    Right,
}

type Degrees = i32;

#[derive(Debug)]
struct Dial {
    value: i32,
}

impl Dial {
    fn new() -> Dial {
        Dial { value: 50 }
    }

    fn turn(&mut self, turn: Turn) -> i32 {
        let mut result = match turn.direction {
            Direction::Left => self.value - turn.amount,
            Direction::Right => self.value + turn.amount,
        };

        while result >= 100 {
            result -= 100;
        }

        while result < 0 {
            result += 100;
        }

        self.value = result;

        result
    }
}

impl Turn {
    fn from(line: &str) -> Turn {
        let (letter, degrees) = line
            .split_at_checked(1)
            .expect("Line should have be at least two chars");

        let direction = match letter {
            "L" => Direction::Left,
            "R" => Direction::Right,
            _ => panic!("Raw direction must be an L or R"),
        };

        let degrees = degrees
            .parse::<i32>()
            .expect("Second part of line should be a i32.");

        // assert!(degrees < 100);
        Turn {
            direction,
            amount: degrees,
        }
    }
}
