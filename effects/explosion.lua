function Explosion(opts)
	local spec = opts or {}

    local explosion = {}
    explosion.particles = {}

	for i = 1, spec.particle_num or 10, 1 do
		table.insert(
			explosion.particles,
			Particle({
				x = spec.x,
				y = spec.y,
				angle = math.random() * math.pi * 2,
				speed = math.random(50, 200),
				decay = math.random(3, 8),
			})
		)
	end

	function explosion.update(dt)
		for i = #explosion.particles, 1, -1 do
			local p = explosion.particles[i]

			p.update(dt)

			if p.life < 0 then
				table.remove(explosion.particles, i)
			end
		end
	end

	function explosion.draw()
		for _, p in ipairs(explosion.particles) do
			love.graphics.setColor(1, 1, 1, p.life * 1)
			love.graphics.circle("fill", p.pos.x, p.pos.y, 5)
		end
		love.graphics.setColor(1, 1, 1)
	end

	return explosion
end
