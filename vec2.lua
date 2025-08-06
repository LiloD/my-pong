function Vec2(x, y)
	local that = {
		x = x or 0,
		y = y or 0,
	}

	function that.get_length()
		return math.sqrt(that.x * that.x + that.y * that.y)
	end

	function that.get_angle()
		return math.atan2(that.y, that.x)
	end

	function that.set_length(len)
		local angle = that.get_angle()
		that.x = len * math.cos(angle)
		that.y = len * math.sin(angle)
	end

	function that.set_angle(angle)
		local len = that.get_length()
		that.x = len * math.cos(angle)
		that.y = len * math.sin(angle)
	end

	function that.add(vec)
		return Vec2(that.x + vec.x, that.y + vec.y)
	end

	function that.add_to(vec)
		that.x = that.x + vec.x
		that.y = that.y + vec.y
	end

	function that.multiply(scale)
		return Vec2(that.x * scale, that.y * scale)
	end

	function that.multiply_by(scale)
		that.x = that.x * scale
		that.y = that.y * scale
	end

	return that
end
