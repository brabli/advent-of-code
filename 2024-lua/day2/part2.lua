local input = "./input.txt"

---@param report string
---@return boolean
local function is_decreasing(report)
   local prev_num = nil

   for match in string.gmatch(report, "%d+") do
      local current_num = tonumber(match)
      if prev_num ~= nil then
         if current_num >= prev_num then
            return false
         end
      end

      prev_num = current_num
   end

   return true
end

---@param report string
---@return boolean
local function is_increasing(report)
   local prev_num = nil

   for match in string.gmatch(report, "%d+") do
      local current_num = tonumber(match)
      if prev_num ~= nil then
         if current_num <= prev_num then
            return false
         end
      end

      prev_num = current_num
   end

   return true
end

local function in_table(table, element)
   for _, value in pairs(table) do
      if value == element then
         return true
      end
   end

   return false
end

---@param report string
---@return boolean
local function is_gradual(report)
   local acceptable_numbers = { 1, 2, 3 }
   local prev = nil

   for match in string.gmatch(report, "%d+") do
      local num = tonumber(match)
      if prev ~= nil then
         local absolute_val = math.abs(prev - num)

         if not in_table(acceptable_numbers, absolute_val) then
            return false
         end
      end

      prev = num
   end

   return true
end

local function main()
   local num_safe_reports = 0

   for report in io.lines(input) do
      local decreasing = is_decreasing(report)
      local increasing = is_increasing(report)
      local gradual = is_gradual(report)

      if (decreasing or increasing) and gradual then
         num_safe_reports = num_safe_reports + 1
      end
   end

   print("Number of safe reports: " .. num_safe_reports)
end

main()
