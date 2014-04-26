local Blanket = require("blanket")

local Ingame = {}
Ingame.__index = Ingame

function Ingame:enter()
	love.physics.setMeter(100/1.8)
	self.world = love.physics.newWorld(0, 0, true)
	
	self.blanket = Blanket.create(self.world, WIDTH/2-90, HEIGHT/2-115, WIDTH/2+90, HEIGHT/2+115)

	self.imgBackground = ResMgr.getImage("background.png")
end

function Ingame:update(dt)
	self.blanket:update(dt)
	self.world:update(dt)
end

function Ingame:draw()
	love.graphics.draw(self.imgBackground, 0, 0)
	self.blanket:draw()
end

function Ingame:leave()
	
end

function Ingame:mousepressed(x, y, button)
	self.blanket:mousepressed(x, y, button)
end

function Ingame:mousereleased(x, y, button)
	self.blanket:mousereleased(x, y, button)
end

return Ingame
