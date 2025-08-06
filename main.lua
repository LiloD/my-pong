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
	end

	if ball.pos.x > WIDTH - ball.w then
		ball.pos.x = WIDTH - ball.w
		ball.velocity.x = -ball.velocity.x
	end

	-- handle ball reset
	if ball.pos.y > HEIGHT + 10 then
		ball.reset()
	end

	ball.update(dt)
	player.update(dt)
end

function love.draw()
	push:start()
	love.graphics.setFont(fonts.big)
	love.graphics.printf("Hello World", 0, 6, WIDTH, "center")
	player.draw()
	ball.draw()
	display_fps()
	push:finish()
end
