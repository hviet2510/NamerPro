local Tabs = {}

function Tabs.Create(window, name, imageId)
    if window and window.newTab then
        return window.newTab(name, imageId)
    else
        warn("[Tabs] Window không hợp lệ hoặc thiếu newTab")
        return nil
    end
end

return Tabs
