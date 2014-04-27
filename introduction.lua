local Introduction = {}
Introduction.__index = Introduction

Introduction.STATE_FADEIN = 0
Introduction.STATE_FADEOUT = 1

function Introduction:enter()
	self.bg = ResMgr.getImage("introduction.png")
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")
	self.fade = 1
	self.state = Introduction.STATE_FADEIN
end

function Introduction:update(dt)
	if self.state == Introduction.STATE_FADEIN then
		self.fade = self.fade - dt

	elseif self.state == Introduction.STATE_FADEOUT then
		self.fade = self.fade + dt
		if self.fade >= 1 then
			switchState(Ingame)
		end
	end
end

function Introduction:draw()
	love.graphics.draw(self.bg, 0, 0)

	if self.fade > 0 then
		love.graphics.setColor(0, 0, 0, self.fade*255)
		love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)
		love.graphics.setColor(255, 255, 255, 255)
	end

	local mx, my = love.mouse.getPosition()
	if love.mouse.isDown("l") then
		love.graphics.draw(self.imgCursorPinch, mx, my, 0, 1, 1, 4, 12)
	else
		love.graphics.draw(self.imgCursorNormal, mx, my, 0, 1, 1, 4, 12)
	end
end

function Introduction:leave()
	
end

function Introduction:mousepressed(x, y, button)
	
end

function Introduction:mousereleased(x, y, button)
	if button == "l" then
		if self.state == Introduction.STATE_FADEIN then
			self.state = Introduction.STATE_FADEOUT
			self.fade = math.max(self.fade, 0)
			ResMgr.playSound("pageturn.wav")
		end
	end
end

return Introduction
