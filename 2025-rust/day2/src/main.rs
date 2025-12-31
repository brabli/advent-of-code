#![allow(dead_code)]

use std::{fs, ops::RangeInclusive};

fn main() {
    let ranges = {
        let content_string = fs::read_to_string("example.txt").unwrap();
        let split_strings = content_string.trim().split(",");

        split_strings
            .map(|s| Range::from(s))
            .collect::<Vec<Range>>()
    };

    let invalid_ids = vec![];

    for range in ranges {
        // Looping over the numbers in a single Range
        for i in range.into_iter() {
            let divisors_per_number = {
                let len = i.to_string().len();
                let mut divisors = vec![];

                for i in 2..=len {
                    if len % i == 0 {
                        divisors.push(i);
                    }
                }

                divisors
            };

            for divisor in divisors_per_number {
                let num_as_chars = i.to_string().chars().collect::<Vec<char>>();
                let vec_of_chunks = num_as_chars.chunks_exact(divisor).collect::<Vec<&[char]>>();
                for chunk_of_chars in vec_of_chunks {
                    let num_as_string = chunk_of_chars.iter().collect::<String>();
                    let num = num_as_string.parse::<i64>().unwrap();
                }
            }
        }
    }

    let answer = invalid_ids.iter().fold(0, |acc, i| acc + i);

    // dbg!(answer);
}

#[derive(Debug)]
struct Range {
    start: i64,
    end: i64,
}

impl From<&str> for Range {
    fn from(raw: &str) -> Range {
        let (prefix, suffix) = raw
            .rsplit_once("-")
            .expect(format!("{} Input must contain a hyphen.", raw).as_str());
        let start = prefix.parse::<i64>().unwrap();
        let end = suffix.parse::<i64>().unwrap();
        assert!(start < end);

        Range { start, end }
    }
}

impl IntoIterator for Range {
    type Item = i64;

    type IntoIter = RangeInclusive<i64>;

    fn into_iter(self) -> Self::IntoIter {
        self.start..=self.end
    }
}
