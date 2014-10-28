local Turret = Class('Turret')

function Turret:initialize(x,y)
	local body = love.physics.newBody(world, x, y-15, "dynamic")
	local shape = love.physics.newRectangleShape(-25, 0, 10, 5, 0)
  	local fixture = love.physics.newFixture(body, shape)
 	local shape = love.physics.newRectangleShape(0, 0, 40, 20, 0)
 	local fixture = love.physics.newFixture(body, shape)
	body:setUserData({type = "Turret", body = body, shape = shape, fixture = fixture, aim = "Player",
	code = 'function init()\n  self.aim = "Player"\nend\n\nfunction update()\nend'})
	self.base = body
	
	local body = love.physics.newBody(world, x, y, "dynamic")
 	local shape = love.physics.newRectangleShape(0, 15, 10, 40, 0)
 	local fixture = love.physics.newFixture(body, shape)
	local shape = love.physics.newRectangleShape(-10, 35, 20, 6, -0.7)
 	local fixture = love.physics.newFixture(body, shape)
	local shape = love.physics.newRectangleShape(10, 35, 20, 6, 0.7)
 	local fixture = love.physics.newFixture(body, shape)
	local joint = love.physics.newRevoluteJoint( self.base, body, x, y, false )
	joint:setLimits( -0.8, 0.8 )
	joint:setLimitsEnabled( true )
	joint:setMaxMotorTorque( 5000 )
	joint:setMotorEnabled( true )
	fixture:setCategory( 2 )
	self.leg = body
	self.joint = joint
	self.attack = nil
end

function Turret:update(dt)
	self.joint:setMotorSpeed( 0 )
	if self.attack and (self.attack:getUserData().type == self.base:getUserData().aim) then
		local angle = ( math.atan2( self.attack:getY() - turret.base:getY(), turret.attack:getX() - turret.base:getX() ) - turret.base:getAngle() ) % 6.28 - 3.14
		if angle > 0.05 then
			self.joint:setMotorSpeed( -2 )
		elseif angle < -0.05 then
			turret.joint:setMotorSpeed( 2 )
		end
	elseif math.floor( math.random() * 10 ) == 5 then
		body = world:getBodyList()
		for i = 1, #body do
			local temp = body[i]:getUserData()
			if temp and (not editor.frame:GetVisible()) and (temp.type == self.base:getUserData().aim) then
				self.attack = body[i]
			end
		end
	end
end

function Turret:draw()
end

function Turret:mousepressed(x, y, button)
end

return Turret