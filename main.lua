WIDTH = 256
HEIGHT = 192
SCALE = 3

ResMgr = require("resmgr")
require("AnAL")
require("util")
local Ingame = require("ingame")

local state
local canvas

function love.load()
	love.window.setMode(WIDTH*SCALE, HEIGHT*SCALE, {fullscreen=false, vsync=false})
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")
	love.mouse.setVisible(false)

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

	love.graphics.setCanvas(canvas)
	state:draw()
	love.graphics.scale(SCALE, SCALE)
	love.graphics.setCanvas()

	if state.afterEffect then
		state:afterEffect(canvas)
		love.graphics.draw(canvas, 0, 0)
		love.graphics.setShader()
	else
		love.graphics.draw(canvas, 0, 0)
	end

	love.graphics.pop()
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
