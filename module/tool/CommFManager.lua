local CommF_ = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")

local manager = {}

function manager:requestEntrance(Destination : Vector3)
	local args = {
		[1] = "requestEntrance",
		[2] = Destination
	}

	CommF_:InvokeServer(unpack(args))
end

function manager:setTeam(Team : string)
	CommF_:InvokeServer("SetTeam", Team)
end

return manager