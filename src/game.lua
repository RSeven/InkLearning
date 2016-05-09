local bump = require 'bump'

local game = {}

local world = bump.newWorld(64)
local floor = {x= 0,y=600,w=1000,h=120}
local player = {x=200,y=50,w=64,h=128}


local collides = {} 

local playerFilter = function(item, other)
  
local right = false

  if     other.isFloor   then return 'touch'
  end
  -- else return nil
end
function game.load()
    love.mouse.setVisible(true)
    --game.keyboard.setKeyRepeat( true )
    scenes = { intro = intro, menu = menu, game = game}
    --change_scene("game")
    
    gravity = 400
    speed = 250
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
  

local actualX, actualY, cols, len = world:move(player, player.x, player.y+gravity*dt)


player.x = actualX
player.y = actualY
jump = false


if not jumping then
for i=1,len do
    local other = cols[i].other
      if other == floor then
        jump = true
        break
      end
end
else 
   
   actualX, actualY, cols, len = world:move(player, player.x, player.y+jumpspeed*dt)
   player.x = actualX
   player.y = actualY
   time = time + dt
   if time > jumptime then
     time = 0 
     jumping = false
    end
end

if love.keyboard.isDown('right','d') then
     actualX, actualY, cols, len = world:move(player, player.x+speed*dt, player.y)
end
if love.keyboard.isDown('left','a') then
     actualX, actualY, cols, len = world:move(player, player.x-speed*dt, player.y)
end
if love.keyboard.isDown('up','w','space') and not jumping then
    if jump then 
    jumping = true
     actualX, actualY, cols, len = world:move(player, player.x, player.y+jumpspeed*dt)
    end
end

player.x = actualX
player.y = actualY



end
function game.keypressed(key)
     if key == "" then
       right = true 
     else
       right = false
     end
end
function game.keyreleased(key)
 
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