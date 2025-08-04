Paddle = Object:extend()

local defaults = {
	w = 32,
	h = 6,
}

function Paddle:new(x, y, w, h)
	self.w = w or defaults.w
	self.h = h or defaults.h

	self.pos = Vec2(x or (WIDTH - self.w) / 2, y or HEIGHT - self.h - 10)
	self.dx = 0
end

function Paddle:update(dt)
	self.pos.x = self.pos.x + dt * self.dx
	self.pos.x = math.clamp(self.pos.x, 0, WIDTH - self.w)
end

function Paddle:draw()
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.w, self.h)
end
