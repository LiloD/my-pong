function BaseState()
	local base = {}
	function base.update() end

	function base.draw() end

	function base.enter() end

	function base.exit() end

	return base
end

function StateMachine(states)
	local stateMachine = {}

	stateMachine.states = states or {} -- states table
	stateMachine.current = BaseState() -- current point to dummy state

	function stateMachine.change(name, enter_params)
		stateMachine.current.exit()
		stateMachine.current = stateMachine.states[name]
		stateMachine.current.enter(enter_params)
	end

	function stateMachine.update(dt)
		stateMachine.current.update(dt)
	end

	function stateMachine.draw()
		stateMachine.current.draw()
	end

	return stateMachine
end
