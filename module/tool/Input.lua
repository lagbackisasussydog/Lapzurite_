local vim = {}

function vim:Press(KeyCode : Enum.KeyCode, delay : number)
	game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Y, false, game)
	task.wait(delay)
	game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Y, false, game)
end

function vim:getService()
	return game:GetService("VirtualInputManager")
end

return vim
