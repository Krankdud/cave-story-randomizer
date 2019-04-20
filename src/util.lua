local lfs = require "lfs"
local table = table

local U = {}

-- https://www.lua.org/manual/5.1/manual.html#5.7
-- w+: Update mode, all previous data is erased;
-- b:  Binary mode, forces Windows to save with Unix endings.
MODE_WRITE_ERASE_EXISTING = 'w+b'

function U.writeFile(path, data)
  logDebug('writing file: ' .. path)

  local file, err = io.open(path, MODE_WRITE_ERASE_EXISTING)
  assert(err == nil, err)
  file:write(data)
  file:flush()
  file:close()
end

function U.copyFile(src, dest)
  local src, err = io.open(src, "rb")
  assert(err == nil, err)
  U.writeFile(dest, src:read("*a"))
  src:close()
end

-- Equivilant of love.filesystem.getDirectoryItems using lfs to get the files
function U.getDirectoryItems(path)
  local items = {}
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      table.insert(items, file)
    end
  end

  return items
end

return U
