local KeySystem = {}
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

function KeySystem:Start(config)
    local CorrectKey = config.Key -- Key bạn thiết lập
    local ScriptCallback = config.Callback -- Script chính sẽ chạy nếu đúng key
    local DiscordLink = config.Discord or "https://discord.gg/toruz"

    -- Xóa bản cũ nếu có
    if CoreGui:FindFirstChild("ToruzKeySystem") then CoreGui.ToruzKeySystem:Destroy() end

    local Gui = Instance.new("ScreenGui", CoreGui)
    Gui.Name = "ToruzKeySystem"

    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 300, 0, 180)
    Main.Position = UDim2.new(0.5, -150, 0.5, -90)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "KEY SYSTEM"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18

    local TextBox = Instance.new("TextBox", Main)
    TextBox.Size = UDim2.new(0, 260, 0, 35)
    TextBox.Position = UDim2.new(0.5, -130, 0, 50)
    TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TextBox.PlaceholderText = "Nhập Key tại đây..."
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", TextBox)

    -- Nút Kiểm Tra Key
    local CheckBtn = Instance.new("TextButton", Main)
    CheckBtn.Size = UDim2.new(0, 125, 0, 35)
    CheckBtn.Position = UDim2.new(0, 20, 0, 100)
    CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    CheckBtn.Text = "Check Key"
    CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", CheckBtn)

    -- Nút Lấy Key (Get Key)
    local GetKeyBtn = Instance.new("TextButton", Main)
    GetKeyBtn.Size = UDim2.new(0, 125, 0, 35)
    GetKeyBtn.Position = UDim2.new(0, 155, 0, 100)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    GetKeyBtn.Text = "Get Key"
    GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", GetKeyBtn)

    local Status = Instance.new("TextLabel", Main)
    Status.Size = UDim2.new(1, 0, 0, 30)
    Status.Position = UDim2.new(0, 0, 0, 140)
    Status.BackgroundTransparency = 1
    Status.Text = "Vui lòng nhập key để tiếp tục"
    Status.TextColor3 = Color3.fromRGB(150, 150, 150)
    Status.TextSize = 12
    Status.Parent = Main

    -- Logic Nút Bấm
    GetKeyBtn.MouseButton1Click:Connect(function()
        setclipboard(DiscordLink)
        Status.Text = "Đã copy link Discord vào bộ nhớ!"
        Status.TextColor3 = Color3.fromRGB(0, 255, 150)
    end)

    CheckBtn.MouseButton1Click:Connect(function()
        if TextBox.Text == CorrectKey then
            Status.Text = "Key chính xác! Đang tải Menu..."
            Status.TextColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(1)
            Gui:Destroy()
            ScriptCallback() -- Chạy script chính
        else
            Status.Text = "Key sai rồi! Vui lòng kiểm tra lại."
            Status.TextColor3 = Color3.fromRGB(255, 50, 50)
            TextBox.Text = ""
        end
    end)
end

return KeySystem
