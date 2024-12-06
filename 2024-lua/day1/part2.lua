-- Read the file
-- SPlit each line by a space
-- Zip left and right numbers together
-- Sort them both
-- Iterate over each one finding the difference between them

local example_input = "./example-input.txt"

---@param filename string
---@return table
local function get_number_lists(filename)
   local left = {}
   local right = {}

   local i = 0
   for line in io.lines(filename) do
      for match in string.gmatch(line, "%d+") do
         if i % 2 == 0 then
            table.insert(left, match)
         else
            table.insert(right, match)
         end

         i = i + 1
      end
   end

   return { left, right }
end

local function unique_values(tbl)
   local tmp = {}
   for _, value in pairs(tbl) do
      if not table.contains(tmp, value) then
         table.insert(tmp, value)
      end
   end

   return tmp
end

function table.contains(table, element)
   for _, value in pairs(table) do
      if value == element then
         return true
      end
   end
   return false
end

local function dbg(table)
   for _, v in pairs(table) do
      print(v)
   end
end

local function run()
   local number_lists = get_number_lists(example_input)
   local left = number_lists[1]
   local right = number_lists[2]

   local unique_left = unique_values(left)
   dbg(unique_left)
end

run()
