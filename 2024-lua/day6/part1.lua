local input = "./example-input.txt"

local function get_start_coords()
   local row_index = 0

   for line in io.lines(input) do
      row_index = row_index + 1

      local col_index = 0

      for c in string.gmatch(line, ".") do
         col_index = col_index + 1

         if c == "^" then
            return { col_index, row_index }
         end
      end
   end
end

local function get_obstacles()
   local obstacles = {}
   local row_index = 0

   for line in io.lines(input) do
      row_index = row_index + 1

      local col_index = 0

      for c in string.gmatch(line, ".") do
         col_index = col_index + 1

         if c == "#" then
            table.insert(obstacles, { col_index, row_index })
         end
      end
   end

   return obstacles
end

local starting_coords = get_start_coords()
local obstacles = get_obstacles()
