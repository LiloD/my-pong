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

		-- handle ball & wall collision
		if ball.pos.x < 0 then
			ball.pos.x = 0
			ball.velocity.x = -ball.velocity.x
			sounds.paddle_hit:play()
		end

		if ball.pos.x > WIDTH - ball.w then
			ball.pos.x = WIDTH - ball.w
			ball.velocity.x = -ball.velocity.x
			sounds.paddle_hit:play()
		end

		-- handle ball and paddle collision
		if ball.is_collide_with(player) then
			ball.pos.y = player.pos.y - ball.h

			local collision_x = ball.pos.x + ball.w / 2
			local norm = math.norm(collision_x, player.pos.x, player.pos.x + player.w)
			local reflect_angle = math.lerp(norm, math.pi * 1.2, math.pi * 1.8)
			local speed_boost = math.lerp(math.abs(norm - 0.5), 1.05, 1.2)

			ball.velocity.set_angle(reflect_angle)
			ball.velocity.set_length(ball.velocity.get_length() * speed_boost)

			sounds.paddle_hit:play()
			impactFlash.create_impact(collision_x, ball.pos.y)
		end

		if ball.pos.y > HEIGHT + 10 then
			ball.reset()
		end
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
