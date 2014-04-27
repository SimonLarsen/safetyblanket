function saveScore(time)
	local data = {time = time}
	local strdata = Tserial.pack(data)
	love.filesystem.write("score", strdata)
end

function updateScore(time)
	local score = loadScore()
	if time > score.time then
		saveScore(time)
	end
end

function loadScore()
	if love.filesystem.exists("score") == false then
		return {time = 0}
	end
	local strdata = love.filesystem.read("score")
	local data = Tserial.unpack(strdata)
	return data
end
