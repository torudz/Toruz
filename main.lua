local Library = {}
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("Toruz_Final") then CoreGui.Toruz_Final:Destroy() end
if CoreGui:FindFirstChild("ToruMobileBtn") then CoreGui.ToruMobileBtn:Destroy() end

function Library:CreateWindow(panelName, userName)
    local Window = {Tabs = {}, Visible = true}
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Toruz_Final"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.Position = UDim2.new(0.5, -225, 0.5, -125)
    Main.Size = UDim2.new(0, 450, 0, 250)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true 
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 4)

    -- Nút Toggle Mobile (Hiện khi ẩn Menu)
    local MobileGui = Instance.new("ScreenGui", CoreGui)
    MobileGui.Name = "ToruMobileBtn"
    MobileGui.Enabled = false
    
    local ToggleButton = Instance.new("TextButton", MobileGui)
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleButton.Text = "⚔"
    ToggleButton.TextColor3 = Color3.new(1, 1, 1)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 20
    ToggleButton.Draggable = true
    ToggleButton.BorderSizePixel = 0
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

    -- Hàm Đóng/Mở Menu
    local function ToggleMenu()
        Window.Visible = not Window.Visible
        Main.Visible = Window.Visible
        MobileGui.Enabled = not Window.Visible
    end

    ToggleButton.MouseButton1Click:Connect(ToggleMenu)

    -- Nút Power Đỏ (Nhấn vào để ẩn)
    local PowerBtn = Instance.new("TextButton")
    PowerBtn.Size = UDim2.new(0, 30, 0, 30)
    PowerBtn.Position = UDim2.new(0, 5, 0, 5)
    PowerBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    PowerBtn.Text = "X"
    PowerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PowerBtn.TextSize = 18
    PowerBtn.ZIndex = 5
    PowerBtn.Parent = Main
    Instance.new("UICorner", PowerBtn).CornerRadius = UDim.new(0, 4)
    PowerBtn.MouseButton1Click:Connect(ToggleMenu)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 35)
    Title.Position = UDim2.new(0, 40, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = panelName or "Panel Free Fire"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18
    Title.ZIndex = 5
    Title.Parent = Main

    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(0, 100, 0, 40)
    InfoLabel.Position = UDim2.new(0, 5, 0, 40)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = (userName or "User") .. "\nFps: 60.0"
    InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfoLabel.Font = Enum.Font.SourceSans
    InfoLabel.Parent = Main

    RunService.RenderStepped:Connect(function(dt)
        InfoLabel.Text = (userName or "User") .. "\nFps: " .. math.floor(1/dt * 10)/10
    end)

    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(0, 100, 1, -85)
    SideBar.Position = UDim2.new(0, 5, 0, 80)
    SideBar.BackgroundTransparency = 1
    SideBar.Parent = Main
    Instance.new("UIListLayout", SideBar).Padding = UDim.new(0, 3)

    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(0, 330, 1, -45)
    TabContainer.Position = UDim2.new(0, 115, 0, 40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabContainer.BorderColor3 = Color3.fromRGB(60, 60, 60)
    TabContainer.BorderSizePixel = 1
    TabContainer.Parent = Main

    function Window:AddTab(name, icon)
        local TabPage = {}
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, 0, 0, 25)
        TabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        TabBtn.Text = icon .. " " .. name
        TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabBtn.Parent = SideBar
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)

        local Content = Instance.new("ScrollingFrame")
        Content.Size = UDim2.new(1, 0, 1, 0)
        Content.BackgroundTransparency = 1
        Content.Visible = false
        Content.ScrollBarThickness = 2
        Content.Parent = TabContainer
        
        local Layout = Instance.new("UIListLayout", Content)
        Layout.Padding = UDim.new(0, 5)
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Content.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do
                t.Button.TextColor3 = Color3.fromRGB(150, 150, 150)
                t.Content.Visible = false
            end
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Content.Visible = true
        end)

        if #Window.Tabs == 0 then TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255) Content.Visible = true end
        table.insert(Window.Tabs, {Button = TabBtn, Content = Content})

        -- NÚT BẤM (BUTTON)
        function TabPage:AddButton(text, callback)
            local BBtn = Instance.new("TextButton")
            BBtn.Size = UDim2.new(1, -10, 0, 30)
            BBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            BBtn.Text = text
            BBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            BBtn.Font = Enum.Font.SourceSansBold
            BBtn.Parent = Content
            Instance.new("UICorner", BBtn).CornerRadius = UDim.new(0, 4)
            BBtn.MouseButton1Click:Connect(callback)
        end

        -- TOGGLE, SLIDER, DROPDOWN, PARAGRAPH GIỮ NGUYÊN
        function TabPage:AddToggle(text, callback)
            local TFrame = Instance.new("Frame")
            TFrame.Size = UDim2.new(1, -10, 0, 30)
            TFrame.BackgroundTransparency = 1
            TFrame.Parent = Content
            local Box = Instance.new("TextButton")
            Box.Size = UDim2.new(0, 20, 0, 20)
            Box.Position = UDim2.new(0, 10, 0, 5)
            Box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Box.Text = ""
            Box.Parent = TFrame
            Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 3)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -40, 1, 0)
            Label.Position = UDim2.new(0, 40, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = TFrame
            local state = false
            Box.MouseButton1Click:Connect(function()
                state = not state
                Box.BackgroundColor3 = state and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
                Box.Text = state and "✓" or ""
                callback(state)
            end)
        end

        function TabPage:AddSlider(text, min, max, default, callback)
            local SFrame = Instance.new("Frame")
            SFrame.Size = UDim2.new(1, -10, 0, 45)
            SFrame.BackgroundTransparency = 1
            SFrame.Parent = Content
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -20, 0, 20)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text .. " : " .. default
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = SFrame
            local SliderBack = Instance.new("Frame")
            SliderBack.Size = UDim2.new(1, -20, 0, 6)
            SliderBack.Position = UDim2.new(0, 10, 0, 25)
            SliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SliderBack.Parent = SFrame
            Instance.new("UICorner", SliderBack)
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            SliderFill.Parent = SliderBack
            Instance.new("UICorner", SliderFill)
            local dragging = false
            local function move(input)
                local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
                local value = math.floor(pos * (max - min) + min)
                SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                Label.Text = text .. " : " .. value
                callback(value)
            end
            SliderBack.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true move(input) end end)
            UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then move(input) end end)
            UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
        end

        function TabPage:AddDropdown(text, options, callback)
    local selected = nil
    local open = false

    -- Container chính
    local DFrame = Instance.new("Frame")
    DFrame.Size = UDim2.new(1, -10, 0, 32)
    DFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DFrame.ClipsDescendants = true
    DFrame.Parent = Content
    local DCorner = Instance.new("UICorner", DFrame)
    DCorner.CornerRadius = UDim.new(0, 6)
    local DStroke = Instance.new("UIStroke", DFrame)
    DStroke.Color = Color3.fromRGB(70, 70, 70)
    DStroke.Thickness = 1

    -- Header row
    local DBtn = Instance.new("TextButton")
    DBtn.Size = UDim2.new(1, -32, 0, 32)
    DBtn.Position = UDim2.new(0, 10, 0, 0)
    DBtn.BackgroundTransparency = 1
    DBtn.Text = text .. "  :  Chọn..."
    DBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    DBtn.TextXAlignment = Enum.TextXAlignment.Left
    DBtn.Font = Enum.Font.SourceSansSemibold
    DBtn.TextSize = 14
    DBtn.Parent = DFrame

    -- Mũi tên
    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.new(0, 28, 0, 32)
    Arrow.Position = UDim2.new(1, -30, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
    Arrow.TextSize = 12
    Arrow.Parent = DFrame

    -- Build option rows
    local optionFrames = {}
    for i, v in ipairs(options) do
        local Opt = Instance.new("TextButton")
        Opt.Name = "Option_" .. i
        Opt.Size = UDim2.new(1, -2, 0, 28)
        Opt.Position = UDim2.new(0, 1, 0, 32 + (i - 1) * 28)
        Opt.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Opt.BorderSizePixel = 0
        Opt.Text = "  " .. v
        Opt.TextColor3 = Color3.fromRGB(200, 200, 200)
        Opt.TextXAlignment = Enum.TextXAlignment.Left
        Opt.Font = Enum.Font.SourceSans
        Opt.TextSize = 14
        Opt.Parent = DFrame
        Instance.new("UICorner", Opt).CornerRadius = UDim.new(0, 4)

        -- Hover effect
        Opt.MouseEnter:Connect(function()
            if selected ~= v then
                TweenService:Create(Opt, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
            end
        end)
        Opt.MouseLeave:Connect(function()
            if selected ~= v then
                TweenService:Create(Opt, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            end
        end)

        Opt.MouseButton1Click:Connect(function()
            -- Reset màu tất cả option
            for _, f in ipairs(optionFrames) do
                TweenService:Create(f, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                f.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
            -- Highlight option đang chọn
            TweenService:Create(Opt, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(0, 110, 220)}):Play()
            Opt.TextColor3 = Color3.fromRGB(255, 255, 255)
            selected = v
            DBtn.Text = text .. "  :  " .. v
            DBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            callback(v)
            -- Đóng dropdown
            open = false
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            TweenService:Create(DStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(70, 70, 70)}):Play()
            TweenService:Create(DFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, -10, 0, 32)
            }):Play()
        end)

        table.insert(optionFrames, Opt)
    end

    local totalHeight = 32 + #options * 28

    DBtn.MouseButton1Click:Connect(function()
        open = not open
        if open then
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
            TweenService:Create(DStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 110, 220)}):Play()
            TweenService:Create(DFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, -10, 0, totalHeight)
            }):Play()
        else
            TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            TweenService:Create(DStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(70, 70, 70)}):Play()
            TweenService:Create(DFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, -10, 0, 32)
            }):Play()
        end
    end)
