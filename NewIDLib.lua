-- Library script

local Library = {}
Library.UI = Instance.new("ScreenGui")
Library.Frame = Instance.new("Frame")
Library.Label = Instance.new("TextLabel")

-- Function to initialize the library
function Library:Init()
    self.UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Set up the frame properties
    self.Frame.Size = UDim2.new(0, 400, 0, 300)
    self.Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    self.Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    self.Frame.Active = true
    self.Frame.Draggable = true
    self.Frame.Parent = self.UI
end

-- Function to create a new frame
function Library.Frame.New()
    -- Set up the label
    Library.Label.Size = UDim2.new(0, 200, 0, 50)
    Library.Label.Position = UDim2.new(0.5, -100, 0.5, -25)
    Library.Label.BackgroundTransparency = 1
    Library.Label.Text = "NewID Library"
    Library.Label.TextColor3 = Color3.new(1, 1, 1)
    Library.Label.TextScaled = true
    Library.Label.Parent = Library.UI

    -- Fade out the label
    Library:FadeOutLabel()

    -- Show the frame after label fades out
    Library.Frame.Parent = Library.UI
end

-- Function to fade out the label
function Library:FadeOutLabel()
    for i = 0, 1, 0.1 do
        wait(0.05)
        self.Label.TextTransparency = i
    end
    self.Label:Destroy()  -- Optionally destroy the label after fading out
end

-- Initialize the library when loaded
Library:Init()

return Library
