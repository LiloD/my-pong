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

	function ball.draw()
		love.graphics.rectangle("fill", ball.pos.x, ball.pos.y, ball.w, ball.h)
	end

	return ball
end
