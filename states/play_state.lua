function PlayState()
	local playState = BaseState()

	local objects = {
		player = Paddle(),
		balls = {},
	}

	local collision = Collision({
		player = objects.player,
		balls = {},
	})

	events.on("ball_wall_hit", function()
		sounds.paddle_hit:play()
	end)

	events.on("ball_paddle_hit", function()
		sounds.paddle_hit:play()
		globals.hit_count = globals.hit_count + 1

        -- for every 3 hit, generate a new ball
		if globals.hit_count % 3 == 0 then
			playState.gen_ball()
		end
	end)

	function playState.reset_ball(ball)
		ball.pos.y = -10
		ball.pos.x = (WIDTH - ball.w) / 2
        local angle = math.lerp(math.random(), math.pi * 0.3, math.pi * 0.6)
		ball.velocity.set_angle(angle)
		ball.velocity.set_length(100)
	end

	function playState.gen_ball()
		local ball = Ball(WIDTH / 2, -10, 6, 6)
		ball.velocity.set_angle(math.pi / 2)
		table.insert(objects.balls, ball)
		collision.add_ball(ball)
	end

	function playState.update(dt)
		local player = objects.player

		-- handle input
		if love.keyboard.isDown("left") then
			player.dx = -100
		elseif love.keyboard.isDown("right") then
			player.dx = 100
		else
			player.dx = 0
		end

		-- handle objects update
		objects.player.update(dt)
		for _, ball in ipairs(objects.balls) do
			ball.update(dt)
		end

		-- handle collision
		collision.update()

		-- handle post process
		for _, ball in ipairs(objects.balls) do
			-- handle lower boundry
			if ball.pos.y > HEIGHT + 5 then
				globals.health = globals.health - 1
				playState.reset_ball(ball)
			end

			-- handle upper boundry
			if ball.pos.y < -5 and ball.velocity.y < 0 then
				playState.reset_ball(ball)
			end
		end

        if globals.health == 0 then
            
        end
	end

	function playState.draw()
		-- draw everything
		objects.player.draw()
		for _, ball in ipairs(objects.balls) do
			ball.draw()
		end
	end

	-- create the first ball
	playState.gen_ball()

	return playState
end
