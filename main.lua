local WindUI = require("./src/init")

-- Test



-- Set theme:
--WindUI:SetTheme("Light")

--- EXAMPLE !!!

function gradient(text, startColor, endColor)
    local result = ""
    local length = #text

    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)

        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end

    return result
end

local Confirmed = false

WindUI:Popup({
    Title = "Welcome! Popup Example",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Content = "This is an Example UI for the " .. gradient("WindUI", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")) .. " Lib",
    Buttons = {
        {
            Title = "Cancel",
            --Icon = "",
            Callback = function() end,
            Variant = "Secondary", -- Primary, Secondary, Tertiary
        },
        {
            Title = "Continue",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary", -- Primary, Secondary, Tertiary
        }
    }
})


repeat wait() until Confirmed

--

local Window = WindUI:CreateWindow({
    Title = "WindUI Library",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "Example UI",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true, -- <- or false
        Callback = function() print("clicked") end, -- <- optional
        Anonymous = true -- <- or true
    },
    SideBarWidth = 200,
    -- HideSearchBar = true, -- hides searchbar
    ScrollBarEnabled = true, -- enables scrollbar
    -- Background = "rbxassetid://13511292247", -- rbxassetid only

    -- remove it below if you don't want to use the key system in your script.
    KeySystem = { -- <- keysystem enabled
        Key = { "1234", "5678" },
        Note = "Example Key System. \n\nThe Key is '1234' or '5678",
        -- Thumbnail = {
        --     Image = "rbxassetid://18220445082", -- rbxassetid only
        --     Title = "Thumbnail"
        -- },
        URL = "link-to-linkvertise-or-discord-or-idk", -- remove this if the key is not obtained from the link.
        SaveKey = true, -- saves key : optional
    },
})


-- Window:SetBackgroundImage("rbxassetid://13511292247")
-- Window:SetBackgroundImageTransparency(0.9)


-- TopBar Edit

-- Disable Topbar Buttons
-- Window:DisableTopbarButtons({
--     "Close", 
--     "Minimize", 
--     "Fullscreen",
-- })

-- Create Custom Topbar Buttons
--                        ↓ Name             ↓ Icon          ↓ Callback                           ↓ LayoutOrder
Window:CreateTopbarButton("MyCustomButton1", "bird",         function() print("clicked 1!") end,  990)
Window:CreateTopbarButton("MyCustomButton2", "droplet-off",  function() print("clicked 2!") end,  989)
Window:CreateTopbarButton("MyCustomButton3", "battery-plus", function() Window:ToggleFullscreen() end, 988)


Window:EditOpenButton({
    Title = "Open Example UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    --Enabled = false,
    Draggable = true,
})


local Tabs = {}

