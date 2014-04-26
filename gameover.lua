local Ingame = require("ingame")

local GameOver = {}
GameOver.__index = GameOver

function GameOver:enter()
	
end

function GameOver:update(dt)
	
end

function GameOver:draw()
	love.graphics.print("Click to restart", 16, 16)
end

function GameOver:leave()
	
end

function GameOver:mousepressed(x, y, button)
	if button == "l" then
		switchState(Ingame)
	end
end

function GameOver:mousereleased(x, y, button)
	
end

return GameOver
