require 'player'
local bump = require 'bump'
local cron = require 'cron'
local gamera = require 'gamera'
local anim8 = require 'anim8'

local game = {}

local world = bump.newWorld(64)
local cam = gamera.new(0,0,2560,1440)

local floor = {x=0,y=600,w=500,h=120}
local floor2 = {x= 900, y=600,w=500,h=120}
local player = Player:new(200, 50, 64, 128, 0, 0)

local collides = {}
local stop_dash = cron.after(0.2,player.stop,player)

cam:setScale(1)

function game.load()
  --samus = love.graphics.newImage ("assets/samus.png")
  love.mouse.setVisible(true)
  scenes = { intro = intro, menu = menu, game = game}
  
  gravity = 600
  campost = 0
  
  world:add(floor, floor.x, floor.y, floor.w, floor.h)
  world:add(floor2, floor2.x, floor2.y, floor2.w, floor2.h)
  world:add(player, player.x, player.y, player.w, player.h)
  
  SBR = love.graphics.newImage('assets/SBR.png')
  SBL = love.graphics.newImage('assets/SBL.png')
  local gr = anim8.newGrid(30, 45, SBR:getWidth(), SBR:getHeight())
  local gl = anim8.newGrid(30, 45, SBL:getWidth(), SBL:getHeight())
  WalkanimationR = anim8.newAnimation(gr('1-8',1), 0.1)
  WalkanimationL = anim8.newAnimation(gl('1-8',1), 0.1)
  
  SBIR = love.graphics.newImage('assets/SBIR.png')
  SBIL = love.graphics.newImage('assets/SBIL.png')
  local gir = anim8.newGrid(30, 45, SBIR:getWidth(), SBIR:getHeight())
  local gil = anim8.newGrid(30, 45, SBIL:getWidth(), SBIL:getHeight())
  IdleanimationR = anim8.newAnimation(gir('1-4',1), 0.1)
  IdleanimationL = anim8.newAnimation(gil('1-4',1), 0.1) 
  
  
end

function change_scene(new)
  scene = new
  scenes[scene].load()
end

function game.update(dt)
  player.speedY = player.speedY + gravity*dt
  local actualX, actualY, cols, len = world:move(player, player.x + player.speedX*dt, player.y + player.speedY*dt)
  
  -- Checa se o player bateu no chão e zera a speed vertical
  if actualX == player.x + player.speedX*dt then
    for i=1,len do
      local other = cols[i].other
      if other == floor then
        player.speedY = 0
      elseif other == floor2 then
        player.speedY = 0
      end
    end
  end
  
if actualX > player.x then
    WalkanimationR:update(dt)
end
if actualX < player.x then
    WalkanimationL:update(dt)
end
if actualX == player.x then
  if player.dir == 1 then
    IdleanimationR:update(dt)
  else
    IdleanimationL:update(dt)
  end
end

  stop_dash:update(dt)
  
  player.x, player.y = actualX, actualY
  
 
  
end


function game.keypressed(key)
  if key == "up" or key == "w" or key == "space" then
    canJump = false
    
    local actualX, actualY, cols, len = world:check(player, player.x, player.y + 1)

    for i=1,len do
      local other = cols[i].other
      if other == floor or other == floor2 then
        canJump = true
        break
      end
    end
    
    if canJump then 
      player:jump()
    end
  end
  
  if key == "right" then
    player:moveRight()
  end
  
  if key == "left" then
    player:moveLeft()
  end
  
  if key == "d" then
    player:dash()
    stop_dash:reset()    
  end
  
end

function game.keyreleased(key)
  if key == "up" or key == "w" or key == "space" then
    player:shortHop()
  end
  
  if key == "right" then
    if player.speedX > 0 then
      player:stop()
    end
  end
  
  if key == "left" then
    if player.speedX < 0 then
      player:stop()
    end
  end

end

function game.mousepressed(x, y, button, istouch)
 
end

function game.mousereleased(x, y, button, istouch)
  
end

function game.mousemoved(x, y, dx, dy )
  
end

function game.draw()
  cam:setPosition(player.x, player.y)
  cam:draw(function(l,t,w,h)
  -- draw camera stuff here
  
  if player.dir == 1 then
    if player.walking then
      WalkanimationR:draw(SBR, player.x-5, player.y,0,2.5,2.8) 
    else      
    IdleanimationR:draw(SBIR, player.x-5, player.y,0,2.5,2.8)
    end
       
  --love.graphics.draw(samus,player.x-20,player.y-8,0,0.30,0.30)
else
  if player.walking then
    WalkanimationL:draw(SBL, player.x+5, player.y,0,2.5,2.8) 
  else
    IdleanimationL:draw(SBIL, player.x-5, player.y,0,2.5,2.8)
  end
       
  --love.graphics.draw(samus,player.x+85,player.y-8,0,-0.30,0.30)
  end
  love.graphics.rectangle("fill",floor.x,floor.y,floor.w,floor.h)
  love.graphics.rectangle("fill",floor2.x,floor2.y,floor2.w,floor2.h)
  --love.graphics.rectangle("line",player.x,player.y,player.w,player.h) -- DRAW HIT BOX AROUND THE PLAYER
  love.graphics.print(tostring(campost),100,100)
  
end)
  
end

return game