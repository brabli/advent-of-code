#!/bin/bash

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo;
    echo "Create the file structure for a new day."
    echo;
    echo "Usage: $0 <DAY NUMBER>"
    echo "Options:"
    echo "  -h, --help    Display this help message"
    echo;
    exit 0
fi

if [ -z $1 ]; then
    echo "Pass in a day number to create the day's structure."
    exit 1
fi

DIR="day$1"

mkdir $DIR

cd $DIR

touch example_input.txt
touch input.txt
touch part1.lua
touch part2.lua

