local Buttons = {}

function Buttons.Create(tab, text, callback)
    tab.newButton(text, "Click để thực thi", callback)
end

function Buttons.CreateToggle(tab, text, default, callback)
    tab.newToggle(text, "Bật/tắt", default, callback)
end

function Buttons.CreateDropdown(tab, text, options, callback)
    tab.newDropdown(text, "Chọn 1 tuỳ chọn", options, callback)
end

return Buttons
