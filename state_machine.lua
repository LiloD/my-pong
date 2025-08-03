local base_model = require("states.base_state")

local function state_machine(state_by_name)
	local that = {}

	local initial_state = base_model()

	that.states = state_by_name or {}
	that.current = initial_state

	function that.change(state_name, enter_params)
		assert(that.states[that.current])
		that.current.exit()
		that.current = that.states[state_name]
		that.current.enter(enter_params)
	end

	function that.draw()
		that.current.draw()
	end

	function that.update(dt)
		that.current.update(dt)
	end

	return that
end

return state_machine
