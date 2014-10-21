local Block = Class('Block')

function Block:initialize(x, y, w, h)
  local body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newRectangleShape(0, 0, w, h, 0)
  local fixture = love.physics.newFixture(body, shape)
  body:setUserData({type = "Block", body = body, shape = shape, fixture = fixture,
	code = "function init()\n  --self.x = 400\nend\n\nfunction update()\nend"})
end

function Block:update(dt)
	body = world:getBodyList()
	for i = 1, #body do
		local temp = body[i]:getUserData()
		if temp and (not editor.frame:GetVisible()) and temp.code then
			Editor:runCode( body[i], 'update' )
		end
	end
end

function Block:draw()
end

function Block:mousepressed(x, y, button)
	local last = editor.frame:GetVisible()
	if last and
		x >= editor.frame:GetX() and y >= editor.frame:GetY() and
		x <= editor.frame:GetX() + editor.frame:GetWidth() and y <= editor.frame:GetY() + editor.frame:GetHeight() then
    editor.frame:SetVisible(true)
	else
		editor.frame:SetVisible(false)
		body = world:getBodyList()
		for i = 1, #body do
			local temp = body[i]:getUserData()
			if temp and temp.type == "Block" and temp.fixture:testPoint( x, y ) then
				local x, y = temp.body:getPosition()
				editor.frame:SetPos(x, y, false)
				editor.body = body[i]
				editor.frame:SetVisible(true)
				break
			end
		end
	end
	if not editor.frame:GetVisible() == last then
		editor:setVisible( editor.frame:GetVisible() )
	end
end

return Block