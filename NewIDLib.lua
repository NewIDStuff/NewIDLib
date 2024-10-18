-- NewIDLib.lua
local NewIDLib = {}
NewIDLib.Frame = {}

function NewIDLib.Frame.New()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")  -- Parent it to PlayerGui

    -- Create Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 200)  -- Size of the frame
    frame.BackgroundColor3 = Color3.new(0, 0, 0) -- Black color
    frame.Position = UDim2.new(0.5, -150, 0.5, -100) -- Centered on screen
    frame.ZIndex = 10 -- Ensure it's on top
    frame.Visible = true -- Ensure visibility
    frame.Parent = screenGui  -- Parent the frame to the ScreenGui

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

return NewIDLib
