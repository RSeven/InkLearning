local bump = require 'bump'

local game = {}

local world = bump.newWorld(64)
local floor = {x= 0,y=600,w=1000,h=120}
local player = {x=200,y=50,w=64,h=128,speedX=0,speedY=0}


local collides = {}

function game.load()
    love.mouse.setVisible(true)
    --game.keyboard.setKeyRepeat( true )
    scenes = { intro = intro, menu = menu, game = game}
    --change_scene("game")
    
    gravity = 600
    jump = false
    jumpspeed = -600
    isjumping = false
    time = 0 
    jumptime = 0.5
    
    world:add(floor,floor.x,floor.y,floor.w,floor.h)
    world:add(player,player.x,player.y,player.w,player.h)
    
end
function change_scene(new)
    scene = new
    scenes[scene].load()
end
function game.update(dt)
  local actualX, actualY, cols, len = world:move(player, player.x + player.speedX*dt, player.y + player.speedY*dt)
  
  -- Checa se o player bateu no chão e zera a speed vertical
  if actualX == player.x + player.speedX*dt then
    for i=1,len do
      local other = cols[i].other
      if other == floor then
        player.speedY = 0
      end
    end
  end
  
  player.speedY = player.speedY + gravity*dt
  
  player.x = actualX
  player.y = actualY
end

function game.keypressed(key)
  if key == "up" or key == "w" or key == "space" then
    canJump = false
    
    local actualX, actualY, cols, len = world:check(player, player.x, player.y + 1)

    for i=1,len do
      local other = cols[i].other
      if other == floor then
        canJump = true
        break
      end
    end
    
    if canJump then 
      player.speedY = player.speedY - 500
    end
  end
  
  if key == "right" then
    player.speedX = 500
  end
  
  if key == "left" then
    player.speedX = -500
  end
end

function game.keyreleased(key)
  if key == "up" or key == "w" or key == "space" then
    if player.speedY < -200 then
      player.speedY = -200
    end
  end
  
  if key == "right" then
    if player.speedX > 0 then
      player.speedX = 0
    end
  end
  
  if key == "left" then
    if player.speedX < 0 then
      player.speedX = 0
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
  love.graphics.rectangle("fill",floor.x,floor.y,floor.w,floor.h)
  love.graphics.rectangle("line",player.x,player.y,player.w,player.h)
  love.graphics.print(tostring(jump),100,100)
  love.graphics.print(tostring(time),100,120)
end

return game