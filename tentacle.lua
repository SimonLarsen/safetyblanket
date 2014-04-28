local Tentacle = {}
Tentacle.__index = Tentacle

function Tentacle.create(dir)
	local self = setmetatable({}, Tentacle)

	self.dir = dir
	self.nextSwitch = 0.1
	self.img = ResMgr.getImage("tentacles.png")
	self.anim = newAnimation(self.img, 60, 100, 1, 8)
	self:setDanger(0)

	return self
end

function Tentacle:update(dt)
	self.nextSwitch = self.nextSwitch - dt
	if self.nextSwitch <= 0 then
		if love.math.random() < self.danger then
			self.anim:seek(love.math.random(1, 8))
		end
		self.nextSwitch = 0.1
	end
	if self.anim.position > 4 and self.danger < 0.7 then
		self.anim:seek(love.math.random(1, 4))
	end
end

function Tentacle:setDanger(danger)
	self.danger = danger
	self.x = WIDTH/2 + math.cos(self.dir)*(40 + 60*(1-self.danger))
	self.y = HEIGHT/2 + math.sin(-self.dir)*(40 + 60*(1-self.danger))
end

function Tentacle:draw()
	self.anim:draw(self.x, self.y, -self.dir-math.pi/2, 1, 1, 30, 16)
end

return Tentacle
