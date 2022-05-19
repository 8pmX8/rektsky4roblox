repeat task.wait() until game:IsLoaded()

local lib = loadstring(readfile("rektsky/NewRektskyUiLib.lua"))()

local entity = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()

do
    local oldcharacteradded = entity.characterAdded
    entity.characterAdded = function(plr, char, localcheck)
        return oldcharacteradded(plr, char, localcheck, function() end)
    end
    entity.fullEntityRefresh()
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
local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
local hmd = char.Humanoid
local cam = workspace.CurrentCamera
local RunService = game:GetService("RunService")

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

do
    local oldWS
    local oldGrav
    local oldJP
    local timercallback = false
    local valuethingyexdee
    local testtog = {["Value"] = 1}
    local togthingy = Tabs["World"]:CreateToggle({
        ["Name"] = "Timer",
        ["Keybind"] = nil,
        ["Callback"] = function(v) 
            timercallback = v
            if timercallback then
                oldWS = oldWS or lplr.Character.Humanoid.WalkSpeed
                oldGrav = oldGrav or game.Workspace.Gravity
                oldJP = oldJP or lplr.Character.Humanoid.JumpPower
                lplr.Character.Humanoid.WalkSpeed = lplr.Character.Humanoid.WalkSpeed * testtog["Value"]
                game.Workspace.Gravity = game.Workspace.Gravity * testtog["Value"] / 2
            else
                hmd.WalkSpeed = oldWS
                game.Workspace.Gravity = oldGrav
            end
        end
    })
    testtog = togthingy:CreateSlider({
        ["Name"] = "Multiplier",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 20,
        ["Default"] = 1,
        ["Round"] = 1
    })
end