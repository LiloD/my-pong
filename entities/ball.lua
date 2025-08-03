Ball = Object:extend()

local defaults = {
	w = 6,
	h = 6,
}

function Ball:new(x, y, w, h)
	self.w = w or defaults.w
	self.h = h or defaults.h
	self.x = x or 0
	self.y = y or 0
	self.dx = 0
	self.dy = 0
end

function Ball:reset()
	-- start point
	self.x = (WIDTH - self.w) / 2
	self.y = -50

	-- random direction
	local dir = math.random(math.pi / 4, math.pi * 3 / 4)
	self.dx = math.cos(dir) * 100
	self.dy = math.sin(dir) * 100
end

function Ball:collides(paddle)
	if self.x > paddle.x + paddle.w or paddle.x > self.x + self.w then
		return false
	end

	if self.y > paddle.y + paddle.h or paddle.y > self.y + self.h then
		return false
	end

	return true
end

function Ball:update(dt)
	self.x = self.x + dt * self.dx
	self.y = self.y + dt * self.dy

	-- clamp between wall
	self.x = math.clamp(self.x, 0, WIDTH - self.w)

	if self.dy < 0 and self.y < 0 then
		self.y = 0
	end

	-- handle collision of walls
	if self.x == 0 or self.x == WIDTH - self.w then
		self.dx = self.dx * -1
	end

	if self.y == 0 then
		self.dy = self.dy * -1
	end

	-- handle reset
	if self.y > HEIGHT + 50 then
		self:reset()
	end
end

function Ball:draw()
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end
