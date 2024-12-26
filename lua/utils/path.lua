---@class util.path
local M = {}

_G.Paths = M

-- lua/plenary/path.lua
local path_sep = (function()
  if jit then
    local os = string.lower(jit.os)
    if os ~= 'windows' then
      return '/'
    else
      return '\\'
    end
  else
    return package.config:sub(1, 1)
  end
end)()

-- Returns the project root path
-- (mapped to neovim CWD)
---@return string path project root path (neovim CWD)
function M.project_root()
  return vim.fn.getcwd()
end

-- Gets the name of the project currently open in neovim
-- (neovim CWD directory name)
---@return string name project name
function M.project_name()
  local cwd = M.project_root()
  return M.path_tail(cwd)
end

-- Alters a path to be relative to open project root
-- (mapped to neovim CWD)
---@param path string
---@return string project_path path relative to neovim CWD
function M.project_path(path)
  local sep = M.separator()
  local cwd = M.project_root() .. sep
  return (path:sub(0, #cwd) == cwd) and path:sub(#cwd + 1) or path
end

-- Gets the OS specific path separator
---@return string separator OS specific separator, either "\" or "/"
function M.separator()
  return path_sep
end

-- Gets the last segemant of a path
-- recognized as a field but it's a meta-function
-- receives a path string
M.path_tail = (function()
  local os_sep = M.separator()

  if os_sep == '/' then
    return function(path)
      for i = #path, 1, -1 do
        if path:sub(i, i) == os_sep then
          return path:sub(i + 1, -1)
        end
      end
      return path
    end
  else
    return function(path)
      for i = #path, 1, -1 do
        local c = path:sub(i, i)
        if c == os_sep or c == '/' then
          return path:sub(i + 1, -1)
        end
      end
      return path
    end
  end
end)()

return M