local Player = {}
Player.__index = Player

local armLeftPos  = { {115, 107}, {92, 102}, {81, 73} }
local armRightPos = { {140, 108}, {163, 101}, {174, 73} }
local legLeftPos  = { {120, 145}, {96, 137}, {84, 117} }
local legRightPos = { {134, 145}, {160, 137}, {171, 117} }

Player.DANGER_INCREASE = 0.1
Player.DANGER_DECREASE = 0.2

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

	self.armLeftDanger,  self.armRightDanger = 0, 0
	self.legLeftDanger,  self.legRightDanger = 0, 0

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

function Player:update(dt, blanket)
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

	-- Check which body parts are not covered
	if blanket:isCovered(unpack(legLeftPos[self.legLeft+1])) then
		self.legLeftDanger = math.max(0, self.legLeftDanger - dt*Player.DANGER_DECREASE)
	else
		self.legLeftDanger = math.min(1, self.legLeftDanger + dt*Player.DANGER_INCREASE)
	end
	if blanket:isCovered(unpack(legRightPos[self.legRight+1])) then
		self.legRightDanger = math.max(0, self.legRightDanger - dt*Player.DANGER_DECREASE)
	else
		self.legRightDanger = math.min(1, self.legRightDanger + dt*Player.DANGER_INCREASE)
	end
	if blanket:isCovered(unpack(armLeftPos[self.armLeft+1])) then
		self.armLeftDanger = math.max(0, self.armLeftDanger - dt*Player.DANGER_DECREASE)
	else
		self.armLeftDanger = math.min(1, self.armLeftDanger + dt*Player.DANGER_INCREASE)
	end
	if blanket:isCovered(unpack(armRightPos[self.armRight+1])) then
		self.armRightDanger = math.max(0, self.armRightDanger - dt*Player.DANGER_DECREASE)
	else
		self.armRightDanger = math.min(1, self.armRightDanger + dt*Player.DANGER_INCREASE)
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

	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle("fill", 0, 32, self.legLeftDanger*WIDTH, 13)
	love.graphics.rectangle("fill", 0, 48, self.legRightDanger*WIDTH, 13)
	love.graphics.rectangle("fill", 0, 64, self.armLeftDanger*WIDTH, 13)
	love.graphics.rectangle("fill", 0, 80, self.armRightDanger*WIDTH, 13)
	love.graphics.setColor(255, 255, 255)
end

return Player
