local Blanket = {}
Blanket.__index = Blanket

function Blanket.create(world, x1, y1, x2, y2, distance)
	local self = setmetatable({}, Blanket)

	self.xpoints = math.floor((x2 - x1) / distance)
	self.ypoints = math.floor((y2 - y1) / distance)

	self:createMesh(world, x1, y1, x2, y2,distance)

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
			p.body:setLinearDamping(4)
			p.body:setAngularDamping(4)
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
				love.physics.newDistanceJoint(f.body, p.body, f.body:getX(), f.body:getY(), p.body:getX(), p.body:getY(), true)
			end
			if iy > 0 then
				local f = self.p[ix][iy-1]
				love.physics.newDistanceJoint(f.body, p.body, f.body:getX(), f.body:getY(), p.body:getX(), p.body:getY(), true)
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
	for ix=1,self.xpoints-1 do
		for iy=1,self.ypoints-1 do
			local b1 = self.p[ix-1][iy-1].body
			local b2 = self.p[ix][iy-1].body
			local b3 = self.p[ix][iy].body
			local b4 = self.p[ix-1][iy].body
			love.graphics.polygon("line", b1:getX(), b1:getY(), b2:getX(), b2:getY(), b3:getX(), b3:getY(), b4:getX(), b4:getY())
		end
	end
end

function Blanket:mousepressed(x, y, button)
	if button ~= "l" then return end

	if self.mousejoint then
		self.mousejoint:destroy()
		self.mousejoint = nil
	end

	local mindist = 999999
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

	self.mousejoint = love.physics.newMouseJoint(closest.body, x, y)
end

function Blanket:mousereleased(x, y, button)
	if button ~= "l" or self.mousejoint == nil then return end

	self.mousejoint:destroy()
	self.mousejoint = nil
end

return Blanket
