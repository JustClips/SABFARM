--[[ Roblox AFK Farm GUI and Automation Script (De-obfuscated & Commented) ]]

local services = {
    RunService = game:GetService("RunService"),
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    VirtualUser = game:GetService("VirtualUser"),
    UserInputService = game:GetService("UserInputService"),
}

local localPlayer = services.Players.LocalPlayer
local running = false
local searchName = ""
local foundAnimals = {}
local numDots = 14
local minSpeed = 0.19
local maxSpeed = 0.39
local altSpeed = 0.32
local altMaxSpeed = 0.70

-- Prevent Idle Kick
localPlayer.Idled:Connect(function()
    services.VirtualUser:CaptureController()
    services.VirtualUser:ClickButton2(Vector2.new())
end)

-- Screen GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "bRn"
gui.Parent = localPlayer:WaitForChild("PlayerGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame Setup
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 340, 0, 210)
mainFrame.Position = UDim2.new(0.5, -170, 0.42, -105)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 32, 50)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.ZIndex = 2
mainFrame.Parent = gui
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

-- Gradient Background
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(27, 68, 135)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 193, 255))
})
gradient.Rotation = 35

-- Decorative Image
local decoImg = Instance.new("ImageLabel", mainFrame)
decoImg.BackgroundTransparency = 1
decoImg.Image = "rbxassetid://4996891970"
decoImg.Size = UDim2.new(1, 25, 1, 25)
decoImg.Position = UDim2.new(-0.04, 0, -0.08, 0)
decoImg.ImageColor3 = Color3.fromRGB(0, 194, 255)
decoImg.ImageTransparency = 0.93
decoImg.ZIndex = 0

-- Dots Animation Background Frame
local animBg = Instance.new("Frame", mainFrame)
animBg.Name = "bg"
animBg.Size = UDim2.new(1, 0, 1, 0)
animBg.Position = UDim2.new(0, 0, 0, 0)
animBg.BackgroundTransparency = 1
animBg.ZIndex = 1

-- Make Main Frame draggable
do
    local dragging, dragInput, dragStart, startPos
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Title Label
local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 38)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Brainrot AFK Farm"
titleLabel.TextColor3 = Color3.fromRGB(180, 235, 255)
titleLabel.TextStrokeTransparency = 0.9
titleLabel.TextSize = 22
titleLabel.ZIndex = 3

-- Minimize Button
local minimizeBtn = Instance.new("TextButton", mainFrame)
minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
minimizeBtn.Position = UDim2.new(1, -38, 0, 6)
minimizeBtn.AnchorPoint = Vector2.new(0, 0)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(180, 235, 255)
minimizeBtn.Font = Enum.Font.GothamBlack
minimizeBtn.TextSize = 30
minimizeBtn.ZIndex = 5

-- Restore Button
local restoreBtn = Instance.new("TextButton", gui)
restoreBtn.Size = UDim2.new(0, 44, 0, 44)
restoreBtn.Position = UDim2.new(1, -54, 0, -24)
restoreBtn.AnchorPoint = Vector2.new(0, 0)
restoreBtn.BackgroundColor3 = Color3.fromRGB(32, 46, 72)
restoreBtn.BackgroundTransparency = 0.13
restoreBtn.Text = "+"
restoreBtn.TextColor3 = Color3.fromRGB(0, 220, 255)
restoreBtn.Font = Enum.Font.GothamBlack
restoreBtn.TextSize = 36
restoreBtn.Visible = false
restoreBtn.ZIndex = 100
Instance.new("UICorner", restoreBtn).CornerRadius = UDim.new(1, 0)

-- Minimize/Restore functionality
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    restoreBtn.Visible = true
end)
restoreBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    restoreBtn.Visible = false
    mainFrame.ZIndex = mainFrame.ZIndex + 1
end)

