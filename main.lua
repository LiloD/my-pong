Object = require("libs.classic")
local push = require("libs.push")

require("utils")
require("vec2")
require("entities.paddle")
require("entities.ball")

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
	-- ball = Ball()
	-- ball:reset()
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

	-- ball:handleCollision(player)

	player:update(dt)
	-- ball:update(dt)
end

function love.draw()
	push:start()
	love.graphics.setFont(fonts.big)
	love.graphics.printf("Hello World", 0, 6, WIDTH, "center")
	player:draw()
	-- ball:draw()
	display_fps()
	push:finish()
end
