-- NewIDLib.lua
local NewIDLib = {}
NewIDLib.Frame = {}

function NewIDLib.Frame.New()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.BackgroundColor3 = Color3.new(0, 0, 0) -- Black color
    frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    frame.Parent = game.Players.LocalPlayer.PlayerGui

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