-- Animal Name Input
local animalBox = Instance.new("TextBox", mainFrame)
animalBox.Text = ""
animalBox.PlaceholderText = "e.g Noobini Pizzanini"
animalBox.Size = UDim2.new(1, -40, 0, 34)
animalBox.Position = UDim2.new(0, 20, 0, 48)
animalBox.BackgroundColor3 = Color3.fromRGB(32, 46, 72)
animalBox.Font = Enum.Font.Gotham
animalBox.TextColor3 = Color3.fromRGB(0, 180, 255)
animalBox.PlaceholderColor3 = Color3.fromRGB(98, 180, 255)
animalBox.TextSize = 18
animalBox.ClearTextOnFocus = false
animalBox.ZIndex = 3
Instance.new("UICorner", animalBox).CornerRadius = UDim.new(0, 8)

-- Start Button
local startBtn = Instance.new("TextButton", mainFrame)
startBtn.Size = UDim2.new(0.42, 0, 0, 36)
startBtn.Position = UDim2.new(0.08, 0, 0, 104)
startBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
startBtn.Font = Enum.Font.GothamBold
startBtn.Text = "Start"
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.TextSize = 20
startBtn.AutoButtonColor = false
startBtn.ZIndex = 3
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)

-- Stop Button
local stopBtn = Instance.new("TextButton", mainFrame)
stopBtn.Size = UDim2.new(0.42, 0, 0, 36)
stopBtn.Position = UDim2.new(0.50, 8, 0, 104)
stopBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 200)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.Text = "Stop"
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.TextSize = 20
stopBtn.AutoButtonColor = false
stopBtn.ZIndex = 3
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 8)

-- Status Label
local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Size = UDim2.new(1, -24, 0, 32)
statusLabel.Position = UDim2.new(0, 12, 0, 158)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(170, 230, 255)
statusLabel.TextSize = 18
statusLabel.ZIndex = 3

-- Animated Dots Setup
local dots, velocities, glows = {}, {}, {}

