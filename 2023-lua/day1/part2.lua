local function process_lines(file)
    local total = 0
    for line in io.lines(file) do
        line = string.gsub(line, "one", "1")
        line = string.gsub(line, "two", "2")
        line = string.gsub(line, "three", "3")
        line = string.gsub(line, "four", "4")
        line = string.gsub(line, "five", "5")
        line = string.gsub(line, "six", "6")
        line = string.gsub(line, "seven", "7")
        line = string.gsub(line, "eight", "8")
        line = string.gsub(line, "nine", "9")
        print(line)
        local first = string.match(line, "%d")
        print(first)
        local rev_line = string.reverse(line)
        local second = string.match(rev_line, "%d")
        print(second)
        local number = first .. second
        total = number + total
    end

    print(total)
end

process_lines("./input.txt")
