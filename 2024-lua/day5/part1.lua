local rules_input = "rules.txt"
local pages_input = "pages.txt"

local function print_tbl(table)
   io.write("{ ")

   for k, v in ipairs(table) do
      io.write(v)
      if k ~= #table then
         io.write(", ")
      end
   end

   io.write(" }")
   print()
end

---@return table
local function find_valid_rules(page_list)
   local valid_rules = {}

   for rule in io.lines(rules_input) do
      local rule_is_valid = true
      for number in string.gmatch(rule, "%d+") do
         local match = string.match(page_list, number)
         if nil == match then
            rule_is_valid = false
         end
      end

      if rule_is_valid then
         table.insert(valid_rules, rule)
      end
   end

   return valid_rules
end

local function does_page_list_obey_rule(page_list, rule)
   local first, second = nil, nil

   for number in string.gmatch(rule, "%d+") do
      if nil == first then
         first = string.find(page_list, number)
      else
         second = string.find(page_list, number)
      end
   end

   return first < second
end

---@return boolean
local function is_page_list_valid(page_list)
   local valid_rules = find_valid_rules(page_list)

   for _, rule in pairs(valid_rules) do
      if not does_page_list_obey_rule(page_list, rule) then
         return false
      end
   end

   return true
end

local running_total = 0

for page_list in io.lines(pages_input) do
   local valid_page_lists = {}

   if is_page_list_valid(page_list) then
      table.insert(valid_page_lists, page_list)
   end

   for _, valid_page_list in pairs(valid_page_lists) do
      local page_list_table = {}
      for number in string.gmatch(valid_page_list, "%d+") do
         table.insert(page_list_table, number)
      end

      local centre_index = math.ceil(#page_list_table / 2)
      running_total = running_total + page_list_table[centre_index]
   end
end

print(running_total)

-- Return a table of rules that apply to the current page list
--    Check each rule, if both numbers are contained within the pages it is a valid rule
--
-- For each valid rule, check to make sure the first number comes first in pages and the second number comes later
--    If so, it is valid.
--
-- For each valid set of pages, find the middle number.
