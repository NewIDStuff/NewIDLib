-- Library script

local Library = {}
Library.UI = Instance.new("ScreenGui")
Library.Frame = {}

-- Initialize the UI
function Library:Init()
    self.UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    return self
end

-- Function to create a new draggable frame
function Library.Frame.New()
    -- Create a new Frame instance
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = Library.UI  -- Parent the frame to the UI

    -- Create a label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 50)
    label.Position = UDim2.new(0.5, -100, 0.5, -25)
    label.BackgroundTransparency = 1
    label.Text = "NewID Library"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Parent = Library.UI

    -- Fade out the label
    Library:FadeOutLabel(label)

    return frame  -- Optionally return the frame for further customization
end

-- Function to fade out the label
function Library:FadeOutLabel(label)
    for i = 0, 1, 0.1 do
        wait(0.05)
        label.TextTransparency = i
    end
    label:Destroy()  -- Optionally destroy the label after fading out
end

-- Initialize the library when loaded
Library:Init()

-- Expose the Frame object
Library.Frame.New = Library.Frame.New

return Library
