#![allow(dead_code)]

use std::{fs, ops::RangeInclusive};

fn main() {
    let ranges = {
        let content_string = fs::read_to_string("input.txt").unwrap();
        let split_strings = content_string.trim().split(",");

        split_strings
            .map(|s| Range::from(s))
            .collect::<Vec<Range>>()
    };

    let mut invalid_ids = vec![];

    for range in ranges {
        for i in range.into_iter() {
            let string_number = i.to_string();
            let len = string_number.len();
            if len % 2 != 0 {
                continue;
            }

            let middle_index = len / 2;

            let (first, second) = string_number.split_at(middle_index);

            if first != second {
                continue;
            }

            invalid_ids.push(i);
        }
    }

    let answer = invalid_ids.iter().fold(0, |acc, i| acc + i);

    dbg!(answer);
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
