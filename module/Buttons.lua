local Buttons = {}

function Buttons.CreateButton(tab, text, desc, callback)
    tab.newButton(text, desc, callback)
end

function Buttons.CreateToggle(tab, text, desc, default, callback)
    tab.newToggle(text, desc, default, callback)
end

function Buttons.CreateLabel(tab, text)
    tab.newLabel(text)
end

function Buttons.CreateInput(tab, text, desc, callback)
    tab.newInput(text, desc, callback)
end

function Buttons.CreateDropdown(tab, text, desc, items, callback)
    tab.newDropdown(text, desc, items, callback)
end

return Buttons
