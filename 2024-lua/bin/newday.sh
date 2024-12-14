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

# Is arg a number
if ! expr "$1" + 0 > /dev/null 2>&1; then
    echo "Only pass in a day number to create that day's structure."
    exit 1
fi

if echo "$(pwd)" | grep -q -E 'day\d+$'; then
    cd '../'
fi

DIR="day$1"

mkdir $DIR

cd $DIR

touch example_input.txt
touch input.txt
touch part1.lua
touch part2.lua

init_code='local input = "./example-input.txt"

local function main()
   -- code here
end

main()
'

echo -e "$init_code" > part1.lua
echo -e "$init_code" > part2.lua

echo "Created $DIR."

