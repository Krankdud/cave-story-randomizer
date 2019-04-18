local imgui = require "imgui"
local nfd = require "nfd"

local path = ""
local seed = tostring(os.time())

local showTestWindow = false

local Gui = {}

function Gui:render()
  imgui.SetNextWindowPos(40, 100)
  imgui.SetNextWindowSize(560, 80)
  imgui.Begin("Randomizer", nil, {
    "ImGuiWindowFlags_NoTitleBar",
    "ImGuiWindowFlags_NoResize",
    "ImGuiWindowFlags_NoMove",
    "ImGuiWindowFlags_NoScrollbar"
  })

  imgui.PushItemWidth(-120)
  path = imgui.InputText("", path, 1024)
  imgui.PopItemWidth()
  imgui.SameLine()
  if imgui.Button("Choose folder") then
    local folder = nfd.pickFolder()
    if folder then
      path = folder
    end
  end

  imgui.PushItemWidth(-120)
  seed = imgui.InputInt("Seed", seed)
  imgui.PopItemWidth()

  if imgui.Button("Generate!") and self.onGenerate then
    self.onGenerate(seed, path)
  end

  if showTestWindow then
    showTestWindow = imgui.ShowDemoWindow(true)
  end

  imgui.End()
end

return Gui
