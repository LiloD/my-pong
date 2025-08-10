local push = require("libs.push")

require("utils")
require("vec2")
require("particle")
require("collision")
require("impact_flash")
require("entities.ball")
require("entities.paddle")
require("states.state_machine")
require("states.play_state")

WIDTH = 192
HEIGHT = 256

balls = {}

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

	-- player = Paddle()
	-- for _ = 1, 1, 1 do
	-- 	local ball = Ball()
	-- 	ball.reset()
	-- 	ball.pos.y = math.random(-100, -200)
	-- 	ball.velocity.set_angle(math.lerp(math.random(), math.pi / 3, math.pi * 2 / 3))
	-- 	ball.velocity.set_length(math.random(100, 150))
	-- 	table.insert(balls, ball)
	-- end
	--
	-- impactFlash = ImpactFlash()

	state_machine = StateMachine({
		play = PlayState(),
	})
	state_machine.change("play")
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
	state_machine.update(dt)
	-- if love.keyboard.isDown("left") then
	-- 	player.dx = -100
	-- elseif love.keyboard.isDown("right") then
	-- 	player.dx = 100
	-- else
	-- 	player.dx = 0
	-- end
	--
	-- -- handle ball reset
	-- -- if ball.pos.y > HEIGHT + 10 or (ball.pos.y < -10 and ball.velocity.y < 0) then
	-- -- 	ball.reset()
	-- -- end
	-- -- ball.update(dt)
	--
	-- for _, ball in ipairs(balls) do
	-- 	ball.update(dt)
	-- end
	--
	-- impactFlash.update(dt)
	-- player.update(dt)
end

function love.draw()
	push:start()
	state_machine.draw()
	-- love.graphics.setFont(fonts.big)
	-- for _, ball in ipairs(balls) do
	-- 	ball.draw()
	-- end
	-- player.draw()
	-- impactFlash.draw()
	--
	display_fps()
	push:finish()
end
