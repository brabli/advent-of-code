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

---@param page_list string Page list, EG "12,53,66,25,75"
---@return table All the rules that can be applied to the page_list
local function find_rules(page_list)
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
   local rules = find_rules(page_list)

   for _, rule in pairs(rules) do
      if not does_page_list_obey_rule(page_list, rule) then
         return false
      end
   end

   return true
end

local function get_invalid_page_lists()
   local invalid_page_lists = {}

   for page_list in io.lines(pages_input) do
      if not is_page_list_valid(page_list) then
         table.insert(invalid_page_lists, page_list)
      end
   end

   return invalid_page_lists
end

---@param page_list string
---@return table
local function page_list_to_table(page_list)
   local page_list_table = {}

   for number in string.gmatch(page_list, "%d+") do
      table.insert(page_list_table, number)
   end

   return page_list_table
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

---Returns true if all the rules are followed by the page list.
---@param page_list string
---@param rules table
---@return boolean
local function page_list_follows_all_rules(page_list, rules)
   for _, rule in pairs(rules) do
      if not does_page_list_obey_rule(page_list, rule) then
         return false
      end
   end

   return true
end

---@param page_list string
---@param n1 string
---@param n2 string
---@return string
local function swap_numbers(page_list, n1, n2)
   local s = ""
   local list = page_list_to_table(page_list)

   for k, v in pairs(list) do
      if v == n1 then
         s = s .. n2
      elseif v == n2 then
         s = s .. n1
      else
         s = s .. v
      end

      if k ~= #list then
         s = s .. ","
      end
   end

   return s
end

local running_total = 0

for _, invalid_page_list in pairs(get_invalid_page_lists()) do
   local rules = find_rules(invalid_page_list)

   while not page_list_follows_all_rules(invalid_page_list, rules) do
      for _, rule in pairs(rules) do
         if not does_page_list_obey_rule(invalid_page_list, rule) then
            local n1 = string.match(rule, "^%d+")
            local n2 = string.match(rule, "%d+$")
            invalid_page_list = swap_numbers(invalid_page_list, n1, n2)
         end
      end
   end

   local middle_value = find_middle_value(invalid_page_list)
   running_total = running_total + middle_value
end

print(running_total)
