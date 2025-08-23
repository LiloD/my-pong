function Events()
	local events = {}

	local history = {}

	local callbacks = {}

	function events.fire(ev_name, params)
		table.insert(history, {
			name = ev_name,
			params = params or {},
			timestamp = os.time(),
		})

        print("Event fire: " .. ev_name)

		if callbacks[ev_name] ~= nil then
			for _, fn in ipairs(callbacks[ev_name]) do
				fn(params)
			end
		end
	end

	function events.on(ev_name, cb_fn)
		if callbacks[ev_name] == nil then
			callbacks[ev_name] = {}
		end

		table.insert(callbacks[ev_name], cb_fn)
	end

	return events
end
