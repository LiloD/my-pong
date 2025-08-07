function Ball(x, y, w, h)
	local ball = {}

	ball.pos = Vec2(x, y)
	ball.w = w or 6
	ball.h = h or 6
	ball.speed = 100
	ball.velocity = Vec2(0, 0)
	ball.velocity.set_length(ball.speed)

	function ball.update(dt)
		ball.pos.add_to(ball.velocity.multiply(dt))
	end

	function ball.reset()
		-- randomly generate the ball above the screen and shot it down
		local angle = math.random(math.pi / 3, math.pi * 2 / 3)
		ball.pos.x = (WIDTH - ball.w) / 2
		ball.pos.y = -10

		ball.velocity.set_length(100)
		ball.velocity.set_angle(angle)
	end

	function ball.is_collide_with(paddle)
		-- AABB
		if
			ball.pos.x > paddle.pos.x + paddle.w
			or ball.pos.x + ball.w < paddle.pos.x
			or ball.pos.y > paddle.pos.y + paddle.h
			or ball.pos.y + ball.h < paddle.pos.y
		then
			return false
		end

		return true
	end

	function ball.draw()
		love.graphics.rectangle("fill", ball.pos.x, ball.pos.y, ball.w, ball.h)
	end

	return ball
end
