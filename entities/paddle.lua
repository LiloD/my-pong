function Paddle(x, y, w, h)
	local paddle = {}

	paddle.w = w or 32
	paddle.h = h or 6
	paddle.pos = Vec2(x or (WIDTH - paddle.w) / 2, y or HEIGHT - paddle.h - 10)
	paddle.dx = 0

	function paddle.update(dt)
		paddle.pos.x = paddle.pos.x + dt * paddle.dx
		-- paddle.pos.x = math.clamp(paddle.pos.x, 0, WIDTH - paddle.w)
	end

	function paddle.draw()
		love.graphics.rectangle("fill", paddle.pos.x, paddle.pos.y, paddle.w, paddle.h)
	end

	return paddle
end
