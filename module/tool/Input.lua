local vim = {}

function vim:Press(KeyCode : Enum.KeyCode, delay : number)
	game:GetService("VirtualInputManager"):SendKeyEvent(true, KeyCode, false, game)
	task.wait(delay)
	game:GetService("VirtualInputManager"):SendKeyEvent(false, KeyCode, false, game)
end

function vim:getService()
	return game:GetService("VirtualInputManager")
end

return vim
