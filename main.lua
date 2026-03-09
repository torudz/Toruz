local Library = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Xóa bản cũ nếu tồn tại để tránh đè UI
if CoreGui:FindFirstChild("GeminiPrism_Mobile") then
    CoreGui.GeminiPrism_Mobile:Destroy()
end

function Library:CreateWindow(titleText)
    local Window = {} -- Table chứa các method của Window
    
    -- Khởi tạo ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GeminiPrism_Mobile"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    -- Khung Chính
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

    -- Sidebar
    local SideBar = Instance.new("Frame")
    SideBar.Name = "SideBar"
    SideBar.Parent = MainFrame
    SideBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SideBar.Size = UDim2.new(0, 100, 1, 0)
    Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 12)

    local SideLayout = Instance.new("UIListLayout")
    SideLayout.Parent = SideBar
    SideLayout.Padding = UDim.new(0, 5)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

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

    -- Nội dung cuộn
    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.Position = UDim2.new(0, 110, 0, 40)
    Container.Size = UDim2.new(0, 330, 0, 250)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 2
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)

    local ContainerLayout = Instance.new("UIListLayout")
    ContainerLayout.Parent = Container
    ContainerLayout.Padding = UDim.new(0, 8)
    
    ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 20)
    end)

    -- [METHOD: ADDTAB]
    function Window:AddTab(name, icon)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = SideBar
        TabBtn.Size = UDim2.new(0, 90, 0, 35)
        TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabBtn.Text = (icon or "") .. " " .. name
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 11
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        
        -- Ở bản này mình làm đơn giản, bạn có thể thêm logic chuyển đổi Container tại đây
        return TabBtn
    end

    -- [METHOD: ADDPARAGRAPH]
    function Window:AddParagraph(title, content)
        local PFrame = Instance.new("Frame")
        PFrame.Size = UDim2.new(1, -10, 0, 55)
        PFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        PFrame.Parent = Container
        Instance.new("UICorner", PFrame).CornerRadius = UDim.new(0, 8)

        local PT = Instance.new("TextLabel")
        PT.Text = title
        PT.Size = UDim2.new(1, -20, 0, 25)
        PT.Position = UDim2.new(0, 10, 0, 5)
        PT.TextColor3 = Color3.fromRGB(255, 255, 255)
        PT.Font = Enum.Font.GothamBold
        PT.BackgroundTransparency = 1
        PT.TextXAlignment = Enum.TextXAlignment.Left
        PT.Parent = PFrame

        local PD = Instance.new("TextLabel")
        PD.Text = content
        PD.Size = UDim2.new(1, -20, 0, 20)
        PD.Position = UDim2.new(0, 10, 0, 25)
        PD.TextColor3 = Color3.fromRGB(180, 180, 180)
        PD.Font = Enum.Font.Gotham
        PD.BackgroundTransparency = 1
        PD.TextXAlignment = Enum.TextXAlignment.Left
        PD.Parent = PFrame
    end

    -- [METHOD: ADDTOGGLE]
    function Window:AddToggle(text, callback)
        local TFrame = Instance.new("Frame")
        TFrame.Size = UDim2.new(1, -10, 0, 35)
        TFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TFrame.Parent = Container
        Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 6)

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 1, 0)
        Button.BackgroundTransparency = 1
        Button.Text = "  " .. text
        Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        Button.Font = Enum.Font.Gotham
        Button.TextXAlignment = Enum.TextXAlignment.Left
        Button.Parent = TFrame

        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 18, 0, 18)
        Indicator.Position = UDim2.new(1, -25, 0.5, -9)
        Indicator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Indicator.Parent = TFrame
        Instance.new("UICorner", Indicator).CornerRadius = UDim.new(0, 4)

        local enabled = false
        Button.MouseButton1Click:Connect(function()
            enabled = not enabled
            TweenService:Create(Indicator, TweenInfo.new(0.2), {
                BackgroundColor3 = enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(60, 60, 60)
            }):Play()
            callback(enabled)
        end)
    end

    -- [METHOD: ADDDROPDOWN]
    function Window:AddDropdown(text, options, callback)
    local DFrame = Instance.new("Frame")
    DFrame.Size = UDim2.new(1, -10, 0, 35)
    DFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    DFrame.ClipsDescendants = true
    DFrame.Parent = Container
    Instance.new("UICorner", DFrame).CornerRadius = UDim.new(0, 6)

    local DBtn = Instance.new("TextButton")
    DBtn.Size = UDim2.new(1, 0, 0, 35)
    DBtn.BackgroundTransparency = 1
    DBtn.Text = text .. " : Select"
    DBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DBtn.Font = Enum.Font.Gotham
    DBtn.Parent = DFrame

    local open = false
    
    -- Tạo khung Search (Ẩn khi đóng)
    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(1, -10, 0, 25)
    SearchBox.Position = UDim2.new(0, 5, 0, 40)
    SearchBox.PlaceholderText = "Search..."
    SearchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.Visible = false
    SearchBox.Parent = DFrame
    Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)

    -- Hàm cập nhật danh sách dựa trên Search
    local function UpdateOptions(filter)
        -- Xóa các nút cũ
        for _, v in pairs(DFrame:GetChildren()) do
            if v.Name == "Option" then v:Destroy() end
        end
        
        local count = 0
        for i, v in pairs(options) do
            if filter == "" or string.find(string.lower(v), string.lower(filter)) then
                count = count + 1
                local Opt = Instance.new("TextButton")
                Opt.Name = "Option"
                Opt.Size = UDim2.new(1, 0, 0, 30)
                Opt.Position = UDim2.new(0, 0, 0, 70 + (count-1)*30)
                Opt.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Opt.Text = v
                Opt.TextColor3 = Color3.fromRGB(200, 200, 200)
                Opt.Font = Enum.Font.Gotham
                Opt.Parent = DFrame
                
                Opt.MouseButton1Click:Connect(function()
                    DBtn.Text = text .. " : " .. v
                    callback(v)
                    open = false
                    DFrame.Size = UDim2.new(1, -10, 0, 35)
                    SearchBox.Visible = false
                end)
            end
        end
        -- Cập nhật chiều cao khung dựa trên số kết quả tìm thấy
        if open then
            DFrame.Size = UDim2.new(1, -10, 0, 75 + (count * 30))
        end
    end

    DBtn.MouseButton1Click:Connect(function()
        open = not open
        SearchBox.Visible = open
        if open then
            UpdateOptions("") -- Hiện tất cả khi mới mở
        else
            DFrame.Size = UDim2.new(1, -10, 0, 35)
        end
    end)

    -- Lọc mỗi khi gõ phím
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        UpdateOptions(SearchBox.Text)
    end)
end


    return Window
end

return Library
