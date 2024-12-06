-- Read the file
-- SPlit each line by a space
-- Zip left and right numbers together
-- Sort them both
-- Iterate over each one finding the difference between them

local example_input = "./input.txt"

-- Debug a table
---@param tbl table
local function debug(tbl)
   for v in tbl do
      print(string.rep(" ", 2))
      if type(v) == "table" then
         debug(v)
      else
         print(string.rep(" ", 2) .. tostring(v))
      end
   end
end

local function run()
   local lines = io.lines(example_input)
   local i = 0
   local left = {}
   local right = {}

   for line in lines do
      for match in string.gmatch(line, "%d+") do
         if i % 2 == 0 then
            table.insert(left, match)
         else
            table.insert(right, match)
         end

         i = i + 1
      end
   end

   table.sort(left)
   table.sort(right)

   local total = 0
   for k, lv in pairs(left) do
      local rv = right[k]
      local diff = math.abs(rv - lv)
      total = total + diff
   end

   print(total)
end

run()
