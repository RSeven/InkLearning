local class = require 'middleclass'
local cron = require 'cron'

Player = class('Player')

local JMP_SPD = -500
local HOP_SPD = -200
local WALK_SPD = 500
local DASH_SPD = 1000

local direction = { right = 1, left = -1 }


function Player:initialize(x, y, w, h, speedX, speedY)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.speedX = speedX
  self.speedY = speedY
  self.dir = direction.right
  self.walking = false
  self.dashing = false
end

function Player:jump()
  self.speedY = JMP_SPD
end

function Player:shortHop()
  if self.speedY < HOP_SPD then
    self.speedY = HOP_SPD
  end
end

function Player:moveRight()
  self.dir = direction.right
  self:move(self.dir*WALK_SPD)  
end

function Player:moveLeft()
  self.dir = direction.left
  self:move(self.dir*WALK_SPD)
end

function Player:move(spd)
  self.speedX = spd
  self.walking = true
end

function Player:stop()

    self.speedX = 0
    self.walking = false
    self.dashing = false

end
function Player:dash()  
  self:move(self.dir*(self.speedX + DASH_SPD))
  self.walking = false
  self.dashing = true   
  
end