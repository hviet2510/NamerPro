return function(DrRayLibrary)
    local Buttons = {}

    function Buttons.Create(tab, text, callback)
        tab.newButton(text, "Button created", callback)
    end

    function Buttons.CreateToggle(tab, text, default, callback)
        tab.newToggle(text, "Toggle created", default, callback)
    end

    function Buttons.CreateDropdown(tab, text, options, callback)
        tab.newDropdown(text, "Dropdown created", options, callback)
    end

    return Buttons
end
