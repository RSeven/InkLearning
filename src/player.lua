local class = require 'middleclass'

Player = class('Player')

local JMP_SPD = -500
local HOP_SPD = -200
local WALK_SPD = 500

function Player:initialize(x, y, w, h, speedX, speedY)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.speedX = speedX
  self.speedY = speedY
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
  self:move(WALK_SPD)
end

function Player:moveLeft()
  self:move(-WALK_SPD)
end

function Player:move(spd)
  self.speedX = spd
end

function Player:stop()
  self.speedX = 0
end