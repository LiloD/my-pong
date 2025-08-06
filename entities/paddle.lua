function Paddle(x, y, w, h)
	local that = {}

	that.w = w or 32
	that.h = h or 6
	that.pos = Vec2(x or (WIDTH - that.w) / 2, y or HEIGHT - that.h - 10)
	that.dx = 0

	function that.update(dt)
		that.pos.x = that.pos.x + dt * that.dx
		that.pos.x = math.clamp(that.pos.x, 0, WIDTH - that.w)
	end

	function that.draw()
		love.graphics.rectangle("fill", that.pos.x, that.pos.y, that.w, that.h)
	end

	return that
end
