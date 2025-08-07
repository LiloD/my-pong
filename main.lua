local push = require("libs.push")

require("utils")
require("vec2")
require("entities.ball")
require("entities.paddle")

WIDTH = 192
HEIGHT = 256

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	love.window.setTitle("My Pong~")

	fonts = {
		small = love.graphics.newFont("assets/fonts/font.ttf", 8),
		big = love.graphics.newFont("assets/fonts/font.ttf", 32),
	}

	sounds = {
		wall_hit = love.audio.newSource("assets/sounds/wall_hit.wav", "static"),
		paddle_hit = love.audio.newSource("assets/sounds/paddle_hit.wav", "static"),
	}

	push:setupScreen(WIDTH, HEIGHT, WIDTH * 3, HEIGHT * 3, {
		fullscreen = false,
		resizable = true,
		vsync = true,
		canvas = false,
	})

	player = Paddle()
	ball = Ball()
	ball.reset()

	ball.velocity.set_angle(math.pi / 2)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.update(dt)
	if love.keyboard.isDown("left") then
		player.dx = -100
	elseif love.keyboard.isDown("right") then
		player.dx = 100
	else
		player.dx = 0
	end

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

	-- handle ball reset
	if ball.pos.y > HEIGHT + 10 or (ball.pos.y < -10 and ball.velocity.y < 0) then
		ball.reset()
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
	end

	ball.update(dt)
	player.update(dt)
end

function love.draw()
	push:start()
	love.graphics.setFont(fonts.big)
	-- love.graphics.printf("Hello World", 0, 6, WIDTH, "center")
	player.draw()
	ball.draw()
	display_fps()
	push:finish()
end
