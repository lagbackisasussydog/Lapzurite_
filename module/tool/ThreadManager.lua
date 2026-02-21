local Thread = {}
Thread._thread = {}

function Thread:AddThread(thread, func)
	Thread._thread[thread] = {
		["Function"] = func,
		["Running"] = nil
	}
end

function Thread:StartThread(thread)
	local a = Thread._thread[thread]
	if a.Running then
		task.cancel(a.Running)
		a.Running = nil
	end
	
	a.Running = task.spawn(a.Function)
end

function Thread:CloseThread(thread)
	local a = Thread._thread[thread]
	if a.Running then
		task.cancel(a.Running)
		a.Running = nil
	end
end

function Thread:ResetThread()
	for _, v in pairs(Thread._thread) do
		if v.Running then
			task.cancel(v.Function)
			v.Running = task.spawn(v.Function)
		end
	end
end

return Thread
