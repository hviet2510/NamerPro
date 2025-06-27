local Buttons = {}

function Buttons.Create(tab, text, callback)
    if tab and tab.newButton then
        tab.newButton(text, "", callback)
    else
        warn("[Buttons] Tab không hợp lệ hoặc thiếu newButton")
    end
end

function Buttons.CreateToggle(tab, text, default, callback)
    if tab and tab.newToggle then
        tab.newToggle(text, "", default, callback)
    else
        warn("[Buttons] Tab không hợp lệ hoặc thiếu newToggle")
    end
end

function Buttons.CreateDropdown(tab, text, list, callback)
    if tab and tab.newDropdown then
        tab.newDropdown(text, "", list, callback)
    else
        warn("[Buttons] Tab không hợp lệ hoặc thiếu newDropdown")
    end
end

function Buttons.CreateInput(tab, text, callback)
    if tab and tab.newInput then
        tab.newInput(text, "", callback)
    else
        warn("[Buttons] Tab không hợp lệ hoặc thiếu newInput")
    end
end

function Buttons.CreateLabel(tab, text)
    if tab and tab.newLabel then
        tab.newLabel(text)
    else
        warn("[Buttons] Tab không hợp lệ hoặc thiếu newLabel")
    end
end

return Buttons