do
    Tabs.ElementsSection = Window:Section({
        Title = "Elements",
        Opened = true,
    })
    
    Tabs.WindowSection = Window:Section({
        Title = "Window Management",
        Icon = "app-window-mac",
        Opened = true,
    })
    
    Tabs.OtherSection = Window:Section({
        Title = "Other",
        Opened = true,
    })

    
    Tabs.ParagraphTab = Tabs.ElementsSection:Tab({ Title = "Paragraph", Icon = "type" })
    Tabs.ButtonTab = Tabs.ElementsSection:Tab({ Title = "Button", Icon = "mouse-pointer-2", Desc = "Contains interactive buttons for various actions." })
    Tabs.CodeTab = Tabs.ElementsSection:Tab({ Title = "Code", Icon = "code", Desc = "Displays and manages code snippets." })
    Tabs.ColorPickerTab = Tabs.ElementsSection:Tab({ Title = "ColorPicker", Icon = "paintbrush", Desc = "Choose and customize colors easily." })
    Tabs.DialogTab = Tabs.ElementsSection:Tab({ Title = "Dialog", Icon = "message-square", Desc = "Dialog lol" })
    Tabs.NotificationTab = Tabs.ElementsSection:Tab({ Title = "Notification", Icon = "bell", Desc = "Configure and view notifications." })
    Tabs.ToggleTab = Tabs.ElementsSection:Tab({ Title = "Toggle", Icon = "toggle-left", Desc = "Switch settings on and off." })
    Tabs.SliderTab = Tabs.ElementsSection:Tab({ Title = "Slider", Icon = "sliders-horizontal", Desc = "Adjust values smoothly with sliders." })
    Tabs.InputTab = Tabs.ElementsSection:Tab({ Title = "Input", Icon = "keyboard", Desc = "Accept text and numerical input." })
    Tabs.KeybindTab = Tabs.ElementsSection:Tab({ Title = "Keybind", Icon = "keyboard-off" })
    Tabs.DropdownTab = Tabs.ElementsSection:Tab({ Title = "Dropdown", Icon = "chevrons-up-down", Desc = "Select from multiple options." })
    
    Tabs.WindowTab = Tabs.WindowSection:Tab({ 
        Title = "Window and File Configuration", 
        Icon = "settings", 
        Desc = "Manage window settings and file configurations.", 
        ShowTabTitle = true 
    })
    Tabs.CreateThemeTab = Tabs.WindowSection:Tab({ Title = "Create Theme", Icon = "palette", Desc = "Design and apply custom themes." })
    
    Tabs.LongTab = Tabs.OtherSection:Tab({ 
        Title = "Long and empty tab. with custom icon", 
        Icon = "rbxassetid://129260712070622", 
        IconThemed = true, 
        Desc = "Long Description" 
    })
    Tabs.LockedTab = Tabs.OtherSection:Tab({ Title = "Locked Tab", Icon = "lock", Desc = "This tab is locked", Locked = true })
    Tabs.TabWithoutIcon = Tabs.OtherSection:Tab({ Title = "Tab Without icon", ShowTabTitle = true })
    Tabs.Tests = Tabs.OtherSection:Tab({ Title = "Tests", Icon = "https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/ui.png", ShowTabTitle = true })
    
    
    Tabs.LastSection = Window:Section({
        Title = "Section without tabs",
        --Opened = true,
    })
    
    Tabs.ConfigTab = Window:Tab({ Title = "Config", Icon = "file-cog" })
end



Window:SelectTab(1)

Tabs.ParagraphTab:Paragraph({
    Title = "Paragraph with Image & Thumbnail",
    Desc = "Test Paragraph",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 42, -- default 30
    Thumbnail = "https://tr.rbxcdn.com/180DAY-59af3523ad8898216dbe1043788837bf/768/432/Image/Webp/noFilter",
    ThumbnailSize = 120 -- Thumbnail height
})
Tabs.ParagraphTab:Paragraph({
    Title = "Paragraph with Image & Thumbnail & Buttons",
    Desc = "Test Paragraph",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    ImageSize = 42, -- default 30
    Thumbnail = "https://tr.rbxcdn.com/180DAY-59af3523ad8898216dbe1043788837bf/768/432/Image/Webp/noFilter",
    ThumbnailSize = 120, -- Thumbnail height
    Buttons = {
        {
            Title = "Button 1",
            Variant = "Primary",
            Callback = function() print("1 Button") end,
            Icon = "bird",
        },
        {
            Title = "Button 2",
            Variant = "Primary",
            Callback = function() print("2 Button") end,
            Icon = "bird",
        },
        {
            Title = "Button 3",
            Variant = "Primary",
            Callback = function() print("3 Button") end,
            Icon = "bird",
        },
    }
})

Tabs.ParagraphTab:Divider()

for _,i in next, { "Default", "Red", "Orange", "Green", "Blue", "Grey", "White" } do
    Tabs.ParagraphTab:Paragraph({
        Title = i,
        Desc = "Paragraph with color",
        Image = "bird",
        Color = i ~= "Default" and i or nil,
        Buttons = {
            {
                Title = "Button 1",
                Variant = "Primary",
                Callback = function() print("1 Button") end,
                Icon = "bird",
            },
            {
                Title = "Button 2",
                Variant = "Primary",
                Callback = function() print("2 Button") end,
                Icon = "bird",
            },
            {
                Title = "Button 3",
                Variant = "Primary",
                Callback = function() print("3 Button") end,
                Icon = "bird",
            },
        }
    })
end



Tabs.ButtonTab:Button({
    Title = "Click Me",
    Desc = "This is a simple button",
    Callback = function() print("Button Clicked!") end
})


local destroybtn
destroybtn = Tabs.ButtonTab:Button({
    Title = "Click to destroy me!",
    Callback = function() destroybtn:Destroy() end,
})

Tabs.ButtonTab:Button({
    Title = "Submit",
    Desc = "Click to submit",
    Callback = function() print("Submitted!") end,
})

Tabs.ButtonTab:Button({
    Title = "Set ToggleKey to 'F'",
    Callback = function() Window:SetToggleKey(Enum.KeyCode.F) end,
})

Tabs.ButtonTab:Divider()


Tabs.ButtonTab:Button({
    Title = "Locked Button",
    Desc = "This button is locked",
    Locked = true,
})


Tabs.CodeTab:Code({
    Title = "example-code.luau",
    Code = [[-- Example Luau code to test syntax highlighting
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local function factorial(n)
    if n <= 1 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

local result = factorial(5)
print("Factorial of 5 is:", result)

local playerName = "Player"
local score = 100

if score >= 100 then
    print(playerName .. " earned an achievement!")
else
    warn("Need more points.")
end

-- Table with nested values
local playerStats = {
    name = "Player",
    health = 100,
    inventory = {"sword", "shield", "potion"}
}

for i, item in ipairs(playerStats.inventory) do
    print("Item in inventory:", item)
end]],
})

Tabs.CodeTab:Code({
    Code = [[print("WindUI on top!")]],
})



Tabs.ColorPickerTab:Colorpicker({
    Title = "Pick a Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color) print("Selected color: " .. tostring(color)) end
})

Tabs.ColorPickerTab:Colorpicker({
    Title = "Transparency Color",
    Default = Color3.fromRGB(0, 0, 255),
    Transparency = 0,
    Callback = function(color) print("Background color: " .. tostring(color)) end
})


Tabs.DialogTab:Button({
    Title = "Create Example Dialog",
    Callback = function()
        Window:Dialog({
            Title = "Example Dialog",
            Content = "Example Content. lalala",
            Icon = "bird",
            Buttons = {
                {
                    Title = "LOL!",
                    Icon = "bird",
                    Variant = "Tertiary",
                    Callback = function()
                        print("lol")
                    end,
                },
                {
                    Title = "Cool!",
                    Icon = "bird",
                    Variant = "Tertiary",
                    Callback = function()
                        print("Cool")
                    end,
                },
                {
                    Title = "Ok!",
                    Icon = "bird",
                    Variant = "Secondary",
                    Callback = function()
                        print("Ok")
                    end,
                },
                {
                    Title = "Awesome!",
                    Icon = "bird",
                    Variant = "Primary",
                    Callback = function() 
                        print("Awesome")
                    end,
                }
            }
        })
    end,
})

Tabs.DialogTab:Button({
    Title = "Create Example Dialog 2",
    Callback = function()
        Window:Dialog({
            Title = "Example Dialog 2",
            Content = "Example Content. lalala",
            Icon = "rbxassetid://129260712070622",
            Buttons = {
                {
                    Title = "Ok!",
                    Variant = "Primary",
                    Callback = function()
                        print("ok")
                    end,
                },
            }
        })
    end,
})


Tabs.NotificationTab:Button({
    Title = "Click to get Notified",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 1",
            Content = "Content",
            Duration = 5,
        })
    end
})

Tabs.NotificationTab:Button({
    Title = "Notification with icon",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 2",
            Content = "Content",
            Icon = "droplet-off",
            Duration = 5,
        })
    end
})

Tabs.NotificationTab:Button({
    Title = "Notification with custom icon",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 2",
            Content = "Content",
            Icon = "rbxassetid://129260712070622",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
    end
})

Tabs.NotificationTab:Button({
    Title = "Notification with BackgroundImage",
    Callback = function() 
        WindUI:Notify({
            Title = "Notification Example 3",
            Content = "with BackgroundImage",
            Icon = "image",
            Duration = 5,
            Background = "rbxassetid://13511292247"
        })
    end
})


Tabs.ToggleTab:Toggle({
    Title = "Enable Feature",
    --Image = "bird",
    Value = true,
    Callback = function(state) print("Feature enabled: " .. tostring(state)) end
})

Tabs.ToggleTab:Toggle({
    Title = "Activate Mode",
    Value = false,
    Callback = function(state) print("Mode activated: " .. tostring(state)) end
})
Tabs.ToggleTab:Toggle({
    Title = "Toggle with icon",
    Icon = "check",
    Value = false,
    Callback = function(state) print("Toggle with icon activated: " .. tostring(state)) end
})

