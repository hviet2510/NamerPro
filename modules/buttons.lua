local Buttons = {}

function Buttons.Create(tab, name, callback)
    tab.newButton(name, "Button desc", callback)
end

return Buttons
