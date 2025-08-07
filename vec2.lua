function Vec2(x, y)
	local vec2 = {}
	vec2.x = x or 0
	vec2.y = y or 0

	function vec2.get_length()
		return math.sqrt(vec2.x * vec2.x + vec2.y * vec2.y)
	end

	function vec2.get_angle()
		return math.atan2(vec2.y, vec2.x)
	end

	function vec2.set_length(len)
		local angle = vec2.get_angle()
		vec2.x = len * math.cos(angle)
		vec2.y = len * math.sin(angle)
	end

	function vec2.set_angle(angle)
		local len = vec2.get_length()
		vec2.x = len * math.cos(angle)
		vec2.y = len * math.sin(angle)
	end

	function vec2.add(vec)
		return Vec2(vec2.x + vec.x, vec2.y + vec.y)
	end

	function vec2.add_to(vec)
		vec2.x = vec2.x + vec.x
		vec2.y = vec2.y + vec.y
	end

	function vec2.multiply(scale)
		return Vec2(vec2.x * scale, vec2.y * scale)
	end

	function vec2.multiply_by(scale)
		vec2.x = vec2.x * scale
		vec2.y = vec2.y * scale
	end

	return vec2
end
