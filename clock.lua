local Clock = {}
Clock.__index = Clock

function Clock.create(duration)
	local self = setmetatable({}, Clock)

	self.time = 0
	self.duration = duration

	self.img = ResMgr.getImage("digits.png")
	self.quadDigit = {}
	for i=0,9 do
		self.quadDigit[i] = love.graphics.newQuad(i*3, 0, 3, 5, 30, 5)
	end

	return self
end

function Clock:setTime(time)
	self.time = time
end

function Clock:draw()
	local hour1, hour2, min1, min2 = timeToDigits(self:getClockTime())

	if hour1 > 0 then
		love.graphics.draw(self.img, self.quadDigit[hour1], 61, 100)
	end
	love.graphics.draw(self.img, self.quadDigit[hour2], 65, 100)
	love.graphics.draw(self.img, self.quadDigit[min1], 71, 100)
	love.graphics.draw(self.img, self.quadDigit[min2], 75, 100)
end

function Clock:getClockTime()
	return self.time * (8*60)/self.duration + 11*60
end

return Clock
