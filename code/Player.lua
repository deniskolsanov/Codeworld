local Player = Class('Player')

function Player:initialize(x,y)
	local body_1 = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newRectangleShape(0, 0, 80, 80, 0)
  local fixture = love.physics.newFixture(body_1, shape)
	fixture:setCategory( 2 )
	fixture:setMask( 2 )
	body_1:setUserData({type = "Player", body = body_1, shape = shape, fixture = fixture,
	code = "function init()\n  --self.x = 400\nend\n\nfunction update()\nend"})
	
	local s = 30
	local body = love.physics.newBody(world, x, y+30, "dynamic")
  local shape = love.physics.newPolygonShape( 0, -s, s * math.sqrt(3/4), s / 2, -s * math.sqrt(3/4), s / 2 )
  local fixture = love.physics.newFixture(body, shape)
	local joint = love.physics.newRevoluteJoint( body_1, body, x, y+35, false )
	joint:setLimits( -0.001, 0.001 )
	joint:setLimitsEnabled( true )
	fixture:setCategory( 2 )
	fixture:setMask( 2 )
	local body_2 = body
	
	local s = s - 5
	local body = love.physics.newBody(world, x+s * math.sqrt(3/4), y+s / 2+30, "dynamic")
  local shape = love.physics.newCircleShape(20)
  local fixture = love.physics.newFixture(body, shape)
	fixture:setCategory( 2 )
	fixture:setMask( 2 )
	fixture:setFriction( 1 )
	self.wheel1 = love.physics.newRevoluteJoint( body_2, body, body:getX(), body:getY(), false )
	self.wheel1:setMaxMotorTorque( 5000 )
	self.wheel1:setMotorEnabled(true)
	
	local body = love.physics.newBody(world, x-s * math.sqrt(3/4), y+s / 2+30, "dynamic")
  local shape = love.physics.newCircleShape(20)
  local fixture = love.physics.newFixture(body, shape)
	fixture:setCategory( 2 )
	fixture:setMask( 2 )
	fixture:setFriction( 1 )
	self.wheel2 = love.physics.newRevoluteJoint( body_2, body, body:getX(), body:getY(), false )
	self.wheel2:setMaxMotorTorque( 5000 )
	self.wheel2:setMotorEnabled(true)
end

function Player:update(dt)

end

function Player:draw()
  
end

function Player:keypressed(key)
	if key == "a" then
    player.wheel1:setMotorSpeed( -10 )
		player.wheel2:setMotorSpeed( -10 )
  end
  if key == "d" then
    player.wheel1:setMotorSpeed( 10 )
		player.wheel2:setMotorSpeed( 10 )
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