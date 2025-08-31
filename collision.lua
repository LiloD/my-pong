function Collision(objs)
	local collision = {}

	local player = objs.player
	local balls = objs.balls or {}

	local left_wall = {
		w = 10,
		h = HEIGHT,
		pos = Vec2(-10, 0),
	}

	local right_wall = {
		w = 10,
		h = HEIGHT,
		pos = Vec2(WIDTH, 0),
	}

	function collision.update()
		collision.handle_player_wall_collision()
		collision.handle_ball_collision()
	end

	function collision.add_ball(ball)
		table.insert(balls, ball)
	end

	-- handle ball collision with wall and paddle
	function collision.handle_ball_collision()
		for _, ball in ipairs(balls) do
			-- handle ball & wall collision
			if collision.AABB(ball, left_wall) then
				ball.pos.x = 0
				ball.velocity.x = -ball.velocity.x

                events.fire("ball_wall_hit")
			end

			if collision.AABB(ball, right_wall) then
				ball.pos.x = WIDTH - ball.w
				ball.velocity.x = -ball.velocity.x

                events.fire("ball_wall_hit")
			end

			-- handle ball & paddle collision
			if collision.AABB(ball, player) then
				ball.pos.y = player.pos.y - ball.h

				local collision_x = ball.pos.x + ball.w / 2
				local norm = math.norm(collision_x, player.pos.x, player.pos.x + player.w)
				local reflect_angle = math.lerp(norm, math.pi * 1.2, math.pi * 1.8)
				local speed_boost = math.lerp(math.abs(norm - 0.5) * 2, 1.1, 1.5)

				ball.velocity.set_angle(reflect_angle)
				ball.velocity.set_length(ball.velocity.get_length() * speed_boost)

                events.fire("ball_paddle_hit")
			end
		end
	end

	function collision.handle_player_wall_collision()
		if collision.AABB(player, right_wall) then
			player.pos.x = WIDTH - player.w
		end

		if collision.AABB(player, left_wall) then
			player.pos.x = 0
		end
	end

	function collision.AABB(obj1, obj2)
		return (
			obj1.pos.x < obj2.pos.x + obj2.w
			and obj1.pos.x + obj1.w > obj2.pos.x
			and obj1.pos.y < obj2.pos.y + obj2.h
			and obj1.pos.y + obj1.h > obj2.pos.y
		)
	end

	return collision
end
