-- https://www.reddit.com/r/lua/comments/hzi7ff/print_local_variable_as_hex_string/
local function HexToString(hex)
  return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end

-- https://www.reddit.com/r/lua/comments/hzi7ff/print_local_variable_as_hex_string/
--string.format(string.rep("%02x", #variable), variable:byte(1, -1)))
local function StringToHex(str)
  return (str:gsub(".", function(char) return string.format("%02x", char:byte()) end))
end
-- Read as: substitute every character in variable with its byte value formatted as hexadecimal zero-padded to at least 2 digits

--[[old code
  Check given table for metatabledata

local function check_mt(_table)
  if _table.__index ~= nil then
    return true -- is a metatable
  else
    return false --is NOT a metatable
  end
end]]

--[[
  returns table with pairs
]]
local function getkvtable(_table)
  if _table.__index ~= nil then
    return _table
  else
    return debug.getmetatable(_table) --using debug library, instead of getmetatable(table:table)
  end
  --[[if check_mt(_table) == true then
    return debug.getmetatable(_table)
  else
    return _table
  end]]
end

--There are eight basic types in Lua: nil, boolean, number, string, userdata, function, thread, and table. 
--[[
  user giving functions or threads is a stupid idea
  userdata is normally from c, no need to test
]]
local function ValueToString(_value)
  if type(_value) == 'nil' then
    return "nil"
  elseif type(_value) == 'number' then
    return _value
  elseif type(_value) == 'string' then
    return 
  elseif type(_value) == 'boolean' then
  else --failsafe
    print("plz check your code bro")
    return
  end
end

--   table will be looped, no need to test, rest as above
local function IndexToString(_index)
  if type(_index) == 'nil' then
    return "nil"
  elseif type(_index) == 'number' then
    return "[".._index.."]"
  elseif type(_index) == 'string' then
    return "[\"".._index.."\"]"
  elseif type(_index) == 'boolean' then
    if _index then --easier to check and return the boolean number back than true/false which might be a string
      return 1
    else
      return 0
    end
  elseif type(_index) == 'table' then
  else --failsafe
    print("plz check your code bro")
    return
  end
end

local function TableToString(_table)
  local _string = ""
  if type(_table) ~= 'table' then
    return
  end
  -- convert every array or metatable to array (pairs might fail if C-API call is blocked)
  for k,v in pairs(getkvtable(_table)) do --getkvtable to cycle through
    if type(_table[k]) == 'table' then -- use the original table for direct values
      _string = _string..TableToString(_table[k])
    else
      _string = _string..IndexToString(k).."="..ValueToString(v)..","
    end
  end
  return _string
end

local function StringToTable(_string)
  return loadstring(_string)
end