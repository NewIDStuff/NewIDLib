local NewIDLib = {}
NewIDLib.Frame = {}

function NewIDLib.Frame.New()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")  -- Parent it to PlayerGui

    -- Create Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 300)  -- Increased size of the frame
    frame.BackgroundColor3 = Color3.new(0, 0, 0) -- Black color
    frame.Position = UDim2.new(0.5, -200, 0.5, -150) -- Centered on screen
    frame.ZIndex = 10 -- Ensure it's on top
    frame.Visible = true -- Ensure visibility
    frame.Parent = screenGui  -- Parent the frame to the ScreenGui

    -- Add rounded corners and shadow effect
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)  -- Rounded corners
    corner.Parent = frame

    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.BackgroundColor3 = Color3.new(0, 0, 0) -- Shadow color
    shadow.Position = UDim2.new(0, -5, 0, -5)  -- Offset to create shadow effect
    shadow.ZIndex = frame.ZIndex - 1 -- Place it behind the frame
    shadow.BackgroundTransparency = 0.5 -- Slight transparency for shadow
    shadow.Parent = frame

    print("Frame created:", frame)  -- Debug print to check frame creation

    -- Make the frame draggable
    local dragging
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)

    return frame
end

function NewIDLib.Frame.Outline(frame, color)
    -- Create an outline around the frame, simulating a stroke
    local outline = Instance.new("Frame")
    outline.Size = UDim2.new(1, 0, 1, 0)  -- Match the size of the frame
    outline.BackgroundColor3 = color -- Set the outline color
    outline.Position = UDim2.new(0, 0, 0, 0)  -- Center it around the frame
    outline.ZIndex = frame.ZIndex - 1 -- Place it behind the frame
    outline.BorderSizePixel = 0 -- Remove the border size for the outline effect

    -- Create a border using the Frame's border properties
    outline.BorderSizePixel = 0
    outline.BorderColor3 = color

    -- Create border frames on each side
    local topBorder = Instance.new("Frame")
    topBorder.Size = UDim2.new(1, 0, 0, 2) -- 2 pixels high
    topBorder.BackgroundColor3 = color
    topBorder.Position = UDim2.new(0, 0, 0, -2) -- Position above the frame
    topBorder.ZIndex = outline.ZIndex
    topBorder.Parent = outline

    local bottomBorder = Instance.new("Frame")
    bottomBorder.Size = UDim2.new(1, 0, 0, 2) -- 2 pixels high
    bottomBorder.BackgroundColor3 = color
    bottomBorder.Position = UDim2.new(0, 0, 1, 0) -- Position below the frame
    bottomBorder.ZIndex = outline.ZIndex
    bottomBorder.Parent = outline

    local leftBorder = Instance.new("Frame")
    leftBorder.Size = UDim2.new(0, 2, 1, 0) -- 2 pixels wide
    leftBorder.BackgroundColor3 = color
    leftBorder.Position = UDim2.new(0, -2, 0, 0) -- Position to the left of the frame
    leftBorder.ZIndex = outline.ZIndex
    leftBorder.Parent = outline

    local rightBorder = Instance.new("Frame")
    rightBorder.Size = UDim2.new(0, 2, 1, 0) -- 2 pixels wide
    rightBorder.BackgroundColor3 = color
    rightBorder.Position = UDim2.new(1, 0, 0, 0) -- Position to the right of the frame
    rightBorder.ZIndex = outline.ZIndex
    rightBorder.Parent = outline

    outline.Parent = frame.Parent -- Parent to the same ScreenGui
    print("Outline added with color:", color)  -- Debug print to check outline creation
end

return NewIDLib
