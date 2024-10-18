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
    -- Create a label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 50)
    label.Position = UDim2.new(0.5, -100, 0.5, -25)
    label.BackgroundTransparency = 1
    label.Text = "NewID Library"
    label.TextColor3 = Color3.new(0, 0, 0)  -- Set text color to black
    label.TextScaled = true
    label.Parent = Library.UI

    -- Fade out the label slowly
    Library:FadeOutLabel(label)

    -- Create a new Frame instance
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 600, 0, 400)  -- Thicker rectangle frame
    frame.Position = UDim2.new(0.5, -300, 0.5, -200)  -- Centered on the screen
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  -- Frame color
    frame.Active = true
    frame.Draggable = true

    -- Wait for the label to fade out before showing the frame
    frame.Parent = Library.UI  -- Parent the frame to the UI

    return frame  -- Optionally return the frame for further customization
end

-- Function to fade out the label
function Library:FadeOutLabel(label)
    for i = 0, 1, 0.05 do  -- Slower fade (0.05 increments)
        wait(0.1)  -- Wait longer for smoother fade
        label.TextTransparency = i
    end
    label:Destroy()  -- Destroy the label after fading out
end

-- Initialize the library when loaded
Library:Init()

-- Expose the Frame object
Library.Frame.New = Library.Frame.New

return Library
