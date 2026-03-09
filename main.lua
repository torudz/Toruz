local Library = {}
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Xóa bản cũ nếu tồn tại
if CoreGui:FindFirstChild("Toruz_Panel") then
    CoreGui.Toruz_Panel:Destroy()
end

function Library:CreateWindow(titleText, userName)
    local Window = {}
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Toruz_Panel"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    -- Khung chính màu đen đặc (như hình)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
    MainFrame.Size = UDim2.new(0, 450, 0, 250)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true -- Cho phép kéo thả
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 4)

    -- Nút Power Đỏ (Góc trên bên trái)
    local PowerBtn = Instance.new("TextButton")
    PowerBtn.Size = UDim2.new(0, 30, 0, 30)
    PowerBtn.Position = UDim2.new(0, 5, 0, 5)
    PowerBtn.BackgroundColor3 = Color3.fromRGB(190, 35, 35)
    PowerBtn.Text = "⏻"
    PowerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PowerBtn.TextSize = 18
    PowerBtn.Parent = MainFrame
    Instance.new("UICorner", PowerBtn).CornerRadius = UDim.new(0, 4)

    -- Tiêu đề Panel (Căn giữa phía trên)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 35)
    Title.Position = UDim2.new(0, 40, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = titleText or "Panel Free Fire 1.121.1"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSans
    Title.TextSize = 18
    Title.Parent = MainFrame

    -- Sidebar (Chứa Info và các Tab)
    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(0, 100, 1, -40)
    SideBar.Position = UDim2.new(0, 5, 0, 40)
    SideBar.BackgroundTransparency = 1
    SideBar.Parent = MainFrame

    local UserInfo = Instance.new("TextLabel")
    UserInfo.Size = UDim2.new(1, 0, 0, 35)
    UserInfo.BackgroundTransparency = 1
    UserInfo.Text = (userName or "Tu Sai Mod") .. "\nFps: 60.0"
    UserInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    UserInfo.Font = Enum.Font.SourceSans
    UserInfo.TextSize = 15
    UserInfo.Parent = SideBar

    -- Cập nhật FPS thực tế
    RunService.RenderStepped:Connect(function(dt)
        UserInfo.Text = (userName or "Tu Sai Mod") .. "\nFps: " .. math.floor(1/dt * 10)/10
    end)

    -- Layout cho các Tab ở Sidebar
    local TabList = Instance.new("UIListLayout")
    TabList.Parent = SideBar
    TabList.Padding = UDim.new(0, 3)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    -- Khung chứa chức năng (Có viền xám bao quanh như hình)
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(0, 335, 1, -45)
    ContentFrame.Position = UDim2.new(0, 110, 0, 40)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    ContentFrame.BorderSizePixel = 1
    ContentFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    ContentFrame.ScrollBarThickness = 2
    ContentFrame.Parent = MainFrame
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ContentFrame
    ContentLayout.Padding = UDim.new(0, 2)

    -- Cập nhật Canvas tự động
    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
    end)

    -- [METHOD: ADDTAB] - Nút xám bo góc chuẩn hình
    function Window:AddTab(name, icon)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 26)
        btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        btn.Text = icon .. " " .. name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 15
        btn.Parent = SideBar
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        return btn
    end

    -- [METHOD: ADDTOGGLE] - Ô vuông dấu tích xanh dương
    function Window:AddToggle(text, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 30)
        frame.BackgroundTransparency = 1
        frame.Parent = ContentFrame

        local box = Instance.new("TextButton")
        box.Size = UDim2.new(0, 20, 0, 20)
        box.Position = UDim2.new(0, 10, 0, 5)
        box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        box.Text = ""
        box.Parent = frame
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 3)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -40, 1, 0)
        label.Position = UDim2.new(0, 40, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(220, 220, 220)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.SourceSans
        label.TextSize = 16
        label.Parent = frame

        local enabled = false
        box.MouseButton1Click:Connect(function()
            enabled = not enabled
            -- Đổi màu và hiện dấu tích đúng chuẩn hình
            box.BackgroundColor3 = enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(45, 45, 45)
            box.Text = enabled and "✓" or ""
            box.TextColor3 = Color3.fromRGB(255, 255, 255)
            callback(enabled)
        end)
    end

    -- Đóng UI khi nhấn nút Power
    PowerBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    return Window
end

return Library
