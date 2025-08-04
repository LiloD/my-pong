Vec2 = Object:extend()

function Vec2:new(x, y)
	self.x = x or 0
	self.y = y or 0
end

function Vec2:get_length()
	return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vec2:get_angle()
	return math.atan2(self.y, self.x)
end

function Vec2:set_length(len)
	local angle = self:get_angle()
	self.x = len * math.cos(angle)
	self.y = len * math.sin(angle)
end

function Vec2:set_angle(angle)
	local len = self:get_length()
	self.x = len * math.cos(angle)
	self.y = len * math.sin(angle)
end

function Vec2:add(vec)
	return Vec2(self.x + vec.x, self.y + vec.y)
end

function Vec2:add_to(vec)
	self.x = self.x + vec.x
	self.y = self.y + vec.y
end

function Vec2:multiply(scale)
	return Vec2(self.x * scale, self.y * scale)
end

function Vec2:multiply_by(scale)
	self.x = self.x * scale
	self.y = self.y * scale
end
