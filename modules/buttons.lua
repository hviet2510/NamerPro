local Buttons = {}

function Buttons.Create(tab, name, callback)
    tab.newButton(name, name, callback)
end

return Buttons
