local Player = require("player")
local Blanket = require("blanket")
local Tentacle = require("tentacle")
local Clock = require("clock")

local Ingame = {}
Ingame.__index = Ingame

Ingame.GAME_DURATION = 3*60

function Ingame:enter()
	self.time = 0

	love.physics.setMeter(100/1.8)
	self.world = love.physics.newWorld(0, 0, true)
	
	self.player = Player.create()
	self.blanket = Blanket.create(self.world, WIDTH/2-27, HEIGHT/2-30, WIDTH/2+33, HEIGHT/2+65)
	self.clock = Clock.create(Ingame.GAME_DURATION)
	self.maxDanger = 0

	self.imgBackground = ResMgr.getImage("background.png")
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")

	self.legLeftTentacle  = Tentacle.create(1.25*math.pi)
	self.legRightTentacle = Tentacle.create(1.75*math.pi)
	self.armLeftTentacle  = Tentacle.create(0.75*math.pi)
	self.armRightTentacle = Tentacle.create(0.25*math.pi)

	local shader = require("chromashader")
	self.chromashader = love.graphics.newShader(shader.pixelcode, shader.vertexcode)
end

function Ingame:update(dt)
	self.time = self.time + dt
	self.clock:setTime(self.time)

	self.player:update(dt, self.blanket)
	self.blanket:update(dt)
	self.world:update(dt)

	self.legLeftTentacle:update(dt)
	self.legLeftTentacle:setDanger(self.player.legLeftDanger)
	self.legRightTentacle:update(dt)
	self.legRightTentacle:setDanger(self.player.legRightDanger)
	self.armLeftTentacle:update(dt)
	self.armLeftTentacle:setDanger(self.player.armLeftDanger)
	self.armRightTentacle:update(dt)
	self.armRightTentacle:setDanger(self.player.armRightDanger)

	self.maxDanger = maxArg(
		self.player.armLeftDanger,  self.player.armRightDanger,
		self.player.legLeftDanger,  self.player.legRightDanger
	)
	if self.maxDanger >= 1 then
		switchState(GameOver)
	end
end

function Ingame:draw()
	love.graphics.draw(self.imgBackground, 0, 0)
	self.player:draw()
	self.clock:draw()
	self.blanket:draw()

	self.legLeftTentacle:draw()
	self.legRightTentacle:draw()
	self.armLeftTentacle:draw()
	self.armRightTentacle:draw()

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

function Ingame:afterEffect(canvas)
	if self.maxDanger > 0.6 then
		love.graphics.setShader(self.chromashader)
		local offx = (math.random()-0.5) / 40 * (self.maxDanger-0.6)
		local offy = (math.random()-0.5) / 40 * (self.maxDanger-0.6)
		self.chromashader:send("offset", {offx, offy})
	end
end

return Ingame
