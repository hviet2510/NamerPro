local Buttons = {}

function Buttons.Create(tab, name, callback)
    tab.newButton(name, "Button action", callback)
end

function Buttons.CreateToggle(tab, name, default, callback)
    tab.newToggle(name, "Toggle action", default, callback)
end

function Buttons.CreateDropdown(tab, name, options, callback)
    tab.newDropdown(name, "Dropdown action", options, callback)
end

return Buttons
