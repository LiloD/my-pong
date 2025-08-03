Paddle = Object:extend()

local default_paddle_w = 32
local default_paddle_h = 6

function Paddle:new(x, y, w, h)
	self.w = w or default_paddle_w
	self.h = h or default_paddle_h
	self.x = x or (WIDTH - self.w) / 2
	self.y = y or HEIGHT - self.h - 10
	self.dx = 0
end

function Paddle:update(dt)
	self.x = self.x + dt * self.dx
	self.x = math.clamp(self.x, 0, WIDTH - self.w)
end

function Paddle:draw()
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
