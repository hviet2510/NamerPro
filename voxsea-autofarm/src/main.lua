-- =======================================================
-- == Script Gián điệp Toàn năng (Universal Remote Spy)  ==
-- =======================================================
-- Script này sẽ quét toàn bộ game để tìm và theo dõi
-- tất cả các RemoteEvent. Tương thích với nhiều executor hơn.
-- =======================================================

print("Bắt đầu quét RemoteEvent toàn bộ game...", Color3.fromRGB(255, 255, 0))

local remoteCount = 0

-- Hàm đệ quy để quét tất cả các đối tượng con
local function scanForRemotes(parent)
    -- Kiểm tra xem đối tượng có phải là RemoteEvent không
    if parent:IsA("RemoteEvent") then
        remoteCount = remoteCount + 1
        
        -- Lấy hàm FireServer gốc
        local oldFireServer = parent.FireServer
        
        -- Thay thế nó bằng hàm của chúng ta (hook)
        parent.FireServer = newcclosure(function(self, ...)
            local args = {...}
            
            print("================ KÍCH HOẠT REMOTE ================")
            print("--> Tên Remote: " .. self.Name)
            print("--> Vị trí: " .. self:GetFullName())
            
            if #args > 0 then
                print("--> Với các đối số:")
                for i, v in pairs(args) do
                    print("    [" .. tostring(i) .. "]: " .. tostring(v))
                end
            else
                print("--> Không có đối số.")
            end
            print("=================================================\n")
            
            -- Gọi lại hàm gốc để game không bị lỗi
            return oldFireServer(self, ...)
        end)
    end
    
    -- Lặp qua tất cả các đối tượng con và tiếp tục quét
    for _, child in ipairs(parent:GetChildren()) do
        pcall(scanForRemotes, child) -- Dùng pcall để tránh lỗi khi không có quyền truy cập
    end
end

-- Bắt đầu quét từ các thư mục chính
scanForRemotes(game:GetService("ReplicatedStorage"))
scanForRemotes(game:GetService("Workspace"))
scanForRemotes(game.Players.LocalPlayer:WaitForChild("PlayerGui"))

print("Hoàn tất! Đã gắn gián điệp vào " .. remoteCount .. " RemoteEvents.", Color3.fromRGB(0, 255, 0))
print("Bây giờ hãy thực hiện một hành động trong game.")
