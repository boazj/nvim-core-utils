---@class util.tables
local M = {}

-- Reverses the order of the input table
---@param input_table table
---@return table reveresed_table The reveresed form of the input table
function M.reverse_table(input_table)
  local temp_table = {}
  for index = 0, #input_table do
    temp_table[#input_table - index] = input_table[index + 1] -- Reverses the order
  end
  return temp_table
end

---
---@param tbl table
---@param f fun(value: any): any
---@return table
function M.map(tbl, f)
  local t = {}
  for k, v in pairs(tbl) do
    t[k] = f(v)
  end
  return t
end

---
---@param tbl table
---@param f fun(key:any, value: any): any
---@return table
function M.map_entries(tbl, f)
  local t = {}
  for k, v in pairs(tbl) do
    table.insert(t, f(k, v))
  end
  return t
end

---@generic T
---@param list T[]
---@return T[]
function M.dedup(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

return M