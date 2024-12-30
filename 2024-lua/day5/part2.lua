local rules_input = "example-rules.txt"
local pages_input = "example-pages.txt"

-- Find incorrect page updates
-- For each page list, find all the rules that correspond to them
-- For each rule check to see if it's being followed
--    If not, swap the two numbers in the page list and loop over the rules again, repeating until all rules are followed.

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

local function get_valid_page_lists()
   local valid_page_lists = {}

   for page_list in io.lines(pages_input) do
      if is_page_list_valid(page_list) then
         table.insert(valid_page_lists, page_list)
      end
   end

   return valid_page_lists
end

---@param page_list string
---@return number
local function find_middle_value(page_list)
   local page_list_table = {}

   for number in string.gmatch(page_list, "%d+") do
      table.insert(page_list_table, number)
   end

   local centre_index = math.ceil(#page_list_table / 2)

   return page_list_table[centre_index]
end

local running_total = 0

for _, valid_page_list in pairs(get_valid_page_lists()) do
   local middle_value = find_middle_value(valid_page_list)
   running_total = running_total + middle_value
end

print(running_total)
