local game = require "game"

function love.load()
    love.mouse.setVisible(false)
    --love.keyboard.setKeyRepeat( true )
    scenes = { intro = intro, menu = menu, game = game}
    change_scene("game")
end
function change_scene(new)
    scene = new
    scenes[scene].load()
end
function love.update(dt)
    scenes[scene].update(dt)
end
function love.keypressed(key)
  if scenes[scene].keypressed then
    scenes[scene].keypressed(key)
  end
end
function love.keyreleased(key)
  if scenes[scene].keyreleased then
    scenes[scene].keyreleased(key)
  end
end
function love.mousepressed(x, y, button, istouch)
  if scenes[scene].mousepressed then
    scenes[scene].mousepressed(x, y, button, istouch)
  end
end
function love.mousereleased(x, y, button, istouch)
  if scenes[scene].mousereleased then
    scenes[scene].mousereleased(x, y, button, istouch)
  end
end
function love.mousemoved(x, y, dx, dy )
  if scenes[scene].mousemoved then
    scenes[scene].mousemoved(x, y, dx, dy)
  end
end
function love.draw()
    scenes[scene].draw()
end
