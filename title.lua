local Title = {}
Title.__index = Title

function Title:enter()
	self.bg = ResMgr.getImage("title.png")
	self.imgCursorNormal = ResMgr.getImage("cursor_normal.png")
	self.imgCursorPinch = ResMgr.getImage("cursor_pinch.png")
end

function Title:update(dt)
	
end

function Title:draw()
	love.graphics.draw(self.bg, 0, 0)

	love.graphics.setFont(ResMgr.getFont("bmgermar.ttf", 13))
	love.graphics.setColor(0, 0, 0, 128)
	love.graphics.printf("CLICK TO CONTINUE", 10, 155, 125, "center")
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.printf("CLICK TO CONTINUE", 10, 153, 125, "center")

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
		switchState(Ingame)
	end
end

return Title
