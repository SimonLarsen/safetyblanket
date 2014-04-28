WIDTH = 256
HEIGHT = 192
SCALE = 3

ResMgr = require("resmgr")
require("AnAL")
require("slam")
require("data")
require("util")
require("Tserial")

Ingame = require("ingame")
Title = require("title")
GameOver = require("gameover")
Introduction = require("introduction")
Winscreen = require("winscreen")

local state
local canvas

function love.load()
	updateMode()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setLineWidth(1)
	love.graphics.setLineStyle("rough")
	love.mouse.setVisible(false)

	if love.graphics.isSupported("canvas") then
		canvas = love.graphics.newCanvas(WIDTH, HEIGHT)
	end

	switchState(Title)
end

function updateMode()
	love.window.setMode(WIDTH*SCALE, HEIGHT*SCALE, {fullscreen=false, vsync=true})
end

function love.update(dt)
	state:update(dt)
end

function love.draw()
	love.graphics.push()

	canvas:clear()
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

function love.keypressed(k)
	if k == "f1" then
		SCALE = 1
		updateMode()
	elseif k == "f2" then
		SCALE = 2
		updateMode()
	elseif k == "f3" then
		SCALE = 3
		updateMode()
	elseif k == "f4" then
		SCALE = 4
		updateMode()
	elseif k == "f5" then
		SCALE = 5
		updateMode()
	end
	
	if state.keypressed then
		state:keypressed(k)
	end
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
