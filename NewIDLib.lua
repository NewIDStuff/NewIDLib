local NewIDLib = {}
NewIDLib.Frame = {}
NewIDLib.Button = {}

-- Create a frame for the button
function NewIDLib.Frame.New()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")  -- Parent it to PlayerGui

    -- Create Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 300)  -- Size of the frame
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

    -- Make frame draggable
    local dragging, dragInput, startPos, startFramePos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = input.Position
            startFramePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - startPos
            frame.Position = UDim2.new(startFramePos.X.Scale, startFramePos.X.Offset + delta.X, startFramePos.Y.Scale, startFramePos.Y.Offset + delta.Y)
        end
    end)

    return frame
end

-- Create a button that toggles a function on and off
function NewIDLib.Button.New(text, toggleFunction, parentFrame)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)  -- Size of the button
    button.Position = UDim2.new(0.5, -100, 0.5, -25) -- Centered in the frame
    button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- Dark grey color
    button.TextColor3 = Color3.new(1, 1, 1) -- White text
    button.TextSize = 24 -- Text size
    button.Text = text -- Set the button text
    button.BorderSizePixel = 0 -- Remove border
    button.ZIndex = 10 -- Ensure it's on top

    -- Add rounded corners to the button
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = button

    -- Add UIStroke to the button for better visibility
    local uiStroke = Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Color = Color3.new(1, 1, 1) -- White stroke
    uiStroke.Thickness = 2
    uiStroke.Parent = button

    button.Parent = parentFrame -- Parent it to the specified frame

    local isActive = false -- State of the toggle

    button.MouseButton1Click:Connect(function()
        isActive = not isActive -- Toggle the state
        if isActive then
            toggleFunction() -- Call the function when activated
        else
            print("Function toggled off") -- Debug print for deactivation
        end
    end)

    print("Button created:", button)  -- Debug print to check button creation
    return button
end

function NewIDLib.Frame.Outline(frame, color)
    -- Add a UIStroke for the outline effect
    local uiStroke = Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Color = color
    uiStroke.Thickness = 2 -- Adjust thickness as needed
    uiStroke.Parent = frame

    print("UIStroke added with color:", color)  -- Debug print to check UIStroke creation
end

return NewIDLib
