local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/DrRay-ui.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/autofarm.lua"))()
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/NamerPro/main/modules/enemylist.lua"))()

local window = DrRayLibrary:Load("NamerPro UI", "Default")
local farmTab = DrRayLibrary.newTab("Farm Level", "ImageIdHere")

farmTab.newToggle("Auto Farm", "Bật/Tắt Auto Farm", false, function(state)
    AutoFarm.Toggle(state, EnemyList)
end)

farmTab.newDropdown("Attack Range", "Chọn khoảng cách tấn công", {"5", "10", "15", "20", "30"}, function(selected)
    AutoFarm.SetRange(tonumber(selected))
end)

farmTab.newDropdown("Chọn Tool", "Tool dùng để farm", (function()
    local tools = {}
    for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then table.insert(tools, tool.Name) end
    end
    return #tools > 0 and tools or {"No Tool"}
end)(), function(selected)
    AutoFarm.SetTool(selected)
end)
