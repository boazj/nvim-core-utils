---@class util.tables
local M = {}

_G.Tables = M

M.keys = vim.tbl_keys
M.value_count = vim.tbl_count
M.is_list = vim.islist
M.is_array = vim.isarray
M.values = vim.tbl_values
M.is_empty = vim.tbl_isempty
M.iter = vim.iter
M.get_path = vim.tbl_get
M.filter = vim.tbl_filter
M.contains = vim.tbl_contains
M.extend = vim.tbl_extend
M.deep_extend = vim.tbl_deep_extend

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
