function Ball(x, y, w, h)
	local that = {}

	that.pos = Vec2(x, y)
	that.w = w or 6
	that.h = h or 6
	that.speed = 100
	that.velocity = Vec2(0, 0)
	that.velocity.set_length(that.speed)

	function that.update(dt)
		that.pos.add_to(that.velocity.multiply(dt))
	end

	function that.reset()
		-- randomly generate the ball above the screen and shot it down
		local angle = math.random(math.pi / 4, math.pi * 3 / 4)
		that.pos.x = (WIDTH - that.w) / 2
		that.pos.y = -10

		that.velocity.set_length(100)
		that.velocity.set_angle(angle)
	end

	function that.draw()
		love.graphics.rectangle("fill", that.pos.x, that.pos.y, that.w, that.h)
	end

	return that
end
