local module = {}

function module:GetModule()
  return {
    ["autoChest"] = loadstring(game:HttpGet("https://raw.githubusercontent.com/lagbackisasussydog/Lapzurite_/refs/heads/main/module/subfarm/autoChest.lua"))()
  }
end

return module
