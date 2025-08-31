local push = require("libs.push")

require("utils")
require("events")
require("vec2")
require("particle")
require("collision")
require("effects.explosion")
require("effects.effect_system")
require("entities.ball")
require("entities.paddle")
require("states.state_machine")
require("states.play_state")

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

	events = Events()

	globals = {
		hit_count = 0,
		health = 10,
	}

	push:setupScreen(WIDTH, HEIGHT, WIDTH * 3, HEIGHT * 3, {
		fullscreen = false,
		resizable = true,
		vsync = true,
		canvas = false,
	})

	state_machine = StateMachine({
		play = PlayState(),
	})

	effect_system = EffectSystem()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	
    if key == "space" then
        effect_system.create_explosion(WIDTH/2, HEIGHT/2)
	end
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.update(dt)
	state_machine.update(dt)
	effect_system.update(dt)
end

function love.draw()
	push:start()
	state_machine.draw()
	effect_system.draw()
	display_info()
	push:finish()
end
