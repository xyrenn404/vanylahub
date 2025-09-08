local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local checkpoints = {}

for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        if obj:FindFirstChildOfClass("TouchTransmitter") then
            warn("Checkpoint Touch ditemukan:", obj:GetFullName())
            table.insert(checkpoints, obj)
        elseif obj:FindFirstChildOfClass("ProximityPrompt") then
            warn("Checkpoint Prompt ditemukan:", obj:GetFullName())
            table.insert(checkpoints, obj)
        end
    end
end

table.sort(checkpoints, function(a, b)
    return a.Position.Y < b.Position.Y
end)

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 20, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local uiList = Instance.new("UIListLayout", frame)
uiList.Padding = UDim.new(0, 5)

for i, cp in ipairs(checkpoints) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = "Checkpoint " .. i

    btn.MouseButton1Click:Connect(function()
        hrp.CFrame = cp.CFrame + Vector3.new(0,3,0)
        if cp:FindFirstChildOfClass("TouchTransmitter") then
            firetouchinterest(hrp, cp, 0)
            task.wait(0.1)
            firetouchinterest(hrp, cp, 1)
        elseif cp:FindFirstChildOfClass("ProximityPrompt") then
            fireproximityprompt(cp:FindFirstChildOfClass("ProximityPrompt"))
        end
    end)
end