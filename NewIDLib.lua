local NewIDLib = {}

local function createBaseInstance(instanceType, parent, properties)
    local instance = Instance.new(instanceType)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    instance.Parent = parent
    return instance
end

-- Function to create a rounded corner frame
local function createRoundedFrame(parent, size, position, color, cornerRadius)
    local frame = createBaseInstance("Frame", parent, {
        Size = size or UDim2.new(0, 200, 0, 100),
        Position = position or UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = color or Color3.new(1, 1, 1),
        BackgroundTransparency = 0.2,
    })

    local corner = createBaseInstance("UICorner", frame, {
        CornerRadius = UDim.new(0, cornerRadius or 12)
    })

    return frame
end

-- Create a new frame
function NewIDLib.Frame(p, s, pos, col)
    return createRoundedFrame(p, s, pos, col, 12)
end

-- Create a new button with hover effect
function NewIDLib.Button(p, text, s, pos, callback)
    local b = createBaseInstance("TextButton", p, {
        Size = s or UDim2.new(0, 100, 0, 50),
        Position = pos or UDim2.new(0, 0, 0, 0),
        Text = text or "Button",
        BackgroundColor3 = Color3.new(0, 0.5, 1),
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        BackgroundTransparency = 0,
        AutoButtonColor = false,
        ZIndex = 2
    })

    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.new(0, 0.7, 1)
    end)

    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = Color3.new(0, 0.5, 1)
    end)

    b.MouseButton1Click:Connect(callback or function() end)

    return b
end

-- Create an image button
function NewIDLib.ImageButton(p, imgUrl, s, pos, callback)
    local b = createBaseInstance("ImageButton", p, {
        Size = s or UDim2.new(0, 100, 0, 50),
        Position = pos or UDim2.new(0, 0, 0, 0),
        Image = imgUrl or "",
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0,
        ZIndex = 2
    })

    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    end)

    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = Color3.new(1, 1, 1)
    end)

    b.MouseButton1Click:Connect(callback or function() end)

    return b
end

-- Create a new label
function NewIDLib.Label(p, text, s, pos, textSize, textColor)
    local l = createBaseInstance("TextLabel", p, {
        Size = s or UDim2.new(0, 200, 0, 50),
        Position = pos or UDim2.new(0, 0, 0, 0),
        Text = text or "Label",
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        TextColor3 = textColor or Color3.new(0, 0, 0),
        TextSize = textSize or 18,
        Font = Enum.Font.Gotham,
        TextStrokeTransparency = 0.5,
        ZIndex = 2
    })

    return l
end

-- Create a new textbox
function NewIDLib.TextBox(p, placeholder, s, pos, multiLine)
    local tb = createBaseInstance("TextBox", p, {
        Size = s or UDim2.new(0, 200, 0, 50),
        Position = pos or UDim2.new(0, 0, 0, 0),
        PlaceholderText = placeholder or "Enter text...",
        BackgroundColor3 = Color3.new(1, 1, 1),
        TextColor3 = Color3.new(0, 0, 0),
        MultiLine = multiLine or false,
        TextSize = 16,
        Font = Enum.Font.Gotham,
        ZIndex = 2,
        BackgroundTransparency = 0.2,
    })

    local corner = createBaseInstance("UICorner", tb, {
        CornerRadius = UDim.new(0, 12)
    })

    return tb
end

-- Create a multi-line textbox
function NewIDLib.MultiLineTextBox(p, placeholder, s, pos)
    return NewIDLib.TextBox(p, placeholder, s, pos, true)
end

-- Create a new dropdown
function NewIDLib.Dropdown(p, options, pos)
    local d = createRoundedFrame(p, UDim2.new(0, 200, 0, 50), pos, Color3.new(1, 1, 1), 12)
    local btn = NewIDLib.Button(d, "Select", UDim2.new(1, 0, 0, 25), UDim2.new(0, 0, 0, 0), function()
        optionsFrame.Visible = not optionsFrame.Visible
    end)

    local optionsFrame = createRoundedFrame(d, UDim2.new(1, 0, 0, #options * 25), UDim2.new(0, 0, 0, 25), Color3.new(1, 1, 1), 12)
    optionsFrame.Visible = false

    for i, option in ipairs(options) do
        NewIDLib.Button(optionsFrame, option, UDim2.new(1, 0, 0, 25), UDim2.new(0, 0, (i - 1), 0), function()
            btn.Text = option
            optionsFrame.Visible = false
        end)
    end

    return d
end

-- Create a progress bar
function NewIDLib.ProgressBar(p, size, pos)
    local bar = createRoundedFrame(p, size or UDim2.new(0, 200, 0, 25), pos, Color3.new(0.5, 0.5, 0.5), 12)

    local fill = createBaseInstance("Frame", bar, {
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.new(0, 0.7, 0),
        ZIndex = 1
    })

    function bar:SetProgress(value)
        fill.Size = UDim2.new(value, 0, 1, 0)
    end

    return bar
end

-- Create a slider
function NewIDLib.Slider(p, min, max, size, pos, callback)
    local s = createRoundedFrame(p, size or UDim2.new(0, 200, 0, 50), pos, Color3.new(1, 1, 1), 12)

    local slider = createBaseInstance("TextButton", s, {
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.new(0, 0.5, 1),
        ZIndex = 2
    })

    local function updateValue()
        local value = math.floor((slider.Position.X.Offset / s.Size.X.Offset) * (max - min) + min)
        callback(value)
    end

    slider.MouseButton1Down:Connect(function()
        updateValue()
        local function onMove()
            local mouse = game.Players.LocalPlayer:GetMouse()
            local x = math.clamp(mouse.X - s.AbsolutePosition.X, 0, s.Size.X.Offset)
            slider.Position = UDim2.new(0, x, 0, 0)
            updateValue()
        end

        local function onRelease()
            slider.MouseButton1Up:Disconnect(onRelease)
            game:GetService("UserInputService").InputChanged:Disconnect(onMove)
        end

        slider.MouseButton1Up:Connect(onRelease)
        game:GetService("UserInputService").InputChanged:Connect(onMove)
    end)

    return s
end

-- Create a toggle switch
function NewIDLib.Toggle(p, text, size, pos, callback)
    local t = createRoundedFrame(p, size or UDim2.new(0, 100, 0, 50), pos, Color3.new(1, 1, 1), 12)
    
    local switch = createBaseInstance("TextButton", t, {
        Size = UDim2.new(0, 50, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.new(0.5, 0.5, 0.5),
        Text = "",
        ZIndex = 2
    })
    
    local label = NewIDLib.Label(t, text, UDim2.new(0, 100, 1, 0), UDim2.new(0, 60, 0, 0), 16, Color3.new(0, 0, 0))
    
    local isToggled = false
    
    switch.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        switch.BackgroundColor3 = isToggled and Color3.new(0, 0.7, 0) or Color3.new(0.5, 0.5, 0.5)
        callback(isToggled)
    end)

    return t
end

return NewIDLib
