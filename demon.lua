local Demon = {}
Demon.__index = Demon

function Demon.create()
	local self = setmetatable({}, Demon)

	self.x = WIDTH/2
	self.y = 0
	self.danger = 0

	self.img = ResMgr.getImage("demon.png")
	self.anim = newAnimation(self.img, 122, 58, 0.1, 4)

	return self
end

function Demon:update(dt)
	if self.danger > 0.9 then
		self.anim:seek(4)
	elseif self.danger > 0.8 then
		self.anim:seek(3)
	elseif self.danger > 0.7 then
		self.anim:seek(2)
	else
		self.anim:seek(1)
	end
end

function Demon:setDanger(danger)
	self.danger = danger
	self.y = self.danger * 55
end

function Demon:draw()
	self.anim:draw(self.x,self.y, 0, 1, 1, 61, 49)
end

return Demon
