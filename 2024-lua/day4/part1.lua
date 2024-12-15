local input_path = "./example-input.txt"

local function print_grid(grid)
   print()

   for _, value in pairs(grid) do
      if "table" == type(value) then
         print(table.concat(value))
      end
   end

   print()
   print("Height: " .. grid.height)
   print("Width: " .. grid.width)
   print()
end

local function create_grid()
   local grid = {}

   local r = 1
   for row in io.lines(input_path) do
      grid[r] = {}

      for i = 1, #row do
         local char = string.sub(row, i, i)
         grid[r][i] = char
      end

      r = r + 1
   end

   grid.width = #grid[1]
   grid.height = r

   return grid
end

local function main()
   local grid = create_grid()
   print_grid(grid)
end

main()
