repeat task.wait() until game:IsLoaded()
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        queueteleport("loadstring(readfile('rektsky/mainscript.lua'))()")
    end
end)
if game.PlaceId == 6872274481 or game.PlaceId == 8560631822 or game.PlaceId == 8444591321 then
    loadstring(readfile("rektsky/scripts/bedwars.lua"))()
elseif game:HttpGet then
    loadstring(readfile("rektsky/scripts/"..game.PlaceId..".lua"))()
else
    loadstring(readfile("rektsky/scripts/AnyGame.lua"))()
end