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
	local mytime = self.time * (8*60)/self.duration + 7*60
	local min1 = math.floor(mytime / 600)
	local min2 = math.floor(mytime / 60) % 10
	local sec1 = math.floor((mytime % 60) / 10)
	local sec2 = math.floor((mytime % 60) % 10)

	love.graphics.draw(self.img, self.quadDigit[min1], 61, 100)
	love.graphics.draw(self.img, self.quadDigit[min2], 65, 100)
	love.graphics.draw(self.img, self.quadDigit[sec1], 71, 100)
	love.graphics.draw(self.img, self.quadDigit[sec2], 75, 100)
end

return Clock
