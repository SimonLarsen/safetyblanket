local Player = require("player")
local Blanket = require("blanket")

local Ingame = {}
Ingame.__index = Ingame

function Ingame:enter()
	love.physics.setMeter(100/1.8)
	self.world = love.physics.newWorld(0, 0, true)
	
	self.player = Player.create()
	self.blanket = Blanket.create(self.world, WIDTH/2-30, HEIGHT/2-45, WIDTH/2+30, HEIGHT/2+45)

	self.imgBackground = ResMgr.getImage("background.png")
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")
end

function Ingame:update(dt)
	self.player:update(dt)
	self.blanket:update(dt)
	self.world:update(dt)
end

function Ingame:draw()
	love.graphics.draw(self.imgBackground, 0, 0)
	self.player:draw()
	self.blanket:draw()

	local mx, my = love.mouse.getPosition()
	if love.mouse.isDown("l") then
		love.graphics.draw(self.imgCursorPinch, mx, my, 0, 1, 1, 4, 12)
	else
		love.graphics.draw(self.imgCursorNormal, mx, my, 0, 1, 1, 4, 12)
	end
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
