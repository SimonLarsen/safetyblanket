local Ingame = require("ingame")

local GameOver = {}
GameOver.__index = GameOver

GameOver.STATE_FADEIN = 0
GameOver.STATE_FADEOUT = 1

function GameOver:enter(clock)
	self.fade = 1.5
	self.state = GameOver.STATE_FADEIN

	self.time = clock:getClockTime()
	self.timeStr = digitsToString(timeToDigits(self.time))

	updateScore(self.time, false)
	local score = loadScore()
	self.bestTime = score.time
	self.bestTimeStr = digitsToString(timeToDigits(self.bestTime))

	self.bg = ResMgr.getImage("gameover.png")
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")
end

function GameOver:update(dt)
	if self.state == GameOver.STATE_FADEIN then
		self.fade = self.fade - dt/2

	elseif self.state == GameOver.STATE_FADEOUT then
		self.fade = self.fade + dt
		if self.fade >= 1 then
			switchState(Ingame)
		end
	end
end

function GameOver:draw()
	love.graphics.draw(self.bg, 0, 0)

	love.graphics.setFont(ResMgr.getFont("notalot35.ttf", 16))
	
	printShadow("The night creeps ruined your sleep at:", 16, 16)
	printShadow(self.timeStr, 24, 32)
	printShadow("Your best:", 16, 56)
	printShadow(self.bestTimeStr, 24, 72)

	printfShadow("Click to try again", 0, HEIGHT-20, WIDTH, "center", 1)

	if self.fade > 0 then
		local alpha = math.min(255, self.fade*255)
		love.graphics.setColor(0, 0, 0, alpha)
		love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)
		love.graphics.setColor(255, 255, 255)
	end

	local mx, my = love.mouse.getPosition()
	if love.mouse.isDown(1) then
		love.graphics.draw(self.imgCursorPinch, mx, my, 0, 1, 1, 4, 12)
	else
		love.graphics.draw(self.imgCursorNormal, mx, my, 0, 1, 1, 4, 12)
	end
end

function GameOver:leave()
	
end

function GameOver:mousepressed(x, y, button)
end

function GameOver:mousereleased(x, y, button)
	if button == 1 and self.state == GameOver.STATE_FADEIN and self.fade < 0.5 then
		self.state = GameOver.STATE_FADEOUT
		self.fade = math.max(0, self.fade)
		ResMgr.playSound("pageturn.wav")
	end
end

return GameOver
