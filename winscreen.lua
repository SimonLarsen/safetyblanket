local Winscreen = {}
Winscreen.__index = Winscreen

Winscreen.STATE_FADEIN = 0
Winscreen.STATE_FADEOUT = 1

function Winscreen:enter()
	self.bg = ResMgr.getImage("winscreen.png")
	self.state = Winscreen.STATE_FADEIN
	self.fade = 1
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")
end

function Winscreen:update(dt)
	if self.state == Winscreen.STATE_FADEIN then
		self.fade = self.fade - dt/2
	
	elseif self.state == Winscreen.STATE_FADEOUT then
		self.fade = self.fade + dt
		if self.fade >= 1 then
			switchState(Title)
		end
	end
end

function Winscreen:draw()
	love.graphics.draw(self.bg, 0, 0)

	love.graphics.setFont(ResMgr.getFont("notalot35.ttf", 16))

	printShadow("You managed to get a good nights sleep,", 10, 8, 1)
	printShadow("now hurry up and get to work!", 10, 22, 1)

	love.graphics.setColor(0, 0, 0, 0.5)
	love.graphics.printf("Click to continue", 0, HEIGHT-16, WIDTH, "center")
	love.graphics.setColor(1, 1, 1, 1)

	if self.fade > 0 then
		if self.state == Winscreen.STATE_FADEIN then
			love.graphics.setColor(1, 1, 1, self.fade)
		else
			love.graphics.setColor(0, 0, 0, self.fade)
		end
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

function Winscreen:leave()
	
end

function Winscreen:mousepressed(x, y, button)
	
end

function Winscreen:mousereleased(x, y, button)
	if button == 1 then
		if self.state == Winscreen.STATE_FADEIN then
			self.state = Winscreen.STATE_FADEOUT
			self.fade = math.max(self.fade, 0)
			ResMgr.playSound("pageturn.wav")
		end
	end
end

return Winscreen
