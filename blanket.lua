local Blanket = {}
Blanket.__index = Blanket

Blanket.LINEAR_DAMPING = 3
Blanket.ANGULAR_DAMPING = 3
Blanket.DISTANCE = 5

function Blanket.create(world, x1, y1, x2, y2)
	local self = setmetatable({}, Blanket)

	self.xpoints = math.ceil((x2 - x1) / Blanket.DISTANCE)
	self.ypoints = math.ceil((y2 - y1) / Blanket.DISTANCE)

	self:createMesh(world, x1, y1, x2, y2, Blanket.DISTANCE)
	local shader = require("blanketshader")
	self.blanketShader = love.graphics.newShader(shader.pixelcode, shader.vertexcode)

	self.mousejoint = nil

	return self
end

function Blanket:createMesh(world, x1, y1, x2, y2, distance)
	-- Create points
	self.p = {}
	for ix=0, self.xpoints-1 do
		self.p[ix] = {}
		for iy=0, self.ypoints-1 do
			local p = {}
			p.body = love.physics.newBody(world, x1+ix*distance, y1+iy*distance, "dynamic")
			p.body:setLinearDamping(Blanket.LINEAR_DAMPING)
			p.body:setAngularDamping(Blanket.ANGULAR_DAMPING)
			p.shape = love.physics.newCircleShape(distance/3)
			p.fixture = love.physics.newFixture(p.body, p.shape)
			self.p[ix][iy] = p
		end
	end

	-- Create joints
	for ix=0, self.xpoints-1 do
		for iy=0,self.ypoints-1 do
			local p = self.p[ix][iy]
			if ix > 0 then
				local f = self.p[ix-1][iy]
				love.physics.newRopeJoint(f.body, p.body, f.body:getX(), f.body:getY(), p.body:getX(), p.body:getY(), distance)
			end
			if iy > 0 then
				local f = self.p[ix][iy-1]
				love.physics.newRopeJoint(f.body, p.body, f.body:getX(), f.body:getY(), p.body:getX(), p.body:getY(), distance)
			end
		end
	end

end

function Blanket:update(dt)
	if self.mousejoint then
		self.mousejoint:setTarget(love.mouse.getPosition())
	end
end

function Blanket:draw()
	-- Draw blanket
	self.blanketShader:send("plaid", ResMgr.getImage("plaid.png"))
	self.blanketShader:send("screen", {WIDTH, HEIGHT})
	love.graphics.setShader(self.blanketShader)
	for ix=1,self.xpoints-1 do
		for iy=1,self.ypoints-1 do
			local b1 = self.p[ix-1][iy-1].body
			local b2 = self.p[ix][iy-1].body
			local b3 = self.p[ix][iy].body
			local b4 = self.p[ix-1][iy].body
			love.graphics.polygon("fill", b1:getX(), b1:getY(), b2:getX(), b2:getY(), b3:getX(), b3:getY(), b4:getX(), b4:getY())
		end
	end
	love.graphics.setShader()

	-- Draw outline
	love.graphics.setColor(0, 0, 0)
	for ix=1, self.xpoints-1 do
		local t1 = self.p[ix-1][0].body
		local t2 = self.p[ix][0].body
		love.graphics.line(t1:getX(), t1:getY(), t2:getX(), t2:getY())
		local b1 = self.p[ix-1][self.ypoints-1].body
		local b2 = self.p[ix][self.ypoints-1].body
		love.graphics.line(b1:getX(), b1:getY(), b2:getX(), b2:getY())
	end
	for iy=1, self.ypoints-1 do
		local l1 = self.p[0][iy-1].body
		local l2 = self.p[0][iy].body
		love.graphics.line(l1:getX(), l1:getY(), l2:getX(), l2:getY())
		local r1 = self.p[self.xpoints-1][iy-1].body
		local r2 = self.p[self.xpoints-1][iy].body
		love.graphics.line(r1:getX(), r1:getY(), r2:getX(), r2:getY())
	end
	love.graphics.setColor(255, 255, 255)
end

function Blanket:mousepressed(x, y, button)
	if button ~= "l" then return end

	if self.mousejoint then
		self.mousejoint:destroy()
		self.mousejoint = nil
	end

	local mindist = 32
	local closest = nil

	for ix=0, self.xpoints-1 do
		for iy=0, self.ypoints-1 do
			local dist = (self.p[ix][iy].body:getX()-x)^2 + (self.p[ix][iy].body:getY()-y)^2
			if dist < mindist then
				mindist = dist
				closest = self.p[ix][iy]
			end
		end
	end

	if closest then
		self.mousejoint = love.physics.newMouseJoint(closest.body, x, y)
	end
end

function Blanket:mousereleased(x, y, button)
	if button ~= "l" or self.mousejoint == nil then return end

	self.mousejoint:destroy()
	self.mousejoint = nil
end

function Blanket:isCovered(x, y)
	for ix=0, self.xpoints-1 do
		for iy=0, self.ypoints-1 do
			local px, py = self.p[ix][iy].body:getPosition()
			if (x - px)^2 + (y - py)^2 < 16 then
				return true
			end
		end
	end
	return false
end

return Blanket
