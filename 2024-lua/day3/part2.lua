local file = "./input.txt"

local function print_table(table)
   for _, value in pairs(table) do
      print(value)
   end
end

local function multiply_mul(mul)
   local digits = string.gmatch(mul, "%d+")

   local x, y

   for digit in digits do
      if x == nil then
         x = digit
      elseif y == nil then
         y = digit
      end
   end

   return tonumber(x) * tonumber(y)
end

local function get_total(line)
   local mul_pattern = "mul%(%d+,%d+%)"
   local do_pattern = "do%(%)"
   local dont_pattern = "don't%(%)"
   local matches = {}

   local current_index = 1
   for match in string.gmatch(line, mul_pattern) do
      local start_of_match_index = string.find(line, match, current_index, true) or 0

      matches[start_of_match_index] = match
      current_index = start_of_match_index + 1
   end

   current_index = 1
   for match in string.gmatch(line, do_pattern) do
      local start_of_match_index = string.find(line, match, current_index, true) or 0

      matches[start_of_match_index] = match
      current_index = start_of_match_index + 1
   end

   current_index = 1

   for match in string.gmatch(line, dont_pattern) do
      local start_of_match_index = string.find(line, match, current_index, true) or 0

      matches[start_of_match_index] = match
      current_index = start_of_match_index + 1
   end

   local tkeys = {}
   for key in pairs(matches) do
      table.insert(tkeys, key)
   end
   table.sort(tkeys)

   local ordered_matches = {}
   for _, value in pairs(tkeys) do
      table.insert(ordered_matches, matches[value])
   end

   local total = 0
   local enabled = true
   for _, instruction in pairs(ordered_matches) do
      if string.find(instruction, mul_pattern) then
         if enabled then
            total = total + multiply_mul(instruction)
         end
      elseif string.find(instruction, do_pattern) then
         enabled = true
      elseif string.find(instruction, dont_pattern) then
         enabled = false
      else
         print("Invalid: " .. instruction)
      end
   end

   return total
end

local function main()
   local input = ""
   for line in io.lines(file) do
      input = input .. line
   end

   print(get_total(input))
end

main()
