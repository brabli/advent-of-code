local Debug = {}

---Print out the contents of a flat list
---@param list table
function Debug.list(list)
   for _, v in pairs(list) do
      print(v)
   end
end

return Debug