Tabs.ToggleTab:Toggle({
    Title = "New Toggle Type 'Checkbox'",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) print("'Checkbox' Toggle activated: " .. tostring(state)) end
})
Tabs.ToggleTab:Toggle({
    Title = "New Toggle Type 'Checkbox' with custom icon",
    Icon = "bird",
    Type = "Checkbox",
    Value = false,
    Callback = function(state) print("'Checkbox' Toggle with icon activated: " .. tostring(state)) end
})


Tabs.SliderTab:Slider({
    Title = "Volume Slider",
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(value) print("Volume set to: " .. value) end
})

Tabs.SliderTab:Slider({
    Title = "Brightness Slider",
    Value = {
        Min = 1,
        Max = 100,
        Default = 75,
    },
    Callback = function(value) print("Brightness set to: " .. value) end
})

Tabs.SliderTab:Slider({
    Title = "Float Slider",
    Step = 0.1,
    Value = {
        Min = 0,
        Max = 2.5,
        Default = 1.5,
    },
    Callback = function(value) print("Brightness set to: " .. value) end
})


Tabs.InputTab:Input({
    Title = "Username",
    Value = "Guest",
    Placeholder = "Enter your username",
    Callback = function(input) print("Username: " .. input) end
})

Tabs.InputTab:Input({
    Title = "Password",
    Value = "",
    Placeholder = "Enter your password",
    Callback = function(input) print("Password entered.") end
})


Tabs.InputTab:Input({
    Title = "Input with icon",
    Value = "pisun",
    InputIcon = "bird",
    Placeholder = "Enter pisun",
    Callback = function(input) print("pisun entered.") end
})


Tabs.InputTab:Input({
    Title = "Comment",
    Value = "",
    Type = "Textarea", -- or Input
    Placeholder = "Leave a comment",
    Callback = function(input) 
        print("Comment entered: " .. input)
    end
})

Tabs.InputTab:Input({
    Title = "Comment with icon",
    Desc = "hmmmm",
    Value = "pisun",
    InputIcon = "bird",
    Type = "Textarea", -- or Input
    Placeholder = "Leave a pisun",
    Callback = function(input) 
        print("Pisun entered: " .. input)
    end
})


Tabs.KeybindTab:Keybind({
    Title = "Keybind Example",
    Desc = "Keybind to open ui",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})


Tabs.DropdownTab:Dropdown({
    Title = "Select an Option",
    Values = { "Option 1", "Option 2", "Option 3" },
    Value = "Option 1",
    Callback = function(option) print("Selected: " .. option) end
})

Tabs.DropdownTab:Dropdown({
    Title = "Choose a Category (Multi)",
    Values = { "Category A", "Category B", "Category C" },
    Value = { "Category A" },
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        print("Categories selected: " .. game:GetService("HttpService"):JSONEncode(option)) 
    end
})
Tabs.DropdownTab:Dropdown({
    Title = "Big Dropdown",
    Values = { "Lllllllloooooooonnnnnggggggggg Tab", 
               "Hi",
               "Hi",
               "Hi",
               "Hi",
               "Hi",
               "Hi",
               "Hi",
               "Hi",
               "Hi",
             },
    --Value = { "" },
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        print("Pisun selected: " .. game:GetService("HttpService"):JSONEncode(option)) 
    end
})



-- Configuration
-- Optional


local HttpService = game:GetService("HttpService")

local folderPath = "WindUI"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.json$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end

Tabs.WindowTab:Section({ Title = "Window", Icon = "app-window-mac" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

local ToggleTransparency = Tabs.WindowTab:Toggle({
    Title = "Toggle Window Transparency",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

Tabs.WindowTab:Section({ Title = "Save" })

local fileNameInput = ""
Tabs.WindowTab:Input({
    Title = "Write File Name",
    PlaceholderText = "Enter file name",
    Callback = function(text)
        fileNameInput = text
    end
})

Tabs.WindowTab:Button({
    Title = "Save File",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Section({ Title = "Load" })

local filesDropdown
local files = ListFiles()

filesDropdown = Tabs.WindowTab:Dropdown({
    Title = "Select File",
    Multi = false,
    AllowNon
