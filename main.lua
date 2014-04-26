WIDTH = 256
HEIGHT = 192
SCALE = 4

ResMgr = require("resmgr")
local Ingame = require("ingame")

local state
local canvas

function love.load()
	love.window.setMode(WIDTH*SCALE, HEIGHT*SCALE, {fullscreen=false, vsync=false})
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")

	if love.graphics.isSupported("canvas") then
		canvas = love.graphics.newCanvas(WIDTH, HEIGHT)
	end

	switchState(Ingame)
end

function love.update(dt)
	state:update(dt)
end

function love.draw()
	love.graphics.push()

	if canvas then
		love.graphics.setCanvas(canvas)
		state:draw()
		love.graphics.scale(SCALE, SCALE)
		love.graphics.setCanvas()
		love.graphics.draw(canvas, 0, 0)

	else
		love.graphics.scale(SCALE, SCALE)
		state:draw()
	end

	love.graphics.pop()
	love.graphics.print(love.timer.getFPS(), 16, 16)
end

function love.mousepressed(x, y, button)
	x = x / SCALE
	y = y / SCALE
	state:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	x = x / SCALE
	y = y / SCALE
	state:mousereleased(x, y, button)
end

function switchState(stateclass, ...)
	if state then
		state:leave()
	end
	state = setmetatable({}, stateclass)
	state:enter(...)
end

local oldMouseGetPosition = love.mouse.getPosition
function love.mouse.getPosition()
	local mx, my = oldMouseGetPosition()
	return mx/SCALE, my/SCALE
end
