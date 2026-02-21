local Thread = {}

function Thread:AddThread(thread, func)
	if getgenv().Threads[thread] then
		task.cancel(getgenv().Threads[thread])
		getgenv().Threads[thread] = nil
	end

	getgenv().Threads[thread] = task.spawn(func) 
end

function closeThread(thread)
	if getgenv().Threads[thread] then
		task.cancel(getgenv().Threads[thread])
		getgenv().Threads[thread] = nil
	end
end

function resetThread()
	for _, v in pairs(getgenv().Threads) do
		if v then
			task.cancel(v)
			task.wait(1)
			task.spawn(v)
		end
	end
end

return Thread
