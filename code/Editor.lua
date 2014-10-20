local Editor = Class('Editor')

local env = { -- разрешённые функции
	ipairs = ipairs, next = next, pairs = pairs, tonumber = tonumber,
  tostring = tostring, type = type, unpack = unpack,
  string = { byte = string.byte, char = string.char, find = string.find, 
      format = string.format, gmatch = string.gmatch, gsub = string.gsub, 
      len = string.len, lower = string.lower, match = string.match, 
      rep = string.rep, reverse = string.reverse, sub = string.sub, 
      upper = string.upper },
  table = { insert = table.insert, maxn = table.maxn, remove = table.remove, 
      sort = table.sort },
  math = { abs = math.abs, acos = math.acos, asin = math.asin, 
      atan = math.atan, atan2 = math.atan2, ceil = math.ceil, cos = math.cos, 
      cosh = math.cosh, deg = math.deg, exp = math.exp, floor = math.floor, 
      fmod = math.fmod, frexp = math.frexp, huge = math.huge, 
      ldexp = math.ldexp, log = math.log, log10 = math.log10, max = math.max, 
      min = math.min, modf = math.modf, pi = math.pi, pow = math.pow, 
      rad = math.rad, random = math.random, sin = math.sin, sinh = math.sinh, 
      sqrt = math.sqrt, tan = math.tan, tanh = math.tanh }
}

function Editor:initialize()
  local frame = loveframes.Create("frame")
  frame:SetName("Code Input")
  frame:SetSize(310, 240)
  frame:Center()
  frame:SetVisible(false)
  frame.OnClose = function(object)
		editor:setVisible(false)
		return false
  end
      
  local textinput = loveframes.Create("textinput", frame)
  textinput:SetPos(5, 30)
  textinput:SetWidth(300)
  textinput:SetFont(font[12])
  textinput:SetMultiline(true)
  textinput:SetHeight(200)
  textinput:SetText("no code!")
  
  self.frame = frame
  self.textinput = textinput
  
  self.exit = false
  self.visible = false
end

function Editor:runCode( body, state )
	code = body:getUserData().code
	env.self = { x = body:getX(), y = body:getY(), angle = body:getAngle(),
		angularVelocity = body:getAngularVelocity(),
		destroy = function() body:destroy() body = nil end,
		applyAngularImpulse = function(q) body:applyAngularImpulse( q ) end,
		applyForce = function(x,y) body:applyForce( x, y ) end,
		applyLinearImpulse = function(x,y) body:applyLinearImpulse( x, y ) end,
		applyTorque = function(q) body:applyTorque( q ) end
		}
  local untrusted_function, message = loadstring(code..' '..state..'()')
  if not untrusted_function then return message end
  setfenv( untrusted_function, env )
	message = pcall( untrusted_function )
	if not message then return "code don't work :(" end
	if (not type(env) == "table") or (not type(env.self) == "table") then
		return "can't find env.self"
	end
	if not body then return 'Ok' end
	if type(env.self.x) == "number" then body:setX(env.self.x) end
	if type(env.self.y) == "number" then body:setY(env.self.y) end
	if type(env.self.angle) == "number" then body:setAngle(env.self.angle) end
	if type(env.self.angularVelocity) == "number" then body:setAngularVelocity(env.self.angularVelocity) end
	return 'Ok'
end

function Editor:setVisible(visible)
  self.frame:SetVisible(visible)
	if (not visible) and editor.body then
		editor.body:getUserData().code = self.textinput:GetText()
		Editor:runCode( editor.body, 'init' )
	end
	if editor.body and visible then
		self.textinput:SetText(editor.body:getUserData().code)
	end
end

function Editor:update(dt)  
end

function Editor:draw()
end

function Editor:Editorpressed(x, y, button)
end

return Editor