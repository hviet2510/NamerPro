local Tabs = {}

function Tabs.Create(window, name, imageId)
    local tab = window.newTab(name, imageId)
    return tab
end

return Tabs
