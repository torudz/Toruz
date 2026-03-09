local Library = {}
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("Toruz_Final") then
    CoreGui.Toruz_Final:Destroy()
end

function Library:CreateWindow(panelName, userName)
    local Window = {Tabs = {}}
    
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

    local PowerBtn = Instance.new("TextButton")
    PowerBtn.Size = UDim2.new(0, 30, 0, 30)
    PowerBtn.Position = UDim2.new(0, 5, 0, 5)
    PowerBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    PowerBtn.Text = "⏻"
    PowerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PowerBtn.TextSize = 18
    PowerBtn.ZIndex = 5
    PowerBtn.Parent = Main
    Instance.new("UICorner", PowerBtn).CornerRadius = UDim.new(0, 4)
    PowerBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 35)
    Title.Position = UDim2.new(0, 40, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = panelName or "Panel Free Fire 1.121.1"
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
    InfoLabel.TextSize = 15
    InfoLabel.ZIndex = 5
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
    TabContainer.Name = "TabContainer"
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
        TabBtn.Font = Enum.Font.SourceSans
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

        if #Window.Tabs == 0 then
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Content.Visible = true
        end
        table.insert(Window.Tabs, {Button = TabBtn, Content = Content})

        -- TOGGLE
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
            Label.Font = Enum.Font.SourceSans
            Label.Parent = TFrame
            local state = false
            Box.MouseButton1Click:Connect(function()
                state = not state
                Box.BackgroundColor3 = state and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
                Box.Text = state and "✓" or ""
                callback(state)
            end)
        end

        -- SLIDER
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
            Label.Font = Enum.Font.SourceSans
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
            SliderBack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    move(input)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    move(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
        end

        -- DROPDOWN
        function TabPage:AddDropdown(text, options, callback)
            local DFrame = Instance.new("Frame")
            DFrame.Size = UDim2.new(1, -10, 0, 30)
            DFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            DFrame.ClipsDescendants = true
            DFrame.Parent = Content
            Instance.new("UICorner", DFrame).CornerRadius = UDim.new(0, 4)
            local DBtn = Instance.new("TextButton")
            DBtn.Size = UDim2.new(1, 0, 0, 30)
            DBtn.BackgroundTransparency = 1
            DBtn.Text = "  " .. text .. " : Chọn..."
            DBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            DBtn.TextXAlignment = Enum.TextXAlignment.Left
            DBtn.Font = Enum.Font.SourceSans
            DBtn.Parent = DFrame
            local open = false
            DBtn.MouseButton1Click:Connect(function()
                open = not open
                TweenService:Create(DFrame, TweenInfo.new(0.3), {Size = open and UDim2.new(1, -10, 0, 30 + (#options * 25)) or UDim2.new(1, -10, 0, 30)}):Play()
                if open then
                    for i, v in pairs(options) do
                        local Opt = Instance.new("TextButton")
                        Opt.Name = "Option"
                        Opt.Size = UDim2.new(1, 0, 0, 25)
                        Opt.Position = UDim2.new(0, 0, 0, 30 + (i-1)*25)
                        Opt.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                        Opt.BorderSizePixel = 0
                        Opt.Text = v
                        Opt.TextColor3 = Color3.fromRGB(200, 200, 200)
                        Opt.Parent = DFrame
                        Opt.MouseButton1Click:Connect(function()
                            DBtn.Text = "  " .. text .. " : " .. v
                            callback(v)
                            open = false
                            TweenService:Create(DFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -10, 0, 30)}):Play()
                            for _, obj in pairs(DFrame:GetChildren()) do if obj.Name == "Option" then obj:Destroy() end end
                        end)
                    end
                else
                    for _, obj in pairs(DFrame:GetChildren()) do if obj.Name == "Option" then obj:Destroy() end end
                end
            end)
        end

        -- PARAGRAPH (MỚI)
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
            PTitle.TextSize = 14
            PTitle.TextXAlignment = Enum.TextXAlignment.Left
            PTitle.Parent = PFrame

            local PText = Instance.new("TextLabel")
            PText.Size = UDim2.new(1, -10, 0, 30)
            PText.Position = UDim2.new(0, 5, 0, 25)
            PText.BackgroundTransparency = 1
            PText.Text = text
            PText.TextColor3 = Color3.fromRGB(200, 200, 200)
            PText.Font = Enum.Font.SourceSans
            PText.TextSize = 13
            PText.TextWrapped = true
            PText.TextXAlignment = Enum.TextXAlignment.Left
            PText.TextYAlignment = Enum.TextYAlignment.Top
            PText.Parent = PFrame
            
            -- Tự động chỉnh độ cao Paragraph theo nội dung chữ
            PFrame.Size = UDim2.new(1, -10, 0, PText.TextBounds.Y + 35)
        end

        return TabPage
    end

    return Window
end

return Library
