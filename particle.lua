function Particle()
	local particle = {}
	particle.pos = Vec2(0, 0)
	particle.velocity = Vec2(0, 0)
	particle.life_time = 1

	function particle.update(dt)
		if particle.life_time < 0 then
			return
		end

		particle.pos.add_to(particle.velocity.multiply(dt))

		particle.life_time = particle.life_time - dt
	end

	function particle.draw()
		if particle.life_time < 0 then
			return
		end
		love.graphics.rectangle("fill", particle.pos.x, particle.pos.y, 1, 1)
	end

	return particle
end
