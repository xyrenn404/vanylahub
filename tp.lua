local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local checkpoints = {}

-- Cari semua checkpoint
for _, folder in ipairs(workspace:GetChildren()) do
    if folder:IsA("Folder") or folder:IsA("Model") then
        if folder.Name:lower():find("checkpoint") or folder.Name:lower():find("stage") or folder.Name:lower():find("spawn") then
            for _, obj in ipairs(folder:GetDescendants()) do
                if obj:IsA("BasePart") then
                    table.insert(checkpoints, obj)
                end
            end
        end
    end
end

for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("SpawnLocation") then
        table.insert(checkpoints, obj)
    elseif obj:IsA("BasePart") and obj:FindFirstChildOfClass("TouchTransmitter") then
        table.insert(checkpoints, obj)
    end
end

table.sort(checkpoints, function(a, b)
    return a.Position.Y < b.Position.Y
end)

-- GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- Toggle button
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 120, 0, 40)
toggleBtn.Position = UDim2.new(0, 20, 0, 20)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.Text = "Show Teleport"

-- Main frame
local frame = Instance.new("ScrollingFrame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 70)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.ScrollBarThickness = 6
frame.CanvasSize = UDim2.new(0,0,0, #checkpoints * 35)
frame.Visible = false

local uiList = Instance.new("UIListLayout", frame)
uiList.Padding = UDim.new(0, 5)

-- Toggle logic
local isVisible = false
toggleBtn.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    frame.Visible = isVisible
    toggleBtn.Text = isVisible and "Hide Teleport" or "Show Teleport"
end)

-- Buttons
for i, cp in ipairs(checkpoints) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Text = "Checkpoint " .. i

    btn.MouseButton1Click:Connect(function()
        hrp.CFrame = cp.CFrame + Vector3.new(0,3,0)
    end)
end