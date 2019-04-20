local bitser = require "lib.bitser"

local Config = {
  options = {
    character = 1,
    gamePath = ""
  }
}

function Config:load()
  pcall(function ()
    local options = bitser.loadLoveFile("config")
    self.options = options
  end)
end

function Config:save()
  bitser.dumpLoveFile("config", self.options)
end

return Config
