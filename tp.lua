-- WalkSpeed + JumpPower + Unlimited Jump GUI
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local unlimitedJump = false

-- Buat GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerControlGui"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Frame utama
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 160)
frame.Position = UDim2.new(0.5, -110, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "Player Controller"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- WalkSpeed input
local wsBox = Instance.new("TextBox")
wsBox.Size = UDim2.new(0.6, -10, 0, 25)
wsBox.Position = UDim2.new(0, 10, 0, 35)
wsBox.PlaceholderText = "WalkSpeed"
wsBox.Text = tostring(humanoid.WalkSpeed)
wsBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
wsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
wsBox.TextSize = 14
wsBox.Font = Enum.Font.Gotham
wsBox.Parent = frame

local wsCorner = Instance.new("UICorner")
wsCorner.CornerRadius = UDim.new(0, 6)
wsCorner.Parent = wsBox

local wsBtn = Instance.new("TextButton")
wsBtn.Size = UDim2.new(0.35, 0, 0, 25)
wsBtn.Position = UDim2.new(0.65, -5, 0, 35)
wsBtn.Text = "Apply"
wsBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 250)
wsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
wsBtn.TextSize = 14
wsBtn.Font = Enum.Font.GothamBold
wsBtn.Parent = frame

local wsBtnCorner = Instance.new("UICorner")
wsBtnCorner.CornerRadius = UDim.new(0, 6)
wsBtnCorner.Parent = wsBtn

-- JumpPower input
local jpBox = Instance.new("TextBox")
jpBox.Size = UDim2.new(0.6, -10, 0, 25)
jpBox.Position = UDim2.new(0, 10, 0, 70)
jpBox.PlaceholderText = "JumpPower"
jpBox.Text = tostring(humanoid.JumpPower)
jpBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jpBox.TextSize = 14
jpBox.Font = Enum.Font.Gotham
jpBox.Parent = frame

local jpCorner = Instance.new("UICorner")
jpCorner.CornerRadius = UDim.new(0, 6)
jpCorner.Parent = jpBox

local jpBtn = Instance.new("TextButton")
jpBtn.Size = UDim2.new(0.35, 0, 0, 25)
jpBtn.Position = UDim2.new(0.65, -5, 0, 70)
jpBtn.Text = "Apply"
jpBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
jpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
jpBtn.TextSize = 14
jpBtn.Font = Enum.Font.GothamBold
jpBtn.Parent = frame

local jpBtnCorner = Instance.new("UICorner")
jpBtnCorner.CornerRadius = UDim.new(0, 6)
jpBtnCorner.Parent = jpBtn

-- Unlimited Jump toggle
local ujBtn = Instance.new("TextButton")
ujBtn.Size = UDim2.new(0.9, 0, 0, 30)
ujBtn.Position = UDim2.new(0.05, 0, 0, 110)
ujBtn.Text = "Unlimited Jump: OFF"
ujBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
ujBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ujBtn.TextSize = 14
ujBtn.Font = Enum.Font.GothamBold
ujBtn.Parent = frame

local ujCorner = Instance.new("UICorner")
ujCorner.CornerRadius = UDim.new(0, 8)
ujCorner.Parent = ujBtn

-- Fungsi apply WalkSpeed
wsBtn.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(wsBox.Text)
    if newSpeed and newSpeed > 0 then
        humanoid.WalkSpeed = newSpeed
    else
        wsBox.Text = tostring(humanoid.WalkSpeed)
    end
end)

-- Fungsi apply JumpPower
jpBtn.MouseButton1Click:Connect(function()
    local newJump = tonumber(jpBox.Text)
    if newJump and newJump > 0 then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = newJump
    else
        jpBox.Text = tostring(humanoid.JumpPower)
    end
end)

-- Toggle Unlimited Jump
ujBtn.MouseButton1Click:Connect(function()
    unlimitedJump = not unlimitedJump
    if unlimitedJump then
        ujBtn.Text = "Unlimited Jump: ON"
        ujBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
    else
        ujBtn.Text = "Unlimited Jump: OFF"
        ujBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    end
end)

-- Sistem Unlimited Jump
UserInputService.JumpRequest:Connect(function()
    if unlimitedJump and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Respawn handler
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
end)
