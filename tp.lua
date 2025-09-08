local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- ambil semua BasePart dari workspace
local checkpoints = {}
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        table.insert(checkpoints, obj)
    end
end

-- urutkan biar gampang (misal dari Y paling rendah ke tinggi)
table.sort(checkpoints, function(a, b)
    return a.Position.Y < b.Position.Y
end)

-- buat GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 400)
frame.Position = UDim2.new(0, 20, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

local uiList = Instance.new("UIListLayout")
uiList.Parent = frame
uiList.Padding = UDim.new(0, 5)

-- batasi max 50 tombol biar ga berat
for i, cp in ipairs(checkpoints) do
    if i > 50 then break end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = "Teleport ke Part " .. i
    btn.Parent = frame

    btn.MouseButton1Click:Connect(function()
        if char and hrp then
            hrp.CFrame = cp.CFrame + Vector3.new(0,3,0)
        end
    end)
end