local GameState = {}

function GameState:enter(previous)
  love.physics.setMeter(10)
  world = love.physics.newWorld(0, 9.8, true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  
  worldPref = {}
  worldPref.isUpdate = true
  
  editor = Editor:new()
  mouse = Mouse:new()
  block = Block:new(50, 50, 32, 32)
end

function GameState:update(dt)
  --if worldPref.isUpdate == true then
	if not editor.frame:GetVisible() then
    world:update(dt)
  end
  
  mouse:update(dt)
  block:update(dt)
end

function GameState:draw()
  ophysics.debugDraw(world)
end

function GameState:keyreleased(key)
end

function GameState:mousepressed(x,y, button)
  block:mousepressed(x, y, button)
end

function GameState:mousereleased(x,y, button)
end

function GameState:keypressed(x,y, button)
end

function GameState:keyreleased(x,y, button)
end

function beginContact(a, b, coll)
  block:beginContact(a, b, coll)
end

function endContact(a, b, coll)
  block:endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
end

return GameState