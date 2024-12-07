package.path = package.path .. ";../?.lua"
local debug = require("lib.debug")

local input = "./example_input.txt"

local function main()
   for report in io.lines(input) do
      print(report)
   end
end

local function is_decreasing() end

local function is_increasing() end

main()
