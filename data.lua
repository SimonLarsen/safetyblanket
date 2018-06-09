local Serial = require("Serial")

function saveScore(time, completed)
	local data = {time = time, completed = completed}
	local strdata = Serial.pack(data)
	love.filesystem.write("score", strdata)
end

function updateScore(time, completed)
	local score = loadScore()
	saveScore(math.max(time, score.time), completed or score.completed)
end

function loadScore()
	if love.filesystem.getInfo("score") == nil then
		return {time = 0, completed = false}
	end
	local strdata = love.filesystem.read("score")
	local data = Serial.unpack(strdata)

	local out = {}
	out.time = data.time or 0
	out.completed = data.completed or false

	return out
end
