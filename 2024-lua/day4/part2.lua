local input_path = "./input.txt"

---Print the table representing the grid
---@param grid table
local function print_grid(grid)
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

---Create the initial grid from the input
---@return table
local function create_grid()
   local grid = {}
   grid.grid = {}

   local r = 1
   for row in io.lines(input_path) do
      grid.grid[r] = {}

      for i = 1, #row do
         local char = string.sub(row, i, i)
         grid.grid[r][i] = char
      end

      r = r + 1
   end

   grid.width = #grid.grid[1]
   grid.height = r

   setmetatable(grid.grid, {
      __index = function(t, k)
         if k == "width" or k == "height" then
            return rawget(t, k)
         end

         return rawget(t, k)
            or setmetatable({}, {
               __index = function()
                  return ""
               end,
            })
      end,
   })

   return grid
end

local function check_diag_1(grid, row, cell)
   return (grid[row - 1][cell - 1] or "") .. grid[row][cell] .. (grid[row + 1][cell + 1] or "")
end

local function check_diag_2(grid, row, cell)
   return (grid[row - 1][cell + 1] or "") .. grid[row][cell] .. (grid[row + 1][cell - 1] or "")
end

local function main()
   local grid = create_grid().grid
   local total = 0

   for row_i, row in pairs(grid) do
      for cell_i, cell in pairs(row) do
         if cell == "A" then
            local d1 = check_diag_1(grid, row_i, cell_i)
            if d1 == "SAM" or d1 == "MAS" then
               local d2 = check_diag_2(grid, row_i, cell_i)
               if d2 == "SAM" or d2 == "MAS" then
                  total = total + 1
               end
            end
         end
      end
   end

   print(total)
end

main()
