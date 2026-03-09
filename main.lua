local Library = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("GeminiLib_UI") then
    CoreGui.GeminiLib_UI:Destroy()
end

function Library:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GeminiLib_UI"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Active = true
    MainFrame.Draggable = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    -- Sidebar & Container (Giống bản trước)
    local SideBar = Instance.new("Frame")
    SideBar.Name = "SideBar"
    SideBar.Parent = MainFrame
    SideBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SideBar.Size = UDim2.new(0, 100, 1, 0)
    Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 10)

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
    
    -- Cập nhật CanvasSize mỗi khi thêm item
    ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 20)
    end)

    -- [HÀM MỚI: PARAGRAPH]
    function Library:AddParagraph(title, content)
        local PFrame = Instance.new("Frame")
        PFrame.Size = UDim2.new(1, -10, 0, 50)
        PFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        PFrame.Parent = Container
        Instance.new("UICorner", PFrame).CornerRadius = UDim.new(0, 6)

        local PTitle = Instance.new("TextLabel")
        PTitle.Text = title
        PTitle.Size = UDim2.new(1, -10, 0, 20)
        PTitle.Position = UDim2.new(0, 10, 0, 5)
        PTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        PTitle.Font = Enum.Font.GothamBold
        PTitle.BackgroundTransparency = 1
        PTitle.TextXAlignment = Enum.TextXAlignment.Left
        PTitle.Parent = PFrame

        local PDesc = Instance.new("TextLabel")
        PDesc.Text = content
        PDesc.Size = UDim2.new(1, -10, 0, 20)
        PDesc.Position = UDim2.new(0, 10, 0, 25)
        PDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
        PDesc.Font = Enum.Font.Gotham
        PDesc.TextWrapped = true
        PDesc.BackgroundTransparency = 1
        PDesc.TextXAlignment = Enum.TextXAlignment.Left
        PDesc.Parent = PFrame
    end

    -- [HÀM MỚI: DROPDOWN]
    function Library:AddDropdown(text, list, callback)
        local DFrame = Instance.new("Frame")
        DFrame.Size = UDim2.new(1, -10, 0, 35)
        DFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        DFrame.Parent = Container
        Instance.new("UICorner", DFrame).CornerRadius = UDim.new(0, 6)

        local DBtn = Instance.new("TextButton")
        DBtn.Size = UDim2.new(1, 0, 1, 0)
        DBtn.BackgroundTransparency = 1
        DBtn.Text = text .. " : Select"
        DBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DBtn.Font = Enum.Font.Gotham
        DBtn.Parent = DFrame

        local isOpening = false
        DBtn.MouseButton1Click:Connect(function()
            isOpening = not isOpening
            if isOpening then
                DFrame.Size = UDim2.new(1, -10, 0, 35 + (#list * 30))
                for i, val in ipairs(list) do
                    local Opt = Instance.new("TextButton")
                    Opt.Name = "Option"
                    Opt.Size = UDim2.new(1, 0, 0, 30)
                    Opt.Position = UDim2.new(0, 0, 0, 35 + (i-1)*30)
                    Opt.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Opt.Text = tostring(val)
                    Opt.TextColor3 = Color3.fromRGB(200, 200, 200)
                    Opt.Parent = DFrame
                    
                    Opt.MouseButton1Click:Connect(function()
                        DBtn.Text = text .. " : " .. tostring(val)
                        callback(val)
                        isOpening = false
                        DFrame.Size = UDim2.new(1, -10, 0, 35)
                        for _, v in pairs(DFrame:GetChildren()) do if v.Name == "Option" then v:Destroy() end end
                    end)
                end
            else
                DFrame.Size = UDim2.new(1, -10, 0, 35)
                for _, v in pairs(DFrame:GetChildren()) do if v.Name == "Option" then v:Destroy() end end
            end
        end)
    end

    -- (Hàm AddToggle và AddTab giữ nguyên như bản cũ)
    return Library
end

return Library
