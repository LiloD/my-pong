function PlayState()
	local playState = BaseState()

	playState.objects = {
		player = Paddle(),
	}
	playState.collision = Collision({
		player = playState.objects.player,
		left_wall = {
			w = 10,
			h = HEIGHT,
			pos = Vec2(-10, 0),
		},
		right_wall = {
			w = 10,
			h = HEIGHT,
			pos = Vec2(WIDTH, 0),
		},
	})

	function playState.update(dt)
		local player = playState.objects.player
		-- handle input
		if love.keyboard.isDown("left") then
			player.dx = -100
		elseif love.keyboard.isDown("right") then
			player.dx = 100
		else
			player.dx = 0
		end

		-- update position
		for _, obj in pairs(playState.objects) do
			obj.update(dt)
		end

		-- handle collision
		playState.collision.update()
	end

	function playState.draw()
		for _, obj in pairs(playState.objects) do
			obj.draw()
		end
	end

	return playState
end
