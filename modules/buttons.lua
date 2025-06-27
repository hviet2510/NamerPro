local Buttons = {}

function Buttons.Create(tab, name, callback)
    tab.newButton(name, "Button", callback)
end

function Buttons.CreateToggle(tab, name, default, callback)
    tab.newToggle(name, "Toggle", default, callback)
end

function Buttons.CreateDropdown(tab, name, options, callback)
    tab.newDropdown(name, "Dropdown", options, callback)
end

function Buttons.CreateInput(tab, name, callback)
    tab.newInput(name, "Input", callback)
end

function Buttons.CreateLabel(tab, text)
    tab.newLabel(text)
end

return Buttons
