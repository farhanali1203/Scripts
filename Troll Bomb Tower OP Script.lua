--[[
    Source Leaked 
    hahaa
--]]

-- ============ VARIABLES ============
local player = game.Players.LocalPlayer
local trollPartsSpamEnabled = false
local trollSpamThread = nil
local uiVisible = true
local gui = nil
local miniGui = nil

local targetNames = {
    ["순간이동 문"] = true,
    ["Toilet"] = true,
    ["BlackBridge"] = true,
    ["Model"] = true,
    ["Button"] = true,
    ["TrollButton"] = true,
    ["사라지는 파트"] = true,
    ["Gudock2"] = true,
}

-- ============ TROLL SPAM FUNCTION ============
local function instantSpam(part)
    if part and part:IsA("BasePart") then
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if rootPart then
            local originalCFrame = rootPart.CFrame
            rootPart.CFrame = part.CFrame
            
            firetouchinterest(rootPart, part, 0)
            firetouchinterest(rootPart, part, 1)
            
            local cd = part:FindFirstChildOfClass("ClickDetector") or part.Parent:FindFirstChildOfClass("ClickDetector")
            if cd then
                fireclickdetector(cd)
            end
            
            rootPart.CFrame = originalCFrame
        end
    end
end

local function startTrollPartsSpam()
    trollPartsSpamEnabled = true
    trollSpamThread = task.spawn(function()
        while trollPartsSpamEnabled do
            local descendants = workspace:GetDescendants()
            
            for i = 1, #descendants do
                local obj = descendants[i]
                local name = obj.Name
                
                if targetNames[name] then
                    if obj:IsA("BasePart") then
                        instantSpam(obj)
                    else
                        local children = obj:GetChildren()
                        for j = 1, #children do
                            if children[j]:IsA("BasePart") then
                                instantSpam(children[j])
                            end
                        end
                    end
                end
            end
            
            task.wait()
        end
    end)
end

local function stopTrollPartsSpam()
    trollPartsSpamEnabled = false
    if trollSpamThread then
        coroutine.close(trollSpamThread)
        trollSpamThread = nil
    end
end

-- ============ NEW MODERN UI ============
local function createMiniUI()
    local miniScreenGui = Instance.new("ScreenGui")
    miniScreenGui.Name = "MiniUI"
    miniScreenGui.ResetOnSpawn = false
    miniScreenGui.Parent = player.PlayerGui
    
    local miniFrame = Instance.new("Frame")
    miniFrame.Name = "MiniFrame"
    miniFrame.Size = UDim2.new(0, 55, 0, 55)
    miniFrame.Position = UDim2.new(0.02, 0, 0.5, -27)
    miniFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    miniFrame.BackgroundTransparency = 0.1
    miniFrame.BorderSizePixel = 0
    miniFrame.ClipsDescendants = true
    miniFrame.Visible = false
    miniFrame.Parent = miniScreenGui
    
    local miniCorner = Instance.new("UICorner")
    miniCorner.CornerRadius = UDim.new(1, 0)
    miniCorner.Parent = miniFrame
    
    local miniGlow = Instance.new("Frame")
    miniGlow.Name = "MiniGlow"
    miniGlow.Size = UDim2.new(1, 0, 1, 0)
    miniGlow.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    miniGlow.BackgroundTransparency = 0.2
    miniGlow.BorderSizePixel = 0
    miniGlow.Parent = miniFrame
    
    local miniGlowCorner = Instance.new("UICorner")
    miniGlowCorner.CornerRadius = UDim.new(1, 0)
    miniGlowCorner.Parent = miniGlow
    
    local openBtn = Instance.new("TextButton")
    openBtn.Name = "OpenBtn"
    openBtn.Size = UDim2.new(1, 0, 1, 0)
    openBtn.BackgroundTransparency = 1
    openBtn.Text = "T"
    openBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    openBtn.TextSize = 28
    openBtn.Font = Enum.Font.GothamBold
    openBtn.Parent = miniFrame
    
    openBtn.MouseButton1Click:Connect(function()
        if gui then
            gui.MainFrame.Visible = true
            miniFrame.Visible = false
            uiVisible = true
        end
    end)
    
    local draggingMini = false
    local dragStartMini = nil
    local startPosMini = nil
    
    miniFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingMini = true
            dragStartMini = input.Position
            startPosMini = miniFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingMini = false
                end
            end)
        end
    end)
    
    miniFrame.InputChanged:Connect(function(input)
        if draggingMini and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStartMini
            miniFrame.Position = UDim2.new(
                startPosMini.X.Scale,
                startPosMini.X.Offset + delta.X,
                startPosMini.Y.Scale,
                startPosMini.Y.Offset + delta.Y
            )
        end
    end)
    
    miniGui = miniScreenGui
    return miniScreenGui
end

