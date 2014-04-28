local Title = {}
Title.__index = Title

Title.STATE_FADEIN = 0
Title.STATE_FADEOUT = 1
Title.STATE_FADEINF = 2

function Title:enter()
	self.bg = ResMgr.getImage("title.png")
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")
	self.animInf = newAnimation(ResMgr.getImage("inf.png"), 41, 23, 0.12, 3)

	self.text = {}
	for i=1, 3 do
		self.text[i] = ResMgr.getImage("title_text"..i..".png")
	end
	self.textFrame = 1
	self.nextFrame = 0

	self.fade = 1
	self.state = Title.STATE_FADEIN

	self.hasInf = loadScore().completed

	self.music = love.audio.newSource("res/sfx/title.ogg", "stream")
	self.music:setLooping(true)
	self.music:play()
end

function Title:update(dt)
	self.nextFrame = self.nextFrame - dt
	self.animInf:update(dt)

	if self.nextFrame <= 0 then
		self.nextFrame = 0.1
		self.textFrame = (self.textFrame % 3) + 1
	end

	if self.state == Title.STATE_FADEIN then
		self.fade = self.fade - dt/2
	
	elseif self.state == Title.STATE_FADEOUT then
		self.fade = self.fade + dt
		if self.fade >= 1 then
			switchState(Introduction, self.music)
		end

	elseif self.state == Title.STATE_FADEINF then
		self.fade = self.fade + dt
		self.music:setVolume(math.min(self.music.volume, self.fade))
		if self.fade >= 1 then
			self.music:stop()
			switchState(Ingame, true)
		end
	end
end

function Title:draw()
	local mx, my = love.mouse.getPosition()
	
	love.graphics.draw(self.bg, 0, 0)
	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.draw(self.text[self.textFrame], 6, 14)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(self.text[self.textFrame], 9, 12)

	if self.hasInf == true then
		if mx >= 208 and mx <= 249 and my >= 7 and my <= 30 then
			love.graphics.setColor(255, 255, 255, 128)
		end
		self.animInf:draw(208, 7)
		love.graphics.setColor(255, 255, 255, 255)
	end

	love.graphics.setFont(ResMgr.getFont("bmgermar.ttf", 13))
	printfShadow("CLICK TO CONTINUE", 10, 153, 125, "center", 2)

	if self.fade > 0 then
		love.graphics.setColor(0, 0, 0, self.fade*255)
		love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)
		love.graphics.setColor(255, 255, 255, 255)
	end

	if love.mouse.isDown("l") then
		love.graphics.draw(self.imgCursorPinch, mx, my, 0, 1, 1, 4, 12)
	else
		love.graphics.draw(self.imgCursorNormal, mx, my, 0, 1, 1, 4, 12)
	end
end

function Title:leave()
	
end

function Title:keypressed(k)
	if k == "escape" then
		love.event.quit()
	elseif k == "f1" then
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
end

function Title:mousepressed(x, y, button)

end

function Title:mousereleased(x, y, button)
	if button == "l" then
		if self.state == Title.STATE_FADEIN then
			if self.hasInf == true and x >= 208 and x <= 249 and y >= 7 and y <= 30 then
				self.state = Title.STATE_FADEINF
			else
				self.state = Title.STATE_FADEOUT
			end
			self.fade = math.max(self.fade, 0)
			ResMgr.playSound("pageturn.wav")
		end
	end
end

return Title
