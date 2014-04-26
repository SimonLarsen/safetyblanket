local Player = {}
Player.__index = Player

function Player.create()
	local self = setmetatable({}, Player)

	self.nextChange = 0
	self.changeDelay = 5

	self.nextMove = 0
	self.moveDelay = 0.5

	self.armLeft, self.armRight = 0, 0
	self.legLeft, self.legRight = 0, 0

	self.armLeftTarget, self.armRightTarget = 0, 0
	self.legLeftTarget, self.legRightTarget = 0, 0

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
		self.quadArmLeft[i]  = love.graphics.newQuad(i*39, 0, 39, 43, 117, 43)
		self.quadArmRight[i] = love.graphics.newQuad(i*39, 0, 39, 43, 117, 43)
		self.quadLegLeft[i]  = love.graphics.newQuad(i*49, 0, 49, 43, 147, 43)
		self.quadLegRight[i] = love.graphics.newQuad(i*49, 0, 49, 43, 147, 43)
	end

	return self
end

function Player:update(dt)
	self.animTorso:update(dt)

	self.nextChange = self.nextChange - dt
	if self.nextChange <= 0 then
		self.nextChange = self.changeDelay
		self:changePosition()
	end

	self.nextMove = self.nextMove - dt
	if self.nextMove <= 0 then
		self.nextMove = self.moveDelay
		self:move()
	end
end

function Player:changePosition()
	self.armLeftTarget  = math.random(0, 2)
	self.armRightTarget = math.random(0, 2)
	self.legLeftTarget  = math.random(0, 2)
	self.legRightTarget = math.random(0, 2)
end

function Player:move()
	self.armLeft = moveTowards(self.armLeft, self.armLeftTarget, 1)
	self.armRight = moveTowards(self.armRight, self.armRightTarget, 1)
	self.legLeft = moveTowards(self.legLeft, self.legLeftTarget, 1)
	self.legRight = moveTowards(self.legRight, self.legRightTarget, 1)
end

function Player:draw()
	love.graphics.draw(self.imgArmLeft,  self.quadArmLeft[self.armLeft], 80, 69)
	love.graphics.draw(self.imgArmRight, self.quadArmRight[self.armRight], 139, 69)
	love.graphics.draw(self.imgLegLeft,  self.quadLegLeft[self.legLeft], 81, 105)
	love.graphics.draw(self.imgLegRight, self.quadLegRight[self.legRight], 129, 105)

	self.animTorso:draw(113, 41)
end

return Player
