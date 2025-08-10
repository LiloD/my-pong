function ImpactFlash()
	local impactFlash = {}
	impactFlash.particles = {}
	impactFlash.duration = -1

	for _ = 1, 10, 1 do
		table.insert(impactFlash.particles, Particle())
	end

	function impactFlash.create_impact(x, y)
		impactFlash.duration = 0.2
		for _, p in ipairs(impactFlash.particles) do
			p.pos.x = x
			p.pos.y = y + 5
			p.velocity.x = love.math.random(-20, 20)
			p.velocity.y = love.math.random(-10, -30)
			p.life_time = impactFlash.duration
		end
	end

	function impactFlash.update(dt)
		if impactFlash.duration < 0 then
			return
		end

		for _, p in ipairs(impactFlash.particles) do
			p.update(dt)
		end

		impactFlash.duration = impactFlash.duration - dt
	end

	function impactFlash.draw()
		if impactFlash.duration < 0 then
			return
		end

		for _, p in ipairs(impactFlash.particles) do
			p.draw()
		end
	end

	return impactFlash
end
