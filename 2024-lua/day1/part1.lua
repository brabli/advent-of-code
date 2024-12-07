local example_input = "./input.txt"

local function main()
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

main()
