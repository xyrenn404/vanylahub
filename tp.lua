local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local checkpoints = {}

-- Cari semua checkpoint berdasarkan nama
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") and obj.Name:lower():find("checkpoint") then
        table.insert(checkpoints, obj)
    end
end

-- Urutkan biar rapih (berdasarkan posisi Y)
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

-- Tinggi frame menyesuaikan jumlah checkpoint (maks 8 tombol)
local frameHeight = math.min(#checkpoints, 8) * 35 + 10

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 220, 0, frameHeight)
frame.Position = UDim2.new(0, 20, 0, 70)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Visible = false

local uiList = Instance.new("UIListLayout", frame)
uiList.Padding = UDim.new(0, 5)
uiList.FillDirection = Enum.FillDirection.Vertical
uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiList.VerticalAlignment = Enum.VerticalAlignment.Top

local isVisible = false
toggleBtn.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    frame.Visible = isVisible
    toggleBtn.Text = isVisible and "Hide Teleport" or "Show Teleport"
end)

-- Buat tombol teleport sesuai checkpoint
for i, cp in ipairs(checkpoints) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Text = "Pos " .. i  -- Label tombol sesuai permintaan

    btn.MouseButton1Click:Connect(function()
        if hrp and cp then
            hrp.CFrame = cp.CFrame + Vector3.new(0,5,0)
        end
    end)
end

warn("Total checkpoint terdeteksi: " .. #checkpoints)
