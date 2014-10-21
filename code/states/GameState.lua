local GameState = {}

function GameState:enter(previous)
	love.physics.setMeter(100)
  world = love.physics.newWorld(0, 9.8 * 100, true)
  --world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  
  editor = Editor:new()
  mouse = Mouse:new()
  block = Block:new(50, 50, 32, 32)
	player = Player:new(400,400)
	
	local body = love.physics.newBody(world, x, y, "static")
  local shape = love.physics.newRectangleShape(400, 500, 800, 100, 0)
  local fixture = love.physics.newFixture(body, shape)
  body:setUserData({type = "Ground", body = body, shape = shape, fixture = fixture})
	
	body = world:getBodyList()
	for i = 1, #body do
		local temp = body[i]:getUserData()
		if temp and (not editor.frame:GetVisible()) and temp.code then
			Editor:runCode( body[i], 'update' )
		end
	end
end

function GameState:update(dt)
	if not editor.frame:GetVisible() then
    world:update(dt)
  end
  
  mouse:update(dt)
  block:update(dt)
	Player:update(dt)
end

function GameState:draw()
  ophysics.debugDraw(world)
	loveframes.draw()
end

function GameState:keyreleased(key)
end

function GameState:mousepressed(x,y, button)
  block:mousepressed(x, y, button)
end

function GameState:mousereleased(x,y, button)
end

function GameState:keypressed(key)
	Player:keypressed(key)
end

function GameState:keyreleased(key)
	Player:keyreleased(key)
end

function beginContact(a, b, coll)
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end

return GameState