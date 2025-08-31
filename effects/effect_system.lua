function EffectSystem()
	local effect_system = {}

	local effects = {}

	function effect_system.create_explosion(x, y)
		local explosion = Explosion({
			x = x,
			y = y,
		})

		table.insert(effects, explosion)
	end

	function effect_system.update(dt)
		for i = #effects, 1, -1 do
			local eff = effects[i]

			eff.update(dt)

			if #eff.particles == 0 then
				table.remove(effects, i)
			end
		end
	end

	function effect_system.draw()
		for _, eff in ipairs(effects) do
			eff.draw()
		end
	end

	return effect_system
end
