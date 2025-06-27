return function(DrRayLibrary)
    local Tabs = {}

    function Tabs.Create(window, name, imageId)
        -- Gọi DrRayLibrary để tạo tab mới
        return DrRayLibrary.newTab(name, imageId)
    end

    return Tabs
end
