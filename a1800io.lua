-- io related stuff
require 'io'

local function curl(URL)
    io.popen("curl "..URL)
end

local function openFile(_path)
    return io.open(_path, "a")
end