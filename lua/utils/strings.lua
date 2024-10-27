---@class util.strings
local M = {}

--- Return if the parameter string is empty or not
---@param s string | nil
---@return boolean
function M.is_empty(s)
  return s == nil or s == ''
end

--- Removes the last character from the string and returns it
---@param s string | nil string to pop the last character from
---@return string | nil # s without last character and the removed last character, if s is nil or empty will return s
---@return string # The removed last character, empty string if s is nil or empty
function M.pop(s)
  if M.is_empty(s) then
    return s, ''
  end
  ---@cast s string
  return string.sub(s, 1, #s - 1), string.sub(s, #s)
end

--- Appends the given char (or string) to the end of this String
---@param s string | nil String to append the char ch to
---@param ch string String to append to s
---@return string | nil # s with th additional character, nil if s is nil
function M.push(s, ch)
  if s == nil or ch == '' then
    return s
  end
  ---@cast s string
  return s .. ch
end

--- Replace every occurence of string old with string new
---@param s string | nil Base string to operate on
---@param old string | nil Old string to replace
---@param new? string New string to replace with
---@return string | nil # s after replacement, if s or old are nil or '' then s without a change
---@return integer # number of replaced occurences
function M.replace(s, old, new)
  new = new or ''
  if M.is_empty(s) or M.is_empty(old) then
    return s, 0
  end
  ---@cast s string
  ---@cast old string
  local pold = old:gsub('[%(%)%.%%%+%-%*%?%[%^%$%]]', '%%%1')
  local pnew = new:gsub('%%', '%%%%')
  return s:gsub(pold, pnew)
end

--- Removes the specified range in the string, and replaces it with the given string. The given string doesn’t need to be the same length as the range
---@param s string | nil Base string to operate on
---@param new string | nil New string to insert
---@param start_pos integer Start position for insertion
---@param end_pos? integer End position for insertion, if not specified uses end of string (replace suffix behavior)
---@return string | nil # String with the specified ranged replaces with string new
function M.replace_range(s, new, start_pos, end_pos)
  if M.is_empty(s) or M.is_empty(new) or start_pos == nil then
    return s
  end
  ---@cast s string
  ---@cast new string
  -- if start_pos > #s or end_pos > #s then
  --   -- TODO: error
  -- end
  if end_pos == nil then
    return string.sub(s, 0, start_pos - 1) .. new
  end
  return string.sub(s, 0, start_pos - 1) .. new .. string.sub(s, end_pos, #s)
end

--- Insert the string text in a certain position of string s
---@param s string | nil The string
---@param text string | nil The addition string
---@param pos integer The position for insertion
---@return string | nil # String with the additional text
function M.insert(s, text, pos)
  return M.replace_range(s, text, pos, pos)
end

--- Returns a string[] represeting the lines contained in the parameter string
--- keep in mind that any combination of \r and or \n are the bases of split
--- consecutive empty line will be trimmed
---@param s string | nil
---@return string[] | nil
function M.lines(s)
  if s == nil then
    return s
  end

  ---@cast s string
  return vim.split(s, '[\r\n]+', { plain = false })
end

--- Shortens this String to the specified length. Syntactic sugar for string.sub
---@param s string | nil
---@param trunc_pos integer
---@return string | nil
function M.truncate(s, trunc_pos)
  if M.is_empty(s) or trunc_pos > #s then
    return s
  end

  ---@cast s string
  return string.sub(s, 0, trunc_pos)
end

--- Returns the 'character' at the index
---@param s string | nil the string
---@param pos integer an index within the bounds of s
---@return string | nil # char at position pos in string s
function M.char_at(s, pos)
  if M.is_empty(s) or pos > #s then
    return nil
  end
  ---@cast s string
  return string.sub(s, pos, pos)
end

--- Returns a list of single char strings representing the characters in the string s
---@param s string | nil the string
---@return table # list-style table containing the char strings representation of s
function M.chars(s)
  if M.is_empty(s) then
    return {}
  end
  ---@cast s string
  local c = {}
  for v in string.gmatch(s, '.') do
    table.insert(c, v)
  end
  return c
end

--- Returns true if string sub is contained within string s
---@param s string | nil the string
---@param sub string | nil the search string
---@param pos? integer start index
---@return boolean # true if s contains sub, otherwise false
function M.contains(s, sub, pos)
  if sub == '' and s ~= nil then
    return true
  end
  if M.is_empty(s) or M.is_empty(sub) then
    return false
  end
  ---@cast s string
  ---@cast sub string
  pos = pos or 1
  return string.find(s, sub, pos, true) ~= nil
end

--- Does s start with prefix?
--- Exists and deprecated to as a reminder
--- USE vim.startswith
---@param s string | nil the string
---@param prefix string | nil the prefix
---@deprecated
---@return boolean true if s starts with prefix, otherwise false
function M.starts_with(s, prefix)
  if prefix == '' and s ~= nil then
    return true
  end
  if prefix == nil and s == nil then
    return false
  end
  if M.is_empty(s) or M.is_empty(prefix) then
    return s == prefix
  end
  ---@cast s string
  ---@cast prefix string
  if #prefix > #s then
    return false
  end
  return vim.startswith(s, prefix)
  -- return string.find(s, prefix, 1, true) == 1
end

--- Does s end with suffix?
--- Exists and deprecated to as a reminder
--- USE vim.endswith
---@param s string | nil the string
---@param suffix string | nil the suffix
---@deprecated
---@return boolean # true if s ends with suffix, otherwise false
function M.ends_with(s, suffix)
  if suffix == '' and s ~= nil then
    return true
  end
  if suffix == nil and s == nil then
    return false
  end
  if M.is_empty(s) or M.is_empty(suffix) then
    return s == suffix
  end
  ---@cast s string
  ---@cast suffix string
  if #suffix > #s then
    return false
  end
  return vim.endswith(s, suffix)
  --return string.find(s, suffix, #s - #suffix + 1, true) and true or false
end

--- Splits the string s using separator sep
--- Exists and deprecated to as a reminder
--- USE vim.trim
---@param s string | nil String to split
---@param sep string | nil Separator
---@deprecated
---@return table # Splitted parts
function M.split(s, sep)
  if M.is_empty(s) or M.is_empty(sep) then
    return {}
  end
  ---@cast s string
  ---@cast sep string
  return vim.split(s, sep, { plain = true })
end

--- Joins the string s using separator sep
--- Exists and deprecated as a reminder
--- USE table.concat
---@param s string[] | nil Strings to join
---@param sep? string Separator
---@deprecated
---@return string | nil # Joined string
function M.join(s, sep)
  if s == nil then
    return nil
  end
  if s == {} then
    return ''
  end
  sep = sep or ''
  ---@cast s string[]
  ---@cast sep string
  return table.concat(s, sep)
end

--- Trims the string s from both ends
--- Exists and deprecated to as a reminder
--- USE vim.trim
---@param s string | nil String to trim
---@deprecated
---@return string | nil # Trimmed string
function M.trim(s)
  if M.is_empty(s) then
    return s
  end
  ---@cast s string
  return vim.trim(s)
end

--- Trims the string s from start only
---@param s string | nil String to trim
---@return string | nil # Trimmed string
function M.trim_start(s)
  if M.is_empty(s) then
    return s
  end
  ---@cast s string
  local r, _ = string.gsub(s, '^%s+', '')
  return r
end

--- Trims the string s from end only
---@param s string | nil String to trim
---@return string | nil # Trimmed string
function M.trim_end(s)
  if M.is_empty(s) then
    return s
  end
  ---@cast s string
  local r, _ = string.gsub(s, '%s+$', '')
  return r
end

local function _pad(s, width, pad, pstart, pend)
  pad = pad or ' '
  if M.is_empty(s) then
    return string.rep(pad, width)
  end
  if #s >= width then
    return s
  end
  local sw = #s
  local pre = ''
  local post = ''
  if pstart and pend then
    local w_end = math.ceil((width - sw) / 2)
    local w_start = width - sw - w_end
    pre = string.rep(pad, w_start)
    post = string.rep(pad, w_end)
  elseif pstart then
    pre = string.rep(pad, width - sw)
  else
    post = string.rep(pad, width - sw)
  end
  return pre .. s .. post
end

--- Centers the string s within a given width by prepanding and appending a given pad character (defaults to space)
--- This method "leans" to towards the end, in case of non even spacing and trailing space will be appended to the string
---@param s string? string s
---@param width integer given width
---@param pad string? pad character
---@return string
function M.center(s, width, pad)
  return _pad(s, width, pad, true, true)
end

--- Pre-pad the string s with a given pad character (defaults to space) to match the given width
---@param s string? string s
---@param width integer given width
---@param pad string? pad character
---@return string
function M.pad_start(s, width, pad)
  return _pad(s, width, pad, true, false)
end

--- Post-pad the string s with a given pad character (defaults to space) to match the given width
---@param s string? string s
---@param width integer given width
---@param pad string? pad character
---@return string
function M.pad_end(s, width, pad)
  return _pad(s, width, pad, false, true)
end

--- Reverse the string s
--- Exists and deprecated to as a reminder
--- USE string.reverse
---@param s string | nil String to reverse
---@deprecated
---@return string | nil # Reveresed string
function M.reverse(s)
  if M.is_empty(s) then
    return s
  end
  ---@cast s string
  return string.reverse(s)
end

--- Converts a string to lower case form
--- Exists and deprecated to as a reminder
--- USE string.lower
---@param s string String to convert to lower case
---@deprecated
---@return string # Lower case string
function M.to_lower(s)
  return string.lower(s)
end

--- Converts a string to upper case form
--- Exists and deprecated to as a reminder
--- USE string.upper
---@param s string String to convert to upper case
---@deprecated
---@return string # Upper case string
function M.to_upper(s)
  return string.upper(s)
end

--- Capitalizes the first letter of the first word in the given string
---@param s string | nil
---@return string | nil # The capitalized string
function M.capitalize(s)
  if M.is_empty(s) then
    return s
  end
  ---@cast s string
  return (s:gsub('^%l', string.upper))
end

--- Capitalizes the string to title case -> the first letter of each word in a given string
--- currently supports only space as separator, other non-space whitespace will be converted to space
---@param s string | nil The string to convert to title case
---@return string | nil # The title case string
function M.to_title_case(s)
  if M.is_empty(s) then
    return s
  end
  ---@cast s string
  return (s:gsub('(%S)(%S*)', function(f, r)
    return f:upper() .. r
  end))
end

return M
