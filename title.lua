local Title = {}
Title.__index = Title

Title.STATE_FADEIN = 0
Title.STATE_FADEOUT = 1

function Title:enter()
	self.bg = ResMgr.getImage("title.png")
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")

	self.text = {}
	for i=1, 3 do
		self.text[i] = ResMgr.getImage("title_text"..i..".png")
	end
	self.textFrame = 1
	self.nextFrame = 0

	self.fade = 1
	self.state = Title.STATE_FADEIN
end

function Title:update(dt)
	self.nextFrame = self.nextFrame - dt
	if self.nextFrame <= 0 then
		self.nextFrame = 0.1
		self.textFrame = (self.textFrame % 3) + 1
	end

	if self.state == Title.STATE_FADEIN then
		self.fade = self.fade - dt/2
	
	elseif self.state == Title.STATE_FADEOUT then
		self.fade = self.fade + dt
		if self.fade >= 1 then
			switchState(Introduction)
		end
	end
end

function Title:draw()
	love.graphics.draw(self.bg, 0, 0)
	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.draw(self.text[self.textFrame], 6, 14)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.text[self.textFrame], 9, 12)

	love.graphics.setFont(ResMgr.getFont("bmgermar.ttf", 13))
	love.graphics.printf("CLICK TO CONTINUE", 10, 153, 125, "center")

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

function Title:leave()
	
end

function Title:mousepressed(x, y, button)
end

function Title:mousereleased(x, y, button)
	if button == "l" then
		if self.state == Title.STATE_FADEIN then
			self.state = Title.STATE_FADEOUT
			self.fade = math.max(self.fade, 0)
		end
	end
end

return Title
