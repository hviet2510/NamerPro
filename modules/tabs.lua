local Tabs = {}

function Tabs.Create(window, name, imageId)
    -- window ở đây chính là DrRayLibrary, vì DrRay gọi newTab trực tiếp từ lib
    return window.newTab(name, imageId)
end

return Tabs
