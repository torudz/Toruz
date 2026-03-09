local Library = {}
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("Toruz_Final") then CoreGui.Toruz_Final:Destroy() end
if CoreGui:FindFirstChild("ToruMobileBtn") then CoreGui.ToruMobileBtn:Destroy() end

local function AddStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(70, 70, 70)
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function Tween(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.25, Enum.EasingStyle.Quad), props):Play()
end

function Library:CreateWindow(panelName, userName)
    local Window = {Tabs = {}, Visible = true}

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Toruz_Final"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Main.Position = UDim2.new(0.5, -225, 0.5, -130)
    Main.Size = UDim2.new(0, 450, 0, 260)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.BackgroundTransparency = 0
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
    AddStroke(Main, Color3.fromRGB(55, 55, 70), 1.5)

    -- Gradient accent bar ở đỉnh header
    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(1, 0, 0, 3)
    AccentBar.Position = UDim2.new(0, 0, 0, 0)
    AccentBar.BorderSizePixel = 0
    AccentBar.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    AccentBar.ZIndex = 10
    AccentBar.Parent = Main
    local AccentGrad = Instance.new("UIGradient")
    AccentGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255)),
    })
    AccentGrad.Parent = AccentBar
    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 6)
    AccentCorner.Parent = AccentBar

    -- Animate gradient
    RunService.RenderStepped:Connect(function(dt)
        AccentGrad.Offset = Vector2.new(math.sin(tick() * 0.5) * 0.3, 0)
    end)

    -- Header background
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 38)
    Header.Position = UDim2.new(0, 0, 0, 3)
    Header.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    Header.BorderSizePixel = 0
    Header.ZIndex = 4
    Header.Parent = Main

    -- Mobile toggle button
    local MobileGui = Instance.new("ScreenGui", CoreGui)
    MobileGui.Name = "ToruMobileBtn"
    MobileGui.Enabled = false

    local ToggleButton = Instance.new("TextButton", MobileGui)
    ToggleButton.Size = UDim2.new(0, 48, 0, 48)
    ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    ToggleButton.Text = "⚔"
    ToggleButton.TextColor3 = Color3.new(1, 1, 1)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 20
    ToggleButton.Draggable = true
    ToggleButton.BorderSizePixel = 0
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)
    AddStroke(ToggleButton, Color3.fromRGB(0, 120, 255), 1.5)

    -- Toggle fade animation
    local function ToggleMenu()
        Window.Visible = not Window.Visible
        if Window.Visible then
            Main.Visible = true
            Main.BackgroundTransparency = 1
            Tween(Main, {BackgroundTransparency = 0}, 0.2)
            MobileGui.Enabled = false
        else
            Tween(Main, {BackgroundTransparency = 1}, 0.2)
            task.delay(0.22, function()
                Main.Visible = false
                MobileGui.Enabled = true
            end)
        end
    end

    ToggleButton.MouseButton1Click:Connect(ToggleMenu)

    -- Power button
    local PowerBtn = Instance.new("TextButton")
    PowerBtn.Size = UDim2.new(0, 28, 0, 28)
    PowerBtn.Position = UDim2.new(0, 6, 0, 8)
    PowerBtn.BackgroundColor3 = Color3.fromRGB(180, 35, 35)
    PowerBtn.Text = "⏻"
    PowerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PowerBtn.TextSize = 15
    PowerBtn.Font = Enum.Font.GothamBold
    PowerBtn.ZIndex = 5
    PowerBtn.Parent = Header
    Instance.new("UICorner", PowerBtn).CornerRadius = UDim.new(0, 5)
    AddStroke(PowerBtn, Color3.fromRGB(220, 60, 60), 1)
    PowerBtn.MouseButton1Click:Connect(ToggleMenu)

    -- Hover effect trên PowerBtn
    PowerBtn.MouseEnter:Connect(function() Tween(PowerBtn, {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}) end)
    PowerBtn.MouseLeave:Connect(function() Tween(PowerBtn, {BackgroundColor3 = Color3.fromRGB(180, 35, 35)}) end)

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -130, 1, 0)
    Title.Position = UDim2.new(0, 44, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = panelName or "Toruz Panel"
    Title.TextColor3 = Color3.fromRGB(240, 240, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 5
    Title.Parent = Header

    -- Username label
    local UserLabel = Instance.new("TextLabel")
    UserLabel.Size = UDim2.new(0, 110, 0, 18)
    UserLabel.Position = UDim2.new(1, -118, 0, 5)
    UserLabel.BackgroundTransparency = 1
    UserLabel.Text = "👤 " .. (userName or "User")
    UserLabel.TextColor3 = Color3.fromRGB(160, 160, 200)
    UserLabel.Font = Enum.Font.Gotham
    UserLabel.TextSize = 12
    UserLabel.TextXAlignment = Enum.TextXAlignment.Right
    UserLabel.ZIndex = 5
    UserLabel.Parent = Header

    -- FPS label (terpisah)
    local FpsLabel = Instance.new("TextLabel")
    FpsLabel.Size = UDim2.new(0, 110, 0, 16)
    FpsLabel.Position = UDim2.new(1, -118, 0, 20)
    FpsLabel.BackgroundTransparency = 1
    FpsLabel.Text = "FPS: 60.0"
    FpsLabel.TextColor3 = Color3.fromRGB(0, 200, 120)
    FpsLabel.Font = Enum.Font.Gotham
    FpsLabel.TextSize = 11
    FpsLabel.TextXAlignment = Enum.TextXAlignment.Right
    FpsLabel.ZIndex = 5
    FpsLabel.Parent = Header

    RunService.RenderStepped:Connect(function(dt)
        local fps = math.floor(1 / dt * 10) / 10
        FpsLabel.Text = "FPS: " .. fps
        -- Đổi màu theo FPS
        if fps >= 50 then
            FpsLabel.TextColor3 = Color3.fromRGB(0, 200, 120)
        elseif fps >= 30 then
            FpsLabel.TextColor3 = Color3.fromRGB(255, 180, 0)
        else
            FpsLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        end
    end)

    -- Sidebar
    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(0, 100, 1, -50)
    SideBar.Position = UDim2.new(0, 5, 0, 46)
    SideBar.BackgroundTransparency = 1
    SideBar.Parent = Main
    local SideLayout = Instance.new("UIListLayout", SideBar)
    SideLayout.Padding = UDim.new(0, 4)

    -- Divider antara sidebar dan content
    local Divider = Instance.new("Frame")
    Divider.Size = UDim2.new(0, 1, 1, -50)
    Divider.Position = UDim2.new(0, 108, 0, 46)
    Divider.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
    Divider.BorderSizePixel = 0
    Divider.Parent = Main

    -- Tab container
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(0, 328, 1, -50)
    TabContainer.Position = UDim2.new(0, 114, 0, 46)
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = Main

    function Window:AddTab(name, icon)
        local TabPage = {}

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, 0, 0, 28)
        TabBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
        TabBtn.Text = (icon or "") .. " " .. name
        TabBtn.TextColor3 = Color3.fromRGB(120, 120, 150)
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 13
        TabBtn.Parent = SideBar
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 5)
        AddStroke(TabBtn, Color3.fromRGB(50, 50, 65), 1)

        local Content = Instance.new("ScrollingFrame")
        Content.Size = UDim2.new(1, 0, 1, 0)
        Content.BackgroundTransparency = 1
        Content.Visible = false
        Content.ScrollBarThickness = 2
        Content.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 255)
        Content.BorderSizePixel = 0
        Content.Parent = TabContainer

        local Layout = Instance.new("UIListLayout", Content)
        Layout.Padding = UDim.new(0, 5)
        local Pad = Instance.new("UIPadding", Content)
        Pad.PaddingTop = UDim.new(0, 5)
        Pad.PaddingLeft = UDim.new(0, 5)
        Pad.PaddingRight = UDim.new(0, 5)

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Content.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 15)
        end)

        local function SetActive(active)
            if active then
                Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(0, 90, 200)})
                TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                AddStroke(TabBtn, Color3.fromRGB(0, 140, 255), 1)
                Content.Visible = true
            else
                Tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(32, 32, 42)})
                TabBtn.TextColor3 = Color3.fromRGB(120, 120, 150)
                AddStroke(TabBtn, Color3.fromRGB(50, 50, 65), 1)
                Content.Visible = false
            end
        end

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do t.SetActive(false) end
            SetActive(true)
        end)

        if #Window.Tabs == 0 then SetActive(true) end
        table.insert(Window.Tabs, {Button = TabBtn, Content = Content, SetActive = SetActive})

        -- BUTTON
        function TabPage:AddButton(text, callback)
            local BBtn = Instance.new("TextButton")
            BBtn.Size = UDim2.new(1, 0, 0, 30)
            BBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
            BBtn.Text = text
            BBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
            BBtn.Font = Enum.Font.GothamBold
            BBtn.TextSize = 13
            BBtn.Parent = Content
            Instance.new("UICorner", BBtn).CornerRadius = UDim.new(0, 5)
            AddStroke(BBtn, Color3.fromRGB(60, 60, 80), 1)

            BBtn.MouseEnter:Connect(function() Tween(BBtn, {BackgroundColor3 = Color3.fromRGB(0, 90, 200)}) end)
            BBtn.MouseLeave:Connect(function() Tween(BBtn, {BackgroundColor3 = Color3.fromRGB(38, 38, 52)}) end)
            BBtn.MouseButton1Click:Connect(function()
                Tween(BBtn, {BackgroundColor3 = Color3.fromRGB(0, 60, 150)}, 0.1)
                task.delay(0.15, function() Tween(BBtn, {BackgroundColor3 = Color3.fromRGB(0, 90, 200)}, 0.1) end)
                callback()
            end)
        end

        -- TOGGLE
        function TabPage:AddToggle(text, callback)
            local TFrame = Instance.new("Frame")
            TFrame.Size = UDim2.new(1, 0, 0, 30)
            TFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
            TFrame.Parent = Content
            Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 5)
            AddStroke(TFrame, Color3.fromRGB(60, 60, 80), 1)

            -- Toggle switch background
            local SwitchBg = Instance.new("Frame")
            SwitchBg.Size = UDim2.new(0, 36, 0, 18)
            SwitchBg.Position = UDim2.new(1, -44, 0.5, -9)
            SwitchBg.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
            SwitchBg.Parent = TFrame
            Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

            -- Toggle knob
            local Knob = Instance.new("Frame")
            Knob.Size = UDim2.new(0, 14, 0, 14)
            Knob.Position = UDim2.new(0, 2, 0.5, -7)
            Knob.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
            Knob.Parent = SwitchBg
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -55, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.fromRGB(210, 210, 230)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = TFrame

            local state = false
            local HitBox = Instance.new("TextButton")
            HitBox.Size = UDim2.new(1, 0, 1, 0)
            HitBox.BackgroundTransparency = 1
            HitBox.Text = ""
            HitBox.Parent = TFrame

            HitBox.MouseButton1Click:Connect(function()
                state = not state
                if state then
                    Tween(SwitchBg, {BackgroundColor3 = Color3.fromRGB(0, 120, 255)})
                    Tween(Knob, {Position = UDim2.new(1, -16, 0.5, -7), BackgroundColor3 = Color3.fromRGB(255, 255, 255)})
                else
                    Tween(SwitchBg, {BackgroundColor3 = Color3.fromRGB(55, 55, 70)})
                    Tween(Knob, {Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(180, 180, 200)})
                end
                callback(state)
            end)
        end

        -- SLIDER
        function TabPage:AddSlider(text, min, max, default, callback)
            local SFrame = Instance.new("Frame")
            SFrame.Size = UDim2.new(1, 0, 0, 48)
            SFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
            SFrame.Parent = Content
            Instance.new("UICorner", SFrame).CornerRadius = UDim.new(0, 5)
            AddStroke(SFrame, Color3.fromRGB(60, 60, 80), 1)

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -10, 0, 22)
            Label.Position = UDim2.new(0, 10, 0, 4)
            Label.BackgroundTransparency = 1
            Label.Text = text .. "  |  " .. default
            Label.TextColor3 = Color3.fromRGB(210, 210, 230)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = SFrame

            local SliderTrack = Instance.new("Frame")
            SliderTrack.Size = UDim2.new(1, -20, 0, 5)
            SliderTrack.Position = UDim2.new(0, 10, 1, -14)
            SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
            SliderTrack.Parent = SFrame
            Instance.new("UICorner", SliderTrack).CornerRadius = UDim.new(1, 0)

            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            SliderFill.Parent = SliderTrack
            Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

            -- Knob titik
            local SKnob = Instance.new("Frame")
            SKnob.Size = UDim2.new(0, 11, 0, 11)
            SKnob.AnchorPoint = Vector2.new(0.5, 0.5)
            SKnob.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
            SKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SKnob.ZIndex = 2
            SKnob.Parent = SliderTrack
            Instance.new("UICorner", SKnob).CornerRadius = UDim.new(1, 0)

            local dragging = false
            local function move(input)
                local pos = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                local value = math.floor(pos * (max - min) + min)
                SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                SKnob.Position = UDim2.new(pos, 0, 0.5, 0)
                Label.Text = text .. "  |  " .. value
                callback(value)
            end
            SliderTrack.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true move(i) end end)
            UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then move(i) end end)
            UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
        end

        -- DROPDOWN
        function TabPage:AddDropdown(text, options, callback)
            local DFrame = Instance.new("Frame")
            DFrame.Size = UDim2.new(1, 0, 0, 30)
            DFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
            DFrame.ClipsDescendants = true
            DFrame.Parent = Content
            Instance.new("UICorner", DFrame).CornerRadius = UDim.new(0, 5)
            AddStroke(DFrame, Color3.fromRGB(60, 60, 80), 1)

            local DBtn = Instance.new("TextButton")
            DBtn.Size = UDim2.new(1, 0, 0, 30)
            DBtn.BackgroundTransparency = 1
            DBtn.Text = "  ▾  " .. text .. " : Chọn..."
            DBtn.TextColor3 = Color3.fromRGB(210, 210, 230)
            DBtn.Font = Enum.Font.Gotham
            DBtn.TextSize = 13
            DBtn.TextXAlignment = Enum.TextXAlignment.Left
            DBtn.Parent = DFrame

            local open = false
            DBtn.MouseButton1Click:Connect(function()
                open = not open
                local targetH = open and (30 + #options * 26) or 30
                Tween(DFrame, {Size = UDim2.new(1, 0, 0, targetH)}, 0.25)
                DBtn.Text = (open and "  ▴  " or "  ▾  ") .. text .. " : " .. (DBtn.Text:match(": (.+)$") or "Chọn...")
                if open then
                    for i, v in pairs(options) do
                        local Opt = Instance.new("TextButton")
                        Opt.Name = "Option"
                        Opt.Size = UDim2.new(1, 0, 0, 26)
                        Opt.Position = UDim2.new(0, 0, 0, 30 + (i-1)*26)
                        Opt.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
                        Opt.BorderSizePixel = 0
                        Opt.Text = "  " .. v
                        Opt.Font = Enum.Font.Gotham
                        Opt.TextSize = 12
                        Opt.TextColor3 = Color3.fromRGB(190, 190, 220)
                        Opt.TextXAlignment = Enum.TextXAlignment.Left
                        Opt.Parent = DFrame
                        Opt.MouseEnter:Connect(function() Tween(Opt, {BackgroundColor3 = Color3.fromRGB(0, 90, 200)}) end)
                        Opt.MouseLeave:Connect(function() Tween(Opt, {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}) end)
                        Opt.MouseButton1Click:Connect(function()
                            DBtn.Text = "  ▾  " .. text .. " : " .. v
                            callback(v)
                            open = false
                            Tween(DFrame, {Size = UDim2.new(1, 0, 0, 30)}, 0.2)
                            for _, obj in pairs(DFrame:GetChildren()) do if obj.Name == "Option" then obj:Destroy() end end
                        end)
                    end
                else
                    for _, obj in pairs(DFrame:GetChildren()) do if obj.Name == "Option" then obj:Destroy() end end
                end
            end)
        end

        -- PARAGRAPH
        function TabPage:AddParagraph(title, text)
            local PFrame = Instance.new("Frame")
            PFrame.Size = UDim2.new(1, 0, 0, 60)
            PFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
            PFrame.Parent = Content
            Instance.new("UICorner", PFrame).CornerRadius = UDim.new(0, 5)
            AddStroke(PFrame, Color3.fromRGB(0, 80, 180), 1)

            local AccentLine = Instance.new("Frame")
            AccentLine.Size = UDim2.new(0, 3, 1, -10)
            AccentLine.Position = UDim2.new(0, 0, 0, 5)
            AccentLine.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            AccentLine.BorderSizePixel = 0
            AccentLine.Parent = PFrame
            Instance.new("UICorner", AccentLine).CornerRadius = UDim.new(1, 0)

            local PTitle = Instance.new("TextLabel")
            PTitle.Size = UDim2.new(1, -18, 0, 20)
            PTitle.Position = UDim2.new(0, 12, 0, 5)
            PTitle.BackgroundTransparency = 1
            PTitle.Text = title
            PTitle.TextColor3 = Color3.fromRGB(100, 170, 255)
            PTitle.Font = Enum.Font.GothamBold
            PTitle.TextSize = 13
            PTitle.TextXAlignment = Enum.TextXAlignment.Left
            PTitle.Parent = PFrame

            local PText = Instance.new("TextLabel")
            PText.Size = UDim2.new(1, -18, 0, 30)
            PText.Position = UDim2.new(0, 12, 0, 26)
            PText.BackgroundTransparency = 1
            PText.Text = text
            PText.TextColor3 = Color3.fromRGB(180, 180, 210)
            PText.Font = Enum.Font.Gotham
            PText.TextSize = 12
            PText.TextWrapped = true
            PText.TextXAlignment = Enum.TextXAlignment.Left
            PText.TextYAlignment = Enum.TextYAlignment.Top
            PText.Parent = PFrame

            -- Fix timing TextBounds
            task.defer(function()
                PFrame.Size = UDim2.new(1, 0, 0, PText.TextBounds.Y + 36)
            end)
        end

        -- LABEL
        function TabPage:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.BackgroundTransparency = 1
            Label.Text = "  › " .. text
            Label.TextColor3 = Color3.fromRGB(150, 150, 180)
            Label.Font = Enum.Font.GothamSemiboldItalic
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Content
        end

        -- COPY BUTTON
        function TabPage:AddCopyButton(text, contentToCopy)
            local CBtn = Instance.new("TextButton")
            CBtn.Size = UDim2.new(1, 0, 0, 30)
            CBtn.BackgroundColor3 = Color3.fromRGB(0, 110, 80)
            CBtn.Text = "📋  " .. text
            CBtn.TextColor3 = Color3.fromRGB(200, 255, 230)
            CBtn.Font = Enum.Font.GothamBold
            CBtn.TextSize = 13
            CBtn.Parent = Content
            Instance.new("UICorner", CBtn).CornerRadius = UDim.new(0, 5)
            AddStroke(CBtn, Color3.fromRGB(0, 160, 110), 1)

            CBtn.MouseEnter:Connect(function() Tween(CBtn, {BackgroundColor3 = Color3.fromRGB(0, 140, 100)}) end)
            CBtn.MouseLeave:Connect(function() Tween(CBtn, {BackgroundColor3 = Color3.fromRGB(0, 110, 80)}) end)
            CBtn.MouseButton1Click:Connect(function()
                setclipboard(contentToCopy)
                local orig = CBtn.Text
                CBtn.Text = "✅  Đã Copy!"
                Tween(CBtn, {BackgroundColor3 = Color3.fromRGB(0, 170, 100)})
                task.wait(2)
                CBtn.Text = orig
                Tween(CBtn, {BackgroundColor3 = Color3.fromRGB(0, 110, 80)})
            end)
        end

        return TabPage
    end

    return Window
end

return Library
