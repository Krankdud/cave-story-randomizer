local imgui = require "imgui"
local nfd = require "nfd"

local Characters = require "characters"

local path = ""
local seed = tostring(os.time())

local showTestWindow = false

local Gui = {}
Gui.status = "Select your Cave Story folder and press Generate! to create a randomized version of the game"
Gui.path = ""

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
  self.path = imgui.InputText("", self.path, 1024)
  imgui.PopItemWidth()
  imgui.SameLine()
  if imgui.Button("Choose folder") then
    local folder = nfd.pickFolder()
    if folder then
      self.path = folder
    end
  end

  imgui.PushItemWidth(-120)
  seed = imgui.InputInt("Seed", seed)
  imgui.PopItemWidth()

  if imgui.Button("Generate!") and self.onGenerate then
    self.onGenerate(seed, self.path)
  end

  if showTestWindow then
    showTestWindow = imgui.ShowDemoWindow(true)
  end

  imgui.End()

  imgui.SetNextWindowPos(40, 200)
  imgui.SetNextWindowSize(200, 200)
  imgui.Begin("Character", nil, {
    "ImGuiWindowFlags_NoResize",
    "ImGuiWindowFlags_NoMove",
    "ImGuiWindowFlags_NoScrollbar",
    "ImGuiWindowFlags_NoCollapse"
  })

  Characters.selected = imgui.Combo("", Characters.selected, Characters.names, #Characters.names)
  imgui.Image(Characters.images[Characters.selected].image, 64, 64)

  imgui.End()

  imgui.SetNextWindowPos(260, 200)
  imgui.SetNextWindowSize(340, 200)
  imgui.Begin("Status", nil, {
    "ImGuiWindowFlags_NoResize",
    "ImGuiWindowFlags_NoMove",
    "ImGuiWindowFlags_NoScrollbar",
    "ImGuiWindowFlags_NoCollapse"
  })

  imgui.TextWrapped(self.status)

  imgui.End()
end

return Gui
