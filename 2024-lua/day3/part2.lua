local file = "./input.txt"

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

local function find_matches(input, pattern, matches)
   local current_index = 1
   for match in string.gmatch(input, pattern) do
      local _, end_of_match_index = string.find(input, match, current_index, true)

      if end_of_match_index ~= nil then
         matches[end_of_match_index] = match
         current_index = end_of_match_index
      end
   end
end

local function order_by_keys(tbl)
   local tkeys = {}
   for key in pairs(tbl) do
      table.insert(tkeys, key)
   end

   table.sort(tkeys)

   local ordered_tbl = {}
   for _, value in pairs(tkeys) do
      table.insert(ordered_tbl, tbl[value])
   end

   return ordered_tbl
end

local function calculate_answer(instructions)
   local total, enabled = 0, true

   for _, instruction in pairs(instructions) do
      if string.find(instruction, Mul_pattern) then
         if enabled then
            total = total + multiply_mul(instruction)
         end
      elseif string.find(instruction, Do_pattern) then
         enabled = true
      elseif string.find(instruction, Dont_pattern) then
         enabled = false
      else
         print("Invalid: " .. instruction)
      end
   end

   return total
end

local function get_total(line)
   Mul_pattern = "mul%(%d+,%d+%)"
   Do_pattern = "do%(%)"
   Dont_pattern = "don't%(%)"

   local matches = {}

   find_matches(line, Mul_pattern, matches)
   find_matches(line, Do_pattern, matches)
   find_matches(line, Dont_pattern, matches)

   local ordered_matches = order_by_keys(matches)

   local total = calculate_answer(ordered_matches)

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
