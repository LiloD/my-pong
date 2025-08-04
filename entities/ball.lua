Ball = Object:extend()

local defaults = {
	w = 6,
	h = 6,
	speed = 100, -- pixel per second
}

function Ball:new(x, y, w, h)
	self.w = w or defaults.w
	self.h = h or defaults.h

	self.pos = Vec2(x, y)

	self.speed = defaults.speed
	self.velocity = Vec2(0, 0)
	self.velocity:set_length(self.speed)
end

-- function Ball:reset()
-- 	-- start point
-- 	self.x = (WIDTH - self.w) / 2
-- 	self.y = -50
--
-- 	-- random direction
-- 	local r = math.random(math.pi / 4, math.pi * 3 / 4)
-- 	self.dx = math.cos(r) * self.speed
-- 	self.dy = math.sin(r) * self.speed
-- end

-- function Ball:handleCollision(paddle)
-- 	if self.x > paddle.x + paddle.w or paddle.x > self.x + self.w then
-- 		return false
-- 	end
--
-- 	if self.y > paddle.y + paddle.h or paddle.y > self.y + self.h then
-- 		return false
-- 	end
--
-- 	local col_x = math.lerp(self.x, self.x + self.w, 0.5)
-- 	local t = math.norm(col_x, paddle.x, paddle.x + paddle.w)
-- 	t = math.lerp(-0.2, 0.2, t)
-- 	print(t)
--
-- 	self.speed = self.speed * 1.05
-- 	self.y = player.y - self.h - 1
-- 	self.dx = self.dx + t
-- 	self.dy = self.dy * -1
-- 	-- local r = math.atan(self.dy, self.dx)
-- 	-- self.dx = math.cos(r) * self.speed
-- 	-- self.dy = math.sin(r) * self.speed
--
-- 	return true
-- end

function Ball:update(dt)
	self.pos = self.pos:add_to(self.velocity:multiply(dt))
end

function Ball:draw()
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.w, self.h)
end
