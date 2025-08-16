-- ===================================================================
-- == Script Gián điệp Nâng cao (Advanced Universal Spy)             ==
-- ===================================================================
-- Chức năng: Quét toàn bộ game để tìm và theo dõi cả hai loại tín hiệu
-- là RemoteEvent:FireServer và RemoteFunction:InvokeServer.
-- ===================================================================

print("Bắt đầu quét nâng cao...", Color3.fromRGB(255, 255, 0))

local eventCount = 0
local functionCount = 0

local function scanInstance(parent)
    -- Theo dõi RemoteEvent
    if parent:IsA("RemoteEvent") then
        eventCount = eventCount + 1
        local oldFireServer = parent.FireServer
        parent.FireServer = newcclosure(function(self, ...)
            print("---[EVENT FIRED - FireServer]---")
            print("Tên: " .. self.Name .. " (" .. self:GetFullName() .. ")")
            local args = {...}
            if #args > 0 then
                print("Đối số:")
                for i, v in pairs(args) do print("  ["..i.."]: " .. tostring(v)) end
            end
            return oldFireServer(self, ...)
        end)
    end
    
    -- Theo dõi RemoteFunction
    if parent:IsA("RemoteFunction") then
        functionCount = functionCount + 1
        local oldInvokeServer = parent.InvokeServer
        parent.InvokeServer = newcclosure(function(self, ...)
            print("###[FUNCTION INVOKED - InvokeServer]###")
            print("Tên: " .. self.Name .. " (" .. self:GetFullName() .. ")")
            local args = {...}
            if #args > 0 then
                print("Đối số:")
                for i, v in pairs(args) do print("  ["..i.."]: " .. tostring(v)) end
            end
            return oldInvokeServer(self, ...)
        end)
    end
    
    -- Tiếp tục quét các đối tượng con
    for _, child in ipairs(parent:GetChildren()) do
        pcall(scanInstance, child)
    end
end

-- Bắt đầu quét từ các vị trí chính
scanInstance(game:GetService("ReplicatedStorage"))
scanInstance(game:GetService("Workspace"))
scanInstance(game.Players.LocalPlayer:WaitForChild("PlayerGui"))

print("Hoàn tất! Đã gắn gián điệp vào " .. eventCount .. " Events và " .. functionCount .. " Functions.", Color3.fromRGB(0, 255, 0))
print("Bây giờ hãy thực hiện hành động trong game. Hy vọng lần này sẽ thành công!")
