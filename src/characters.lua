local Characters = {}

function Characters:init()
  local canvas = love.graphics.newCanvas(16, 16)
  local shader = love.graphics.newShader("assets/remove_black.glsl")
  love.graphics.setShader(shader)

  self.images = {}
  self.names = {}
  self.selected = 1

  love.filesystem.mount(love.filesystem.getSourceBaseDirectory() .. "/characters", "characters")
  local files = love.filesystem.getDirectoryItems("characters")
  for _,file in ipairs(files) do
    local name = string.sub(file, 1, -5)
    local character = {
      filename = file
    }
    local image = love.graphics.newImage("characters/" .. file)
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.draw(image)
    love.graphics.setCanvas()
    character.image = love.graphics.newImage(canvas:newImageData())

    table.insert(self.images, character)
    table.insert(self.names, name)
  end 

  love.graphics.setShader()
end

function Characters:copy()
  local sourcePath = love.filesystem.getSourceBaseDirectory()
  U.copyFile(sourcePath .. "/characters/" .. self.images[self.selected].filename, sourcePath .. '/data/MyChar.bmp')
end

return Characters
