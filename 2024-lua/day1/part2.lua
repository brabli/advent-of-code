local example_input = "./example-input.txt"
local input = "./input.txt"

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
   local number_lists = get_number_lists(input)
   local left = number_lists[1]
   local right = number_lists[2]

   local answer_total = 0

   for _, left_val in pairs(left) do
      local counter = 0
      for _, right_val in pairs(right) do
         if left_val == right_val then
            counter = counter + 1
         end

         answer_total = answer_total + left_val * counter
         counter = 0
      end
   end

   print(answer_total)
end

run()
