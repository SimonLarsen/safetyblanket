local Introduction = {}
Introduction.__index = Introduction

Introduction.STATE_FADEIN = 0
Introduction.STATE_FADEOUT = 1

local intro_text =
[[It's bed time, the monsters are out to get you, and your blanket is just too small to cover you body!


Cover your exposed limbs to fend off the approaching tentacles.


The tentacles will only go after your feet, hands and head.


If the tentacles reach you, it's game over!
- SURVIVE UNTILL 7 AM]]

function Introduction:enter(music)
	self.bg = ResMgr.getImage("introduction.png")
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")
	self.music = music

	self.fade = 1
	self.state = Introduction.STATE_FADEIN
end

function Introduction:update(dt)
	if self.state == Introduction.STATE_FADEIN then
		self.fade = self.fade - dt

	elseif self.state == Introduction.STATE_FADEOUT then
		self.fade = self.fade + dt
		self.music:setVolume(1-self.fade)
		if self.fade >= 1 then
			switchState(Ingame)
		end
	end
end

function Introduction:draw()
	love.graphics.draw(self.bg, 0, 0)
	printfShadow(intro_text, 16, 14, WIDTH-32, "left", 1)

	if self.fade > 0 then
		love.graphics.setColor(0, 0, 0, self.fade)
		love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)
		love.graphics.setColor(1, 1, 1, 1)
	end

	local mx, my = love.mouse.getPosition()
	if love.mouse.isDown(1) then
		love.graphics.draw(self.imgCursorPinch, mx, my, 0, 1, 1, 4, 12)
	else
		love.graphics.draw(self.imgCursorNormal, mx, my, 0, 1, 1, 4, 12)
	end
end

function Introduction:leave()
	self.music:stop()
end

function Introduction:keypressed(k)
	if k == "escape" then
		switchState(Title)
	end
end

function Introduction:mousepressed(x, y, button)
	
end

function Introduction:mousereleased(x, y, button)
	if button == 1 then
		if self.state == Introduction.STATE_FADEIN then
			self.state = Introduction.STATE_FADEOUT
			self.fade = math.max(self.fade, 0)
			ResMgr.playSound("pageturn.wav")
		end
	end
end

return Introduction
