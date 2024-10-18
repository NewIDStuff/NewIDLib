-- Library script

local Library = {}
Library.UI = Instance.new("ScreenGui")
Library.Frame = {}
Library.Button = {}

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
    label.TextColor3 = Color3.new(0.9, 0.9, 0.9)  -- Light gray text for visibility
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

-- Function to create a new toggle button
function Library.Button.New(buttonText, toggleFunction)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 150, 0, 40)  -- Button size
    button.Position = UDim2.new(0, 10, 0.5, -20)  -- Positioned on the left side
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)  -- Button color
    button.TextColor3 = Color3.new(1, 1, 1)  -- White text
    button.Text = buttonText or "Toggle"  -- Button text
    button.TextScaled = true
    button.Parent = Library.UI  -- Parent the button to the UI

    local toggled = false  -- State of the toggle

    -- Function to handle button clicks
    button.MouseButton1Click:Connect(function()
        toggled = not toggled  -- Toggle the state

        if toggleFunction and type(toggleFunction) == "function" then
            toggleFunction(toggled)  -- Call the custom function with the toggled state
        end

        -- Optionally change the button color based on toggle state
        if toggled then
            button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Green when on
        else
            button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red when off
        end
    end)

    return button  -- Optionally return the button for further customization
end

-- Initialize the library when loaded
Library:Init()

-- Expose the Frame and Button objects
Library.Frame.New = Library.Frame.New
Library.Button.New = Library.Button.New

return Library