local function setupDots()
    for _,v in pairs(animBg:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    dots, velocities, glows = {}, {}, {}
    local size = animBg.AbsoluteSize
    for i = 1, numDots do
        local dot = Instance.new("Frame")
        local dotSize = math.random(5, 10)
        dot.Size = UDim2.new(0, dotSize, 0, dotSize)
        dot.BackgroundTransparency = 0.13
        dot.BackgroundColor3 = Color3.fromRGB(100 + math.random(60), 200, 255)
        dot.BorderSizePixel = 0
        dot.ZIndex = 2
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Position = UDim2.new(0, math.random(15, math.max(15, size.X - 15)), 0, math.random(15, math.max(15, size.Y - 15)))
        dot.Parent = animBg
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
        
        local glowImg = Instance.new("ImageLabel", dot)
        glowImg.BackgroundTransparency = 1
        glowImg.Image = "rbxassetid://4996891970"
        glowImg.ImageColor3 = Color3.fromRGB(170, 220, 255)
        glowImg.Size = UDim2.new(1, 11, 1, 11)
        glowImg.Position = UDim2.new(0.5, -5, 0.5, -5)
        glowImg.AnchorPoint = Vector2.new(0.5, 0.5)
        glowImg.ImageTransparency = 0.63
        glowImg.ZIndex = 1
        
        local vx = (math.random() - 0.5) * (maxSpeed - minSpeed) + (math.random() > 0.5 and maxSpeed or -maxSpeed)
        local vy = (math.random() - 0.5) * (maxSpeed - minSpeed) + (math.random() > 0.5 and maxSpeed or -maxSpeed)
        table.insert(dots, dot)
        table.insert(velocities, {vx = vx, vy = vy})
        table.insert(glows, glowImg)
    end
end

animBg:GetPropertyChangedSignal("AbsoluteSize"):Connect(setupDots)
setupDots()

services.RunService.RenderStepped:Connect(function(dt)
    local size = animBg.AbsoluteSize
    for i, dot in ipairs(dots) do
        local pos = dot.Position
        local px, py = pos.X.Offset, pos.Y.Offset
        local v = velocities[i]
        local smin, smax = running and altSpeed or minSpeed, running and altMaxSpeed or maxSpeed
        local targetGlow = running and 0.30 or 0.63
        local currentGlow = glows[i].ImageTransparency
        glows[i].ImageTransparency = currentGlow + (targetGlow - currentGlow) * 0.15
        if math.random() < 0.017 then
            v.vx = (math.random() - 0.5) * (smax - smin) + (math.random() > 0.5 and smax or -smax)
            v.vy = (math.random() - 0.5) * (smax - smin) + (math.random() > 0.5 and smax or -smax)
        end
        px = px + v.vx * 32 * dt
        py = py + v.vy * 32 * dt
        if px < 10 then px = size.X - 12 end
        if px > size.X - 10 then px = 12 end
        if py < 10 then py = size.Y - 12 end
        if py > size.Y - 10 then py = 12 end
        dot.Position = UDim2.new(0, px, 0, py)
    end
end)

-- Helper: Find animal instance by name
local function findAnimalByName(name, alreadyFound)
    local group = workspace:FindFirstChild("RenderedMovingAnimals")
    if not group then return nil end
    for _, animal in ipairs(group:GetChildren()) do
        if animal.Name == name and not alreadyFound[animal] then
            return animal
        end
    end
    return nil
end

-- Helper: Get position of animal
local function getAnimalPosition(animal)
    if animal.PrimaryPart then
        return animal.PrimaryPart.Position
    else
        for _, part in ipairs(animal:GetDescendants()) do
            if part:IsA("BasePart") then return part.Position end
        end
    end
    return nil
end

-- Helper: Find nearest enabled proximity prompt
local function findClosestPrompt()
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local closestPrompt = nil
    local closestDist = 20
    for _, prompt in ipairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local pos = nil
            if prompt.Parent:IsA("BasePart") then
                pos = prompt.Parent.Position
            elseif prompt.Parent:IsA("Attachment") then
                pos = prompt.Parent.WorldPosition
            end
            if pos then
                local dist = (root.Position - pos).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPrompt = prompt
                end
            end
        end
    end
    return closestPrompt
end

-- Helper: Move player to a position
local function moveTo(pos)
    local char = localPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:MoveTo(pos)
    end
end

-- Button/Status update function
local function updateButtons()
    if running then
        startBtn.Text = "Looking for \"" .. (#searchName > 0 and searchName or "???") .. "\""
        stopBtn.Text = "Stop"
    else
        startBtn.Text = "Start"
        stopBtn.Text = "Paused"
    end
end
updateButtons()

animalBox.FocusLost:Connect(function()
    searchName = animalBox.Text
    if running then updateButtons() end
end)

-- Main Start Button Logic
local conn
startBtn.MouseButton1Click:Connect(function()
    running = true
    foundAnimals = {}
    searchName = animalBox.Text
    updateButtons()
    statusLabel.Text = "Looking for \"" .. (#searchName > 0 and searchName or "???") .. "\"..."
    statusLabel.TextColor3 = Color3.fromRGB(80, 255, 220)
    if conn then conn:Disconnect() end
    conn = services.RunService.RenderStepped:Connect(function()
        if running and #searchName > 0 then
            local animal = findAnimalByName(searchName, foundAnimals)
            if animal then
                local pos = getAnimalPosition(animal)
                if pos then
                    local char = localPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local root = char.HumanoidRootPart
                        local dist = (root.Position - pos).Magnitude
                        if dist > 5 then
                            moveTo(pos)
                        elseif dist <= 20 then
                            if not foundAnimals[animal] then
                                local prompt = findClosestPrompt()
                                if prompt then
                                    foundAnimals[animal] = true
                                    fireproximityprompt(prompt, 2.1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)

-- Stop Button Logic
stopBtn.MouseButton1Click:Connect(function()
    running = false
    updateButtons()
    statusLabel.Text = ""
    if conn then conn:Disconnect() end
end)

-- Toggle GUI with RightShift
services.UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        gui.Enabled = not gui.Enabled
    end
end)
