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

local function check_backwards(grid, row, cell)
   return grid[row][cell] .. (grid[row][cell - 1] or "") .. (grid[row][cell - 2] or "") .. (grid[row][cell - 3] or "")
end

local function check_forwards(grid, row, cell)
   return grid[row][cell] .. (grid[row][cell + 1] or "") .. (grid[row][cell + 2] or "") .. (grid[row][cell + 3] or "")
end

local function check_up(grid, row, cell)
   return grid[row][cell] .. (grid[row + 1][cell] or "") .. (grid[row + 2][cell] or "") .. (grid[row + 3][cell] or "")
end

local function check_down(grid, row, cell)
   return grid[row][cell] .. (grid[row - 1][cell] or "") .. (grid[row - 2][cell] or "") .. (grid[row - 3][cell] or "")
end

local function check_tl_diag(grid, row, cell)
   return grid[row][cell]
      .. (grid[row - 1][cell - 1] or "")
      .. (grid[row - 2][cell - 2] or "")
      .. (grid[row - 3][cell - 3] or "")
end

local function check_tr_diag(grid, row, cell)
   return grid[row][cell]
      .. (grid[row - 1][cell + 1] or "")
      .. (grid[row - 2][cell + 2] or "")
      .. (grid[row - 3][cell + 3] or "")
end

local function check_bl_diag(grid, row, cell)
   return grid[row][cell]
      .. (grid[row + 1][cell - 1] or "")
      .. (grid[row + 2][cell - 2] or "")
      .. (grid[row + 3][cell - 3] or "")
end

local function check_br_diag(grid, row, cell)
   return grid[row][cell]
      .. (grid[row + 1][cell + 1] or "")
      .. (grid[row + 2][cell + 2] or "")
      .. (grid[row + 3][cell + 3] or "")
end

local function main()
   local grid = create_grid().grid
   local results = {}

   for row_i, row in pairs(grid) do
      for cell_i, cell in pairs(row) do
         if cell == "X" then
            table.insert(results, check_backwards(grid, row_i, cell_i))
            table.insert(results, check_forwards(grid, row_i, cell_i))
            table.insert(results, check_up(grid, row_i, cell_i))
            table.insert(results, check_down(grid, row_i, cell_i))
            table.insert(results, check_tl_diag(grid, row_i, cell_i))
            table.insert(results, check_tr_diag(grid, row_i, cell_i))
            table.insert(results, check_bl_diag(grid, row_i, cell_i))
            table.insert(results, check_br_diag(grid, row_i, cell_i))
         end
      end
   end

   local total = 0
   for _, value in pairs(results) do
      if value == "XMAS" then
         total = total + 1
      end
   end

   print(total)
end

main()
