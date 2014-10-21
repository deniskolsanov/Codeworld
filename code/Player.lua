local Player = Class('Player')

function Player:initialize(x,y)
	local body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newRectangleShape(0, 0, 80, 80, 0)
  local fixture = love.physics.newFixture(body, shape)
	body:setMass( 0.00000000000001 )
	fixture:setCategory( 2 )
	fixture:setMask( 2 )
	local body_1 = body
	
	local s = 30
	local body = love.physics.newBody(world, x, y+30, "dynamic")
  local shape = love.physics.newPolygonShape( 0, -s, s * math.sqrt(3/4), s / 2, -s * math.sqrt(3/4), s / 2 )
  local fixture = love.physics.newFixture(body, shape)
	local joint = love.physics.newRevoluteJoint( body_1, body, x, y+35, false )
	body:setMass( 0.000001 )
	joint:setLimits( -0.01, 0.01 )
	joint:setLimitsEnabled( true )
	fixture:setCategory( 2 )
	fixture:setMask( 2 )
	local body_2 = body
	
	local body = love.physics.newBody(world, x+s * math.sqrt(3/4), y+s / 2+30, "dynamic")
  local shape = love.physics.newCircleShape(20)
  local fixture = love.physics.newFixture(body, shape)
	fixture:setCategory( 2 )
	fixture:setMask( 2 )
	self.wheel1 = love.physics.newRevoluteJoint( body_2, body, body:getX(), body:getY(), false )
	self.wheel1:setMaxMotorTorque( 200 )
	self.wheel1:setMotorEnabled(true)
	
	local body = love.physics.newBody(world, x-s * math.sqrt(3/4), y+s / 2+30, "dynamic")
  local shape = love.physics.newCircleShape(20)
  local fixture = love.physics.newFixture(body, shape)
	fixture:setCategory( 2 )
	fixture:setMask( 2 )
	self.wheel2 = love.physics.newRevoluteJoint( body_2, body, body:getX(), body:getY(), false )
	self.wheel2:setMaxMotorTorque( 200 )
	self.wheel2:setMotorEnabled(true)
end

function Player:update(dt)

end

function Player:draw()
  
end

function Player:keypressed(key)
	if key == "a" then
    player.wheel1:setMotorSpeed( -100 )
		player.wheel2:setMotorSpeed( -100 )
  end
  if key == "d" then
    player.wheel1:setMotorSpeed( 100 )
		player.wheel2:setMotorSpeed( 100 )
  end
  if key == "w" then
    
  end
  if key == "s" then
    
  end
end

function Player:keyreleased(key)
	if key == "a" then
    player.wheel1:setMotorSpeed( 0 )
		player.wheel2:setMotorSpeed( 0 )
  end
  if key == "d" then
    player.wheel1:setMotorSpeed( 0 )
		player.wheel2:setMotorSpeed( 0 )
  end
  if key == "w" then
    
  end
  if key == "s" then
    
  end
end

function Player:mousepressed(x, y, button)
  
end

function Player:mousereleased(x, y, button)
  
end

return Player