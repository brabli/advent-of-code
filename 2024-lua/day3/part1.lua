local input = "./input.txt"

local function get_total(line)
   local running_total = 0

   for match in string.gmatch(line, "mul%(%d+,%d+%)") do
      local digits = string.gmatch(match, "%d+")

      local x
      local y
      for digit in digits do
         if x == nil then
            x = digit
         elseif y == nil then
            y = digit
         end
      end

      running_total = running_total + tonumber(x) * tonumber(y)
   end

   return running_total
end

local function main()
   local running_total = 0

   for line in io.lines(input) do
      running_total = running_total + get_total(line)
   end

   print(running_total)
end

main()
