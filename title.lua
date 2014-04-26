local Title = {}
Title.__index = Title

function Title:enter()
	
end

function Title:update(dt)
	
end

function Title:draw()
	love.graphics.print("Click to start game", 16, 16)
end

function Title:leave()
	
end

function Title:mousepressed(x, y, button)
	if button == "l" then
		switchState(Ingame)
	end
end

function Title:mousereleased(x, y, button)
	
end

return Title
