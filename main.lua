Object = require("libs.classic")
require("utils")
require("entities.paddle")
require("entities.ball")

local push = require("libs.push")

WIDTH = 192
HEIGHT = 256

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	love.window.setTitle("My Pong~")

	local font = love.graphics.newFont("assets/fonts/font.ttf", 32)
	love.graphics.setFont(font)

	push:setupScreen(WIDTH, HEIGHT, WIDTH * 3, HEIGHT * 3, {
		fullscreen = false,
		resizable = true,
		vsync = true,
		canvas = false,
	})

	player = Paddle()
	ball = Ball()
	ball:reset()
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

	if ball:collides(player) then
		ball.y = player.y - ball.h - 1
		ball.dy = ball.dy * -1
	end

	player:update(dt)
	ball:update(dt)
end

function love.draw()
	push:start()
	love.graphics.printf("Hello World", 0, 6, WIDTH, "center")
	player:draw()
	ball:draw()
	push:finish()
end
