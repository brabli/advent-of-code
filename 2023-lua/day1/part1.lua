local function process_lines(file)
    local total = 0
    for line in io.lines(file) do
        local first = string.match(line, "%d")
        local rev_line = string.reverse(line)
        local second = string.match(rev_line, "%d")
        local number = first .. second
        total = number + total
    end

    print(total)
end

process_lines("./input.txt")
