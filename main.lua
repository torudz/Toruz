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

    -- NÚT POWER ĐỎ
    local PowerBtn = Instance.new("TextButton")
    PowerBtn.Size = UDim2.new(0, 30, 0, 30)
    PowerBtn.Position = UDim2.new(0, 5, 0, 5)
    PowerBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    PowerBtn.Text = "⏻"
    PowerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PowerBtn.TextSize = 18
    PowerBtn.Parent = Main
    PowerBtn.ZIndex = 5
    Instance.new("UICorner", PowerBtn).CornerRadius = UDim.new(0, 4)
    PowerBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- TÊN PANEL (ĐÃ SỬA VỊ TRÍ)
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

    -- INFO USER & FPS
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

    -- SIDEBAR
    local SideBar = Instance.new("Frame")
    SideBar.Size = UDim2.new(0, 100, 1, -85)
    SideBar.Position = UDim2.new(0, 5, 0, 80)
    SideBar.BackgroundTransparency = 1
    SideBar.Parent = Main
    Instance.new("UIListLayout", SideBar).Padding = UDim.new(0, 3)

    -- KHUNG CHỨA NỘI DUNG (ĐÃ CHỈNH LẠI VỊ TRÍ ĐỂ KHÔNG ĐÈ TÊN)
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
        Layout.Padding = UDim.new(0, 2)
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

        function TabPage:AddToggle(text, callback)
            local TFrame = Instance.new("Frame")
            TFrame.Size = UDim2.new(1, 0, 0, 30)
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
            SFrame.Size = UDim2.new(1, 0, 0, 45)
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

        return TabPage
    end

    return Window
end

return Library
