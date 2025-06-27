local Tabs = {}

function Tabs.Create(window, name, imageId)
    return window:newTab(name, imageId)
end

return Tabs
