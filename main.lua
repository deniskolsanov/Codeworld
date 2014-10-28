State       = require 'libs.hump.gamestate'
Timer       = require 'libs.hump.timer'
Class       = require 'libs.middleclass'
Slib        = require 'libs.slib'
ophysics    = require 'libs.ophysics'
Particles   = require 'libs.particles'
gui         = require 'libs.Quickie'
              require 'libs.loveframes'
flux        = require "libs.flux"

GameState   = require "code.states.GameState"

Block       = require "code.Block"
Player      = require "code.Player"
Turret      = require "code.Turret"
Editor      = require "code.Editor"



function love.load()
  State.registerEvents()
  
  --WINDOW SETTINGS
  love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})
  WIDTH, HEIGHT = love.window.getMode()
  
  --FONTS
  font = {
    [12] = love.graphics.newFont(12),
    [16] = love.graphics.newFont(16),
    [20] = love.graphics.newFont(20),
    [85] = love.graphics.newFont(85)
  }
  love.graphics.setFont(font[12])
  
  Slib.init('Slib')
  
  State.switch(GameState)
end

function love.update(dt)
  Timer.update(dt)
  loveframes.update(dt)
end

function love.draw(dt)
  love.graphics.setBackgroundColor(198, 198, 198, 150)
end

function love.mousepressed(x, y, button)
    loveframes.mousepressed(x, y, button)
end
 
function love.mousereleased(x, y, button)
    loveframes.mousereleased(x, y, button)
end
 
function love.keypressed(key, unicode)
    loveframes.keypressed(key, unicode)
end
 
function love.keyreleased(key)
    loveframes.keyreleased(key)
end

function love.textinput(text)
    loveframes.textinput(text)
end

function love.resize( w, h )
  WIDTH, HEIGHT = w, h
end