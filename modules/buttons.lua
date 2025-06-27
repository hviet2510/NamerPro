local Buttons = {}
function Buttons.Create(tab, text, callback)
    tab.newButton(text, "", callback)
end
function Buttons.CreateToggle(tab, text, default, callback)
    tab.newToggle(text, "", default, callback)
end
function Buttons.CreateDropdown(tab, text, options, callback)
    tab.newDropdown(text, "", options, callback)
end
return Buttons
