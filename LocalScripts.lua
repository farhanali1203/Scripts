-- Whitelist Checker
local WhitelistOwnerId = 8851106317 -- @Username_error1404 Player ID

local function CheckWhitelist()
    local player = game.Players.LocalPlayer
    local userId = player.UserId
    
    if userId == WhitelistOwnerId then
        return true
    end
    
    local success, response = pcall(function()
        return game:HttpGet("https://friends.roblox.com/v1/users/" .. userId .. "/followings?sortOrder=Asc&limit=100")
    end)
    
    if success then
        local data = game:GetService("HttpService"):JSONDecode(response)
        for _, following in pairs(data.data) do
            if following.id == WhitelistOwnerId then
                return true
            end
        end
    end
    
    return false
end

if not CheckWhitelist() then
    game.Players.LocalPlayer:Kick(
        "Your Not Whitelist! First Follow @Username_error1404 After Get Whitelist!"
    )
    return
end

-- Game ID Check
local expectedGameId = 78839079957645
local currentGameId = game.PlaceId

if currentGameId ~= expectedGameId then
    game.Players.LocalPlayer:Kick(
        "This Script Design For Trolls can't break this tower\n(Error Code: 267)"
    )
    return
end

-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()
local Window = Library:Window("LocalScripts")

-- Variables
getgenv().TrollSpam = false

-- Troll Spam Function
local player = game.Players.LocalPlayer

local function instantSpam(part)
    if part and part:IsA("BasePart") then
        local primary = player.Character and player.Character.PrimaryPart
        if primary then
            pcall(function()
                firetouchinterest(primary, part, 0)
                firetouchinterest(primary, part, 1)
            end)
        end
        
        local cd = part:FindFirstChildOfClass("ClickDetector")
        if cd then
            pcall(function()
                fireclickdetector(cd)
            end)
        end
    end
end

local function TrollSpamLoop()
    task.spawn(function()
        while getgenv().TrollSpam do
            local tower = workspace:FindFirstChild("Tower")
            
            if tower then
                -- Target Button components
                local buttonFolder = tower:FindFirstChild("Button")
                if buttonFolder then
                    for _, child in ipairs(buttonFolder:GetChildren()) do
                        if child.Name == "Part" then
                            instantSpam(child)
                        end
                    end
                    if buttonFolder:IsA("BasePart") then
                        instantSpam(buttonFolder)
                    end
                end
                
                -- Target Part structures
                for _, child in ipairs(tower:GetChildren()) do
                    if child.Name == "Part" and child:IsA("BasePart") then
                        instantSpam(child)
                    end
                end
                
                -- Target Fading Path
                local fadingPath = tower:FindFirstChild("FadingPath")
                if fadingPath then
                    for _, child in ipairs(fadingPath:GetChildren()) do
                        if child.Name == "Part" then
                            instantSpam(child)
                        end
                    end
                end
                
                -- Target Keypad Buttons
                local codeDoor = tower:FindFirstChild("CodeDoor")
                local board = codeDoor and codeDoor:FindFirstChild("Board")
                local numbers = board and board:FindFirstChild("Numbers")
                if numbers then
                    for _, numPart in ipairs(numbers:GetChildren()) do
                        instantSpam(numPart)
                    end
                end
            end
            
            task.wait()
        end
    end)
end

-- UI Elements
Window:Toggle("Troll Server", false, function(state)
    getgenv().TrollSpam = state
    if state then
        TrollSpamLoop()
    end
end)

Window:Label("Made By LocalScripts")