local Block = Class('Block')

function Block:initialize(x, y, w, h)
  local body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newRectangleShape(0, 0, w, h, 0)
  local fixture = love.physics.newFixture(body, shape)
  body:setUserData({type = "Block", body = body, shape = shape, fixture = fixture,
	code = "function init()\n  --self.x = 400\nend\n\nfunction update()\nend"})
end

function Block:update(dt)
end

function Block:draw()
end

function Block:mousepressed(x, y, button)
end

return Block