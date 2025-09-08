local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local checkpoints = {}

-- Cari folder checkpoint
local function findCheckpoints()
    checkpoints = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Folder") or obj:IsA("Model") then
            if obj.Name:lower():find("checkpoint") then
                for _, cp in ipairs(obj:GetDescendants()) do
                    if cp:IsA("BasePart") then
                        table.insert(checkpoints, cp)
                    end
                end
            end
        end
    end
end

findCheckpoints()

-- Urutkan biar rapih (misal obby naik gunung → urut Y)
table.sort(checkpoints, function(a, b)
    return a.Position.Y < b.Position.Y
end)

-- GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 140, 0, 40)
toggleBtn.Position = UDim2.new(0, 20, 0, 20)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 200)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.Text = "Show Teleport"

local frame = Instance.new("ScrollingFrame", screenGui)
frame.Size = UDim2.new(0, 220, 0, 320)
frame.Position = UDim2.new(0, 20, 0, 70)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.ScrollBarThickness = 6
frame.CanvasSize = UDim2.new(0,0,0, #checkpoints * 35)
frame.Visible = false

local uiList = Instance.new("UIListLayout", frame)
uiList.Padding = UDim.new(0, 5)

local isVisible = false
toggleBtn.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    frame.Visible = isVisible
    toggleBtn.Text = isVisible and "Hide Teleport" or "Show Teleport"
end)

-- Buat tombol teleport
for i, cp in ipairs(checkpoints) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Text = "Checkpoint " .. i

    btn.MouseButton1Click:Connect(function()
        hrp.CFrame = cp.CFrame + Vector3.new(0,5,0)
    end)
end