end

        function TabPage:AddParagraph(title, text)
            local PFrame = Instance.new("Frame")
            PFrame.Size = UDim2.new(1, -10, 0, 60)
            PFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            PFrame.Parent = Content
            Instance.new("UICorner", PFrame).CornerRadius = UDim.new(0, 4)
            local PTitle = Instance.new("TextLabel")
            PTitle.Size = UDim2.new(1, -10, 0, 20)
            PTitle.Position = UDim2.new(0, 5, 0, 5)
            PTitle.BackgroundTransparency = 1
            PTitle.Text = title
            PTitle.TextColor3 = Color3.fromRGB(0, 120, 255)
            PTitle.Font = Enum.Font.SourceSansBold
            PTitle.Parent = PFrame
            local PText = Instance.new("TextLabel")
            PText.Size = UDim2.new(1, -10, 0, 30)
            PText.Position = UDim2.new(0, 5, 0, 25)
            PText.BackgroundTransparency = 1
            PText.Text = text
            PText.TextColor3 = Color3.fromRGB(200, 200, 200)
            PText.TextWrapped = true
            PText.TextXAlignment = Enum.TextXAlignment.Left
            PText.TextYAlignment = Enum.TextYAlignment.Top
            PText.Parent = PFrame
            PFrame.Size = UDim2.new(1, -10, 0, PText.TextBounds.Y + 35)
        end

        function TabPage:AddLabel(text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = "  > " .. text
    Label.TextColor3 = Color3.fromRGB(180, 180, 180) -- Màu xám nhạt
    Label.Font = Enum.Font.SourceSansItalic
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Content
end

-- TOGGLE CÓ (?) TOOLTIP
function TabPage:AddToggleTip(text, tip, callback)
    local TFrame = Instance.new("Frame")
    TFrame.Size = UDim2.new(1, -10, 0, 30)
    TFrame.BackgroundTransparency = 1
    TFrame.Parent = Content

    local Box = Instance.new("TextButton")
    Box.Size = UDim2.new(0, 20, 0, 20)
    Box.Position = UDim2.new(0, 6, 0.5, -10)
    Box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Box.Text = ""
    Box.Parent = TFrame
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 32, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 14
    Label.Parent = TFrame

    -- Nút (?)
    local QBtn = Instance.new("TextButton")
    QBtn.Size = UDim2.new(0, 22, 0, 22)
    QBtn.Position = UDim2.new(1, -26, 0.5, -11)
    QBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    QBtn.Text = "(?)"
    QBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    QBtn.Font = Enum.Font.SourceSansBold
    QBtn.TextSize = 13
    QBtn.Parent = TFrame
    Instance.new("UICorner", QBtn).CornerRadius = UDim.new(1, 0)

    -- Tooltip box (ẩn mặc định)
    local Tooltip = Instance.new("Frame")
    Tooltip.Size = UDim2.new(1, -10, 0, 0)
    Tooltip.Position = UDim2.new(0, 5, 1, 2)
    Tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Tooltip.ClipsDescendants = true
    Tooltip.ZIndex = 20
    Tooltip.Visible = false
    Tooltip.Parent = TFrame
    Instance.new("UICorner", Tooltip).CornerRadius = UDim.new(0, 5)
    local TipStroke = Instance.new("UIStroke", Tooltip)
    TipStroke.Color = Color3.fromRGB(0, 110, 220)
    TipStroke.Thickness = 1

    local TipText = Instance.new("TextLabel")
    TipText.Size = UDim2.new(1, -10, 1, -8)
    TipText.Position = UDim2.new(0, 5, 0, 4)
    TipText.BackgroundTransparency = 1
    TipText.Text = tip
    TipText.TextColor3 = Color3.fromRGB(180, 180, 180)
    TipText.TextWrapped = true
    TipText.TextXAlignment = Enum.TextXAlignment.Left
    TipText.TextYAlignment = Enum.TextYAlignment.Top
    TipText.Font = Enum.Font.SourceSansItalic
    TipText.TextSize = 13
    TipText.ZIndex = 21
    TipText.Parent = Tooltip

    local tipOpen = false
    QBtn.MouseButton1Click:Connect(function()
        tipOpen = not tipOpen
        if tipOpen then
            local h = TipText.TextBounds.Y + 16
            Tooltip.Visible = true
            Tooltip.Size = UDim2.new(1, -10, 0, 0)
            TFrame.Size = UDim2.new(1, -10, 0, 30 + h)
            TweenService:Create(Tooltip, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, h)}):Play()
            QBtn.TextColor3 = Color3.fromRGB(0, 150, 255)
        else
            TFrame.Size = UDim2.new(1, -10, 0, 30)
            TweenService:Create(Tooltip, TweenInfo.new(0.15), {Size = UDim2.new(1, -10, 0, 0)}):Play()
            task.delay(0.15, function() Tooltip.Visible = false end)
            QBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end)

    local state = false
    Box.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Box, TweenInfo.new(0.15), {
            BackgroundColor3 = state and Color3.fromRGB(0, 110, 220) or Color3.fromRGB(60, 60, 60)
        }):Play()
        Box.Text = state and "✓" or ""
        Box.TextColor3 = Color3.fromRGB(255, 255, 255)
        Box.TextSize = 11
        callback(state)
    end)
end

-- 1. Nút Copy (Dùng để Copy Discord/Link)
function TabPage:AddCopyButton(text, contentToCopy)
    local CBtn = Instance.new("TextButton")
    CBtn.Size = UDim2.new(1, -10, 0, 30)
    CBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100) -- Màu xanh lá cho nổi bật
    CBtn.Text = "📋 " .. text
    CBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CBtn.Font = Enum.Font.SourceSansBold
    CBtn.Parent = Content
    Instance.new("UICorner", CBtn).CornerRadius = UDim.new(0, 4)
    
    CBtn.MouseButton1Click:Connect(function()
        setclipboard(contentToCopy) -- Hàm copy vào máy
        CBtn.Text = "✅ Đã Copy!"
        task.wait(2)
        CBtn.Text = "📋 " .. text
    end)
end

        return TabPage
    end

    return Window
end

return Library
