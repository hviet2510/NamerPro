-- =======================================================
-- == Script Gián điệp RemoteEvent (Remote Spy)         ==
-- =======================================================
-- Chức năng: Lắng nghe và in ra thông tin của tất cả các
-- RemoteEvent được client gửi đến server. Kết quả sẽ
-- hiện trên "Console Di động" bạn đã chạy trước đó.
-- =======================================================

-- Sử dụng hookfunction để theo dõi các lệnh gọi
-- Đây là một cách phổ biến và hiệu quả
if hookfunction then
    local oldFireServer = game.ReplicatedStorage.DefaultRemoteFunction.FireServer
    hookfunction(game.ReplicatedStorage.DefaultRemoteFunction.FireServer, function(remote, ...)
        local args = {...}
        
        -- In thông tin ra console
        print("================ KÍCH HOẠT REMOTE ================")
        print("--> Tên Remote: " .. remote.Name)
        print("--> Vị trí: " .. remote:GetFullName()) -- Đường dẫn đầy đủ
        
        -- In các đối số (dữ liệu được gửi kèm)
        if #args > 0 then
            print("--> Với các đối số:")
            for i, v in pairs(args) do
                print("    [" .. tostring(i) .. "]: " .. tostring(v))
            end
        else
            print("--> Không có đối số.")
        end
        print("=================================================\n")
        
        -- Quan trọng: Gọi lại hàm FireServer gốc để game hoạt động bình thường
        return oldFireServer(remote, ...)
    end)
    
    print("Remote Spy đã được kích hoạt!", Color3.fromRGB(255, 255, 0))
else
    print("Lỗi: Executor của bạn không hỗ trợ hookfunction. Hãy thử kiểm tra tính năng Remote Spy có sẵn.", Color3.fromRGB(255, 100, 100))
end
