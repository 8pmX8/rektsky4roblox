repeat task.wait() until game:IsLoaded()

local lib = loadstring(readfile("rektsky/NewRektskyUiLib.lua"))()

local spawn = function(func) 
    return coroutine.wrap(func)()
end

local getasset = getsynasset or getcustomasset

local ScreenGuitwo = game.CoreGui.RektskyNotificationGui

local function createnotification(title, text, delay2, toggled)
    spawn(function()
        if ScreenGuitwo:FindFirstChild("Background") then ScreenGuitwo:FindFirstChild("Background"):Destroy() end
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 100, 0, 115)
        frame.Position = UDim2.new(0.5, 0, 0, -115)
        frame.BorderSizePixel = 0
        frame.AnchorPoint = Vector2.new(0.5, 0)
        frame.BackgroundTransparency = 0.5
        frame.BackgroundColor3 = Color3.new(0, 0, 0)
        frame.Name = "Background"
        frame.Parent = ScreenGuitwo
        local frameborder = Instance.new("Frame")
        frameborder.Size = UDim2.new(1, 0, 0, 8)
        frameborder.BorderSizePixel = 0
        frameborder.BackgroundColor3 = (toggled and Color3.fromRGB(102, 205, 67) or Color3.fromRGB(205, 64, 78))
        frameborder.Parent = frame
        local frametitle = Instance.new("TextLabel")
        frametitle.Font = Enum.Font.SourceSansLight
        frametitle.BackgroundTransparency = 1
        frametitle.Position = UDim2.new(0, 0, 0, 30)
        frametitle.TextColor3 = (toggled and Color3.fromRGB(102, 205, 67) or Color3.fromRGB(205, 64, 78))
        frametitle.Size = UDim2.new(1, 0, 0, 28)
        frametitle.Text = "          "..title
        frametitle.TextSize = 24
        frametitle.TextXAlignment = Enum.TextXAlignment.Left
        frametitle.TextYAlignment = Enum.TextYAlignment.Top
        frametitle.Parent = frame
        local frametext = Instance.new("TextLabel")
        frametext.Font = Enum.Font.SourceSansLight
        frametext.BackgroundTransparency = 1
        frametext.Position = UDim2.new(0, 0, 0, 68)
        frametext.TextColor3 = Color3.new(1, 1, 1)
        frametext.Size = UDim2.new(1, 0, 0, 28)
        frametext.Text = "          "..text
        frametext.TextSize = 24
        frametext.TextXAlignment = Enum.TextXAlignment.Left
        frametext.TextYAlignment = Enum.TextYAlignment.Top
        frametext.Parent = frame
        local textsize = game:GetService("TextService"):GetTextSize(frametitle.Text, frametitle.TextSize, frametitle.Font, Vector2.new(100000, 100000))
        local textsize2 = game:GetService("TextService"):GetTextSize(frametext.Text, frametext.TextSize, frametext.Font, Vector2.new(100000, 100000))
        if textsize2.X > textsize.X then textsize = textsize2 end
        frame.Size = UDim2.new(0, textsize.X + 38, 0, 115)
        pcall(function()
            frame:TweenPosition(UDim2.new(0.5, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.15)
            game:GetService("Debris"):AddItem(frame, delay2 + 0.15)
        end)
    end)
end

local lplr = game:GetService("Players").LocalPlayer
local char = lplr.Character
local hrp = char.HumanoidRootPart
local hmd = char.Humanoid
local cam = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client

lib:CreateWindow()

local Tabs = {
    ["Combat"] = lib:CreateTab("Combat",Color3.fromRGB(252, 60, 68),"combat"),
    ["Movement"] = lib:CreateTab("Movement",Color3.fromRGB(255, 148, 36),"movement"),
    ["Render"] = lib:CreateTab("Render",Color3.fromRGB(59, 170, 222),"render"),
    ["Player"] = lib:CreateTab("Player",Color3.fromRGB(83, 214, 110),"player"),
    ["Exploits"] = lib:CreateTab("Exploits",Color3.fromRGB(157, 39, 41),"exploit"),
    ["Rektsky"] = lib:CreateTab("RektSky",Color3.fromRGB(64,124,252),"rektsky"),
    ["World"] = lib:CreateTab("World",Color3.fromRGB(52,28,228),"world")
}

local LCE = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client.events).LobbyClientEvents
local queuemeta = require(game:GetService("ReplicatedStorage").TS.game["queue-meta"]).QueueMeta

local function getQueueFromName(name)
    for i,v in pairs(queuemeta) do 
        if v.title == name and i:find("voice") == nil then
            return i
        end
    end
    return "bedwars_to1"
end

do
    local aqtoggled = false
    local AQMode = {["Value"] = "bedwars_to1"}
    local aqtog = Tabs["Player"]:CreateToggle({
        ["Name"] = "AutoQueue",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            aqtoggled = v
            if (aqtoggled) then
                LCE.joinQueue({
                    queueType = getQueueFromName(AQMode["Value"])
                })
            else
                LCE.leaveQueue:fire()
            end
        end
    })
    AQMode = aqtog:CreateDropDown({
        ["Name"] = "AQMode",
        ["Function"] = function(val) 
            if aqtog["Enabled"] then
                LCE.leaveQueue:fire()
                wait(0.5)
                LCE.joinQueue({
                    queueType = getQueueFromName(val)
                })
            end
        end,
        ["List"] = {},
        ["Default"] = "BedWars (Solo)"
    })
    for i,v in pairs(queuemeta) do 
        if v.title:find("Test") == nil then
            table.insert(AQMode["List"], v.title..(i:find("voice") and " (VOICE)" or "")) 
        end
    end
    for i, v in pairs(AQMode["List"]) do
        print(i, v)
    end
end
