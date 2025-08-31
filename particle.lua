function Particle(opts)
	local spec = opts or {}
	local particle = {}

	particle.pos = Vec2(spec.x or 0, spec.y or 0)

	particle.velocity = Vec2(0, 0)
	particle.velocity.set_length(spec.speed or 0)
	particle.velocity.set_angle(spec.angle or 0)

	particle.life = spec.life or 1
	particle.decay = spec.decay or 0

	function particle.update(dt)
		if particle.life < 0 then
			return
		end

		particle.pos.add_to(particle.velocity.multiply(dt))
		particle.life = particle.life - dt * particle.decay
	end

	function particle.draw()
		if particle.life < 0 then
			return
		end

		love.graphics.rectangle("fill", particle.pos.x, particle.pos.y, 1, 1)
	end

	return particle
end
