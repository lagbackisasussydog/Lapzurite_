local Thread = {}

function Thread:AddThread(thread, func)
	getgenv().Threads[thread] = {
		["Func"] = func
	}
end

function Thread:StartThread(thread)
	if getgenv().Threads[thread] then
		task.cancel(getgenv().Threads[thread].Func)
	end

	task.spawn(getgenv().Threads[thread].Func)
end

function Thread:CloseThread(thread)
	if getgenv().Threads[thread] then
		task.cancel(getgenv().Threads[thread].Func)
	end
end

function Thread:ResetThread()
	for _, v in pairs(getgenv().Threads) do
		if v then
			task.cancel(v.Func)
			task.wait(1)
			task.spawn(v.Func)
		end
	end
end

return Thread
