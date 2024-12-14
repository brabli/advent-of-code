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

---@param report string
---@return boolean
local function is_report_safe(report)
   local decreasing = is_decreasing(report)
   local increasing = is_increasing(report)
   local gradual = is_gradual(report)

   return (decreasing or increasing) and gradual
end

---@return number[]
local function create_dampened_reports(report)
   local numbers_in_report = {}

   for number in string.gmatch(report, "%d+") do
      table.insert(numbers_in_report, number)
   end

   local damp_reports = {}

   for i = 1, #numbers_in_report do
      local damp_report = {}

      for j = 1, #numbers_in_report do
         if i ~= j then
            table.insert(damp_report, numbers_in_report[j])
         end
      end

      local damp_report_string = table.concat(damp_report, " ")

      table.insert(damp_reports, damp_report_string)
   end

   return damp_reports
end

local function is_dampened_report_safe(report)
   local dampened_reports = create_dampened_reports(report)

   for _, damp_report in pairs(dampened_reports) do
      report = tostring(damp_report)
      if is_report_safe(report) then
         return true
      end
   end

   return false
end

local function main()
   local num_safe_reports = 0

   for report in io.lines(input) do
      if is_report_safe(report) then
         num_safe_reports = num_safe_reports + 1
      else
         if is_dampened_report_safe(report) then
            num_safe_reports = num_safe_reports + 1
         end
      end
   end

   print("Number of safe reports: " .. num_safe_reports)
end

main()
