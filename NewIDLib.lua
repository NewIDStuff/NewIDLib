local NewIDLib = {}

-- Create a new frame
function NewIDLib.Frame(p, s, pos, col)
    local f = Instance.new("Frame")
    f.Size = s or UDim2.new(0, 200, 0, 100)
    f.Position = pos or UDim2.new(0, 0, 0, 0)
    f.BackgroundColor3 = col or Color3.new(1, 1, 1)
    f.Parent = p
    return f
end

-- Create a new button
function NewIDLib.Button(p, text, s, pos, callback)
    local b = Instance.new("TextButton")
    b.Size = s or UDim2.new(0, 100, 0, 50)
    b.Position = pos or UDim2.new(0, 0, 0, 0)
    b.Text = text or "Button"
    b.BackgroundColor3 = Color3.new(0, 0.5, 1)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Parent = p
    b.MouseButton1Click:Connect(callback or function() end)
    return b
end

-- Create an image button
function NewIDLib.ImageButton(p, imgUrl, s, pos, callback)
    local b = Instance.new("ImageButton")
    b.Size = s or UDim2.new(0, 100, 0, 50)
    b.Position = pos or UDim2.new(0, 0, 0, 0)
    b.Image = imgUrl or ""
    b.BackgroundColor3 = Color3.new(1, 1, 1)
    b.Parent = p
    b.MouseButton1Click:Connect(callback or function() end)
    return b
end

-- Create a new label
function NewIDLib.Label(p, text, s, pos, textSize, textColor)
    local l = Instance.new("TextLabel")
    l.Size = s or UDim2.new(0, 200, 0, 50)
    l.Position = pos or UDim2.new(0, 0, 0, 0)
    l.Text = text or "Label"
    l.BackgroundColor3 = Color3.new(1, 1, 1)
    l.TextColor3 = textColor or Color3.new(0, 0, 0)
    l.TextSize = textSize or 14
    l.Parent = p
    return l
end

-- Create a new textbox
function NewIDLib.TextBox(p, placeholder, s, pos, multiLine)
    local tb = Instance.new("TextBox")
    tb.Size = s or UDim2.new(0, 200, 0, 50)
    tb.Position = pos or UDim2.new(0, 0, 0, 0)
    tb.PlaceholderText = placeholder or "Enter text..."
    tb.BackgroundColor3 = Color3.new(1, 1, 1)
    tb.TextColor3 = Color3.new(0, 0, 0)
    tb.MultiLine = multiLine or false
    tb.Parent = p
    return tb
end

-- Create a multi-line textbox
function NewIDLib.MultiLineTextBox(p, placeholder, s, pos)
    return NewIDLib.TextBox(p, placeholder, s, pos, true)
end

-- Create a new dropdown
function NewIDLib.Dropdown(p, options, pos)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(0, 200, 0, 50)
    d.Position = pos or UDim2.new(0, 0, 0, 0)
    d.BackgroundColor3 = Color3.new(1, 1, 1)
    d.Parent = p

    local btn = NewIDLib.Button(d, "Select", UDim2.new(1, 0, 0, 25), UDim2.new(0, 0, 0, 0))
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(1, 0, 0, #options * 25)
    optionsFrame.Position = UDim2.new(0, 0, 0, 25)
    optionsFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    optionsFrame.Visible = false
    optionsFrame.Parent = d

    for i, option in ipairs(options) do
        NewIDLib.Button(optionsFrame, option, UDim2.new(1, 0, 0, 25), UDim2.new(0, 0, (i - 1), 0), function()
            btn.Text = option
            optionsFrame.Visible = false
        end)
    end

    btn.MouseButton1Click:Connect(function()
        optionsFrame.Visible = not optionsFrame.Visible
    end)

    return d
end

-- Create a progress bar
function NewIDLib.ProgressBar(p, size, pos)
    local bar = Instance.new("Frame")
    bar.Size = size or UDim2.new(0, 200, 0, 25)
    bar.Position = pos or UDim2.new(0, 0, 0, 0)
    bar.BackgroundColor3 = Color3.new(1, 1, 1)
    bar.Parent = p

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.new(0, 0.7, 0)
    fill.Parent = bar

    function bar:SetProgress(value)
        fill.Size = UDim2.new(value, 0, 1, 0)
    end

    return bar
end

-- Create a slider
function NewIDLib.Slider(p, min, max, size, pos, callback)
    local s = Instance.new("Frame")
    s.Size = size or UDim2.new(0, 200, 0, 50)
    s.Position = pos or UDim2.new(0, 0, 0, 0)
    s.BackgroundColor3 = Color3.new(1, 1, 1)
    s.Parent = p

    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(0, 20, 1, 0)
    slider.Position = UDim2.new(0, 0, 0, 0)
    slider.BackgroundColor3 = Color3.new(0, 0.5, 1)
    slider.Parent = s

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
    local t = Instance.new("Frame")
    t.Size = size or UDim2.new(0, 100, 0, 50)
    t.Position = pos or UDim2.new(0, 0, 0, 0)
    t.BackgroundColor3 = Color3.new(1, 1, 1)
    t.Parent = p

    local btn = NewIDLib.Button(t, text or "Toggle", UDim2.new(1, 0, 0, 25), UDim2.new(0, 0, 0, 0), function()
        callback(not t:GetAttribute("toggled"))
    end)

    t:SetAttribute("toggled", false)

    return t
end

return NewIDLib
