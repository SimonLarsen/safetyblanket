local Player = {}
Player.__index = Player

function Player.create()
	local self = setmetatable({}, Player)

	self.time = 0

	self.armLeft, self.armRight = 0, 0
	self.legLeft, self.legRight = 0, 0

	self.imgTorso = ResMgr.getImage("torso.png")
	self.animTorso = newAnimation(self.imgTorso, 32, 67, 0.2, 5)

	self.imgArmLeft = ResMgr.getImage("arm_left.png")
	self.imgArmRight = ResMgr.getImage("arm_right.png")
	self.imgLegLeft = ResMgr.getImage("leg_left.png")
	self.imgLegRight = ResMgr.getImage("leg_right.png")

	self.quadArmLeft = {}
	self.quadArmRight = {}
	self.quadLegLeft = {}
	self.quadLegRight = {}
	for i=0, 2 do
		self.quadArmLeft[i] = love.graphics.newQuad(i*33, 0, 33, 39, 99, 39)
		self.quadArmRight[i] = love.graphics.newQuad(i*33, 0, 33, 39, 99, 39)
		self.quadLegLeft[i] = love.graphics.newQuad(i*27, 0, 27, 29, 81, 29)
		self.quadLegRight[i] = love.graphics.newQuad(i*27, 0, 27, 29, 81, 29)
	end

	return self
end

function Player:update(dt)
	self.time = self.time + dt*4
	self.animTorso:update(dt)

	self.armLeft  = math.sin(self.time)*1.49 + 1.5
	self.armRight = math.sin(self.time)*1.49 + 1.5
	self.legLeft  = math.sin(self.time)*1.49 + 1.5
	self.legRight = math.sin(self.time)*1.49 + 1.5
end

function Player:draw()
	--love.graphics.draw(self.imgTorso, 113, 41)
	self.animTorso:draw(113, 41)

	-- Draw arms and legs
	love.graphics.draw(self.imgArmLeft, self.quadArmLeft[math.floor(self.armLeft)], 91, 69)
	love.graphics.draw(self.imgArmRight, self.quadArmRight[math.floor(self.armRight)], 134, 69)
	love.graphics.draw(self.imgLegLeft, self.quadLegLeft[math.floor(self.legLeft)], 104, 105)
	love.graphics.draw(self.imgLegRight, self.quadLegRight[math.floor(self.legRight)], 130, 104)
end

return Player