local function createUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TrollSpamUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 380, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -190, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Visible = true
    mainFrame.Parent = screenGui
    
    -- Main Corner
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame
    
    -- Glow Effect
    local glowFrame = Instance.new("Frame")
    glowFrame.Name = "GlowFrame"
    glowFrame.Size = UDim2.new(1, 0, 1, 0)
    glowFrame.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    glowFrame.BackgroundTransparency = 0.05
    glowFrame.BorderSizePixel = 0
    glowFrame.Parent = mainFrame
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 16)
    glowCorner.Parent = glowFrame
    
    -- Gradient Overlay
    local gradient = Instance.new("Frame")
    gradient.Name = "Gradient"
    gradient.Size = UDim2.new(1, 0, 1, 0)
    gradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    gradient.BackgroundTransparency = 1
    gradient.BorderSizePixel = 0
    gradient.Parent = mainFrame
    
    local grad = Instance.new("UIGradient")
    grad.Rotation = 45
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 50, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 100, 255))
    })
    grad.Transparency = NumberSequence.new(0.97)
    grad.Parent = gradient
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 55)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    titleBar.BackgroundTransparency = 0.3
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 16)
    titleCorner.Parent = titleBar
    
    -- Title Icon
    local titleIcon = Instance.new("TextLabel")
    titleIcon.Name = "TitleIcon"
    titleIcon.Size = UDim2.new(0, 40, 0, 40)
    titleIcon.Position = UDim2.new(0, 12, 0, 8)
    titleIcon.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    titleIcon.BackgroundTransparency = 0.2
    titleIcon.Text = "⚡"
    titleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleIcon.TextSize = 24
    titleIcon.Font = Enum.Font.GothamBold
    titleIcon.BorderSizePixel = 0
    titleIcon.Parent = titleBar
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = titleIcon
    
    -- Title Text
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(1, -140, 1, 0)
    titleText.Position = UDim2.new(0, 60, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "TROLL SPAMMER"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 20
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Font = Enum.Font.GothamBold
    titleText.Parent = titleBar
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Size = UDim2.new(1, -140, 0, 20)
    subtitle.Position = UDim2.new(0, 60, 0, 28)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Source Leaked 😂"
    subtitle.TextColor3 = Color3.fromRGB(150, 150, 180)
    subtitle.TextSize = 12
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = titleBar
    
    closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -45, 0, 10)
    closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    closeBtn.BackgroundTransparency = 0
    closeBtn.Text = "—"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 24
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        uiVisible = false
        if miniGui then
            miniGui.MiniFrame.Visible = true
        end
    end)
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -40, 1, -80)
    contentFrame.Position = UDim2.new(0, 20, 0, 70)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    
    local statusCard = Instance.new("Frame")
    statusCard.Name = "StatusCard"
    statusCard.Size = UDim2.new(1, 0, 0, 50)
    statusCard.Position = UDim2.new(0, 0, 0, 0)
    statusCard.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    statusCard.BackgroundTransparency = 0.3
    statusCard.BorderSizePixel = 0
    statusCard.Parent = contentFrame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 10)
    statusCorner.Parent = statusCard
    
    local statusDot = Instance.new("Frame")
    statusDot.Name = "StatusDot"
    statusDot.Size = UDim2.new(0, 12, 0, 12)
    statusDot.Position = UDim2.new(0, 15, 0, 19)
    statusDot.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    statusDot.BackgroundTransparency = 0
    statusDot.BorderSizePixel = 0
    statusDot.Parent = statusCard
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = statusDot
    
    local statusText = Instance.new("TextLabel")
    statusText.Name = "StatusText"
    statusText.Size = UDim2.new(1, -40, 1, 0)
    statusText.Position = UDim2.new(0, 35, 0, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "System Status: Disabled"
    statusText.TextColor3 = Color3.fromRGB(200, 200, 220)
    statusText.TextSize = 15
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Font = Enum.Font.Gotham
    statusText.Parent = statusCard
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "ToggleBtn"
    toggleBtn.Size = UDim2.new(1, -40, 0, 55)
    toggleBtn.Position = UDim2.new(0, 20, 0, 70)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
    toggleBtn.BackgroundTransparency = 0
    toggleBtn.Text = "ENABLE SPAM"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 18
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = contentFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleBtn
    
    local toggleGlow = Instance.new("Frame")
    toggleGlow.Name = "ToggleGlow"
    toggleGlow.Size = UDim2.new(1, 10, 1, 10)
    toggleGlow.Position = UDim2.new(0, -5, 0, -5)
    toggleGlow.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
    toggleGlow.BackgroundTransparency = 0.4
    toggleGlow.BorderSizePixel = 0
    toggleGlow.Parent = toggleBtn
    
    local toggleGlowCorner = Instance.new("UICorner")
    toggleGlowCorner.CornerRadius = UDim.new(0, 14)
    toggleGlowCorner.Parent = toggleGlow
    
    toggleBtn.MouseButton1Click:Connect(function()
        if trollPartsSpamEnabled then
            stopTrollPartsSpam()
            toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
            toggleBtn.Text = "ENABLE SPAM"
            toggleGlow.BackgroundColor3 = Color3.fromRGB(40, 180, 80)
            statusDot.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            statusText.Text = "System Status: Disabled"
            statusText.TextColor3 = Color3.fromRGB(200, 200, 220)
        else
            startTrollPartsSpam()
            toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            toggleBtn.Text = "DISABLE SPAM"
            toggleGlow.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            statusDot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            statusText.Text = "System Status: Enabled"
            statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    
    local dividerLine = Instance.new("Frame")
    dividerLine.Name = "DividerLine"
    dividerLine.Size = UDim2.new(0.9, 0, 0, 2)
    dividerLine.Position = UDim2.new(0.05, 0, 0, 145)
    dividerLine.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    dividerLine.BackgroundTransparency = 0.5
    dividerLine.BorderSizePixel = 0
    dividerLine.Parent = contentFrame
    
    local scriptsLabel = Instance.new("TextLabel")
    scriptsLabel.Name = "ScriptsLabel"
    scriptsLabel.Size = UDim2.new(1, 0, 0, 30)
    scriptsLabel.Position = UDim2.new(0, 0, 0, 155)
    scriptsLabel.BackgroundTransparency = 1
    scriptsLabel.Text = "SCRIPTS EXECUTOR"
    scriptsLabel.TextColor3 = Color3.fromRGB(180, 180, 210)
    scriptsLabel.TextSize = 14
    scriptsLabel.Font = Enum.Font.GothamBold
    scriptsLabel.TextXAlignment = Enum.TextXAlignment.Center
    scriptsLabel.Parent = contentFrame
    
    local btnContainer = Instance.new("Frame")
    btnContainer.Name = "BtnContainer"
    btnContainer.Size = UDim2.new(1, 0, 0, 120)
    btnContainer.Position = UDim2.new(0, 0, 0, 190)
    btnContainer.BackgroundTransparency = 1
    btnContainer.Parent = contentFrame
    
    local flyBtn = Instance.new("TextButton")
    flyBtn.Name = "FlyBtn"
    flyBtn.Size = UDim2.new(0.45, 0, 0, 45)
    flyBtn.Position = UDim2.new(0.025, 0, 0, 0)
    flyBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 200)
    flyBtn.BackgroundTransparency = 0
    flyBtn.Text = "FLY"
    flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    flyBtn.TextSize = 16
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.BorderSizePixel = 0
    flyBtn.Parent = btnContainer
    
    local flyCorner = Instance.new("UICorner")
    flyCorner.CornerRadius = UDim.new(0, 10)
    flyCorner.Parent = flyBtn
    
    flyBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FLY-GUI-V11-205450"))()
    end)
    
    local wallhopBtn = Instance.new("TextButton")
    wallhopBtn.Name = "WallhopBtn"
    wallhopBtn.Size = UDim2.new(0.45, 0, 0, 45)
    wallhopBtn.Position = UDim2.new(0.525, 0, 0, 0)
    wallhopBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 40)
    wallhopBtn.BackgroundTransparency = 0
    wallhopBtn.Text = "WALLHOP"
    wallhopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    wallhopBtn.TextSize = 16
    wallhopBtn.Font = Enum.Font.GothamBold
    wallhopBtn.BorderSizePixel = 0
    wallhopBtn.Parent = btnContainer
    
    local wallhopCorner = Instance.new("UICorner")
    wallhopCorner.CornerRadius = UDim.new(0, 10)
    wallhopCorner.Parent = wallhopBtn
    
    wallhopBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Best-Op-Wallhop-Script-213263"))()
    end)
    
    -- Version Label
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Name = "VersionLabel"
    versionLabel.Size = UDim2.new(1, 0, 0, 20)
    versionLabel.Position = UDim2.new(0, 0, 1, -25)
    versionLabel.BackgroundTransparency = 1
    versionLabel.Text = "Source Leaked 😂"
    versionLabel.TextColor3 = Color3.fromRGB(100, 100, 130)
    versionLabel.TextSize = 11
    versionLabel.Font = Enum.Font.Gotham
    versionLabel.TextXAlignment = Enum.TextXAlignment.Center
    versionLabel.Parent = contentFrame
    
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    gui = screenGui
    
    return screenGui
end

local function toggleUI()
    if gui then
        uiVisible = not uiVisible
        gui.MainFrame.Visible = uiVisible
        if not uiVisible and miniGui then
            miniGui.MiniFrame.Visible = true
        elseif uiVisible and miniGui then
            miniGui.MiniFrame.Visible = false
        end
    end
end

createUI()
createMiniUI()

if miniGui then
    miniGui.MiniFrame.Visible = false
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggleUI()
    end
end)

spawn(function()
    wait(1)
    local notification = Instance.new("BillboardGui")
    notification.Name = "WelcomeNotification"
    notification.Size = UDim2.new(0, 300, 0, 60)
    notification.StudsOffset = Vector3.new(0, 4, 0)
    notification.AlwaysOnTop = true
    notification.Parent = player.Character and player.Character:FindFirstChild("Head") or workspace
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = notification
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Text = "Troll Spammer Loaded!\nPress Right Shift to toggle UI"
    textLabel.TextSize = 13
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Parent = frame
    
    game:GetService("Debris"):AddItem(notification, 3.5)
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Conne
