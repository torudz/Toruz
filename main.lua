local Library = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Xóa bản cũ nếu có
if CoreGui:FindFirstChild("GeminiLib_UI") then
    CoreGui.GeminiLib_UI:Destroy()
end

function Library:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GeminiLib_UI"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
    MainFrame.Size = UDim2.new(0, 450, 0, 280)
    MainFrame.Active = true
    MainFrame.Draggable = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    -- Tiêu đề
    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.Text = titleText or "GEMINI PRISM"
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.Position = UDim2.new(0, 110, 0, 10)
    Title.Size = UDim2.new(0, 330, 0, 20)
    Title.BackgroundTransparency = 1

    -- Sidebar
    local SideBar = Instance.new("Frame")
    SideBar.Name = "SideBar"
    SideBar.Parent = MainFrame
    SideBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SideBar.Size = UDim2.new(0, 100, 1, 0)
    
    local SideCorner = Instance.new("UICorner")
    SideCorner.CornerRadius = UDim.new(0, 10)
    SideCorner.Parent = SideBar

    local SideLayout = Instance.new("UIListLayout")
    SideLayout.Parent = SideBar
    SideLayout.Padding = UDim.new(0, 5)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- Container chứa nội dung
    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.Position = UDim2.new(0, 110, 0, 40)
    Container.Size = UDim2.new(0, 330, 0, 230)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 2
    Container.CanvasSize = UDim2.new(0, 0, 0, 0) -- Tự động giãn

    local ContainerLayout = Instance.new("UIListLayout")
    ContainerLayout.Parent = Container
    ContainerLayout.Padding = UDim.new(0, 5)

    -- Hàm thêm Tab/Nút Sidebar
    function Library:AddTab(name, icon)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = SideBar
        TabBtn.Size = UDim2.new(0, 90, 0, 30)
        TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabBtn.Text = (icon or "") .. " " .. name
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 11

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn
        
        return TabBtn
    end

    -- Hàm thêm Toggle (Chức năng)
    function Library:AddToggle(text, callback)
        local TFrame = Instance.new("Frame")
        TFrame.Size = UDim2.new(1, -10, 0, 35)
        TFrame.BackgroundTransparency = 1
        TFrame.Parent = Container

        local Checkbox = Instance.new("TextButton")
        Checkbox.Size = UDim2.new(0, 20, 0, 20)
        Checkbox.Position = UDim2.new(0, 5, 0, 7)
        Checkbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Checkbox.Text = ""
        Checkbox.Parent = TFrame
        
        local CheckCorner = Instance.new("UICorner")
        CheckCorner.CornerRadius = UDim.new(0, 4)
        CheckCorner.Parent = Checkbox

        local Label = Instance.new("TextLabel")
        Label.Text = text
        Label.Position = UDim2.new(0, 35, 0, 0)
        Label.Size = UDim2.new(1, -40, 1, 0)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.fromRGB(200, 200, 200)
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = TFrame

        local state = false
        Checkbox.MouseButton1Click:Connect(function()
            state = not state
            Checkbox.BackgroundColor3 = state and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(60, 60, 60)
            Checkbox.Text = state and "✓" or ""
            callback(state)
        end)
        
        Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 10)
    end

    return Library
end

return Library
