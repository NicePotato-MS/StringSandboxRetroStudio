--[[

    ClientFilterHandler
    Made by NicePotato (discord .nicepotato)

    Handler for module to allow client sided string filtering

    Originally made for RetroStudio

    Dev Notes:
    may need to implement anti-spam

]]--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunctions = ReplicatedStorage.RemoteFunctions
local ClientFilterRequest = RemoteFunctions.ClientFilterRequest
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

ClientFilterRequest.OnServerInvoke = function(plr : Player, str : string)
	local success, result = pcall(function()
		return TextService:FilterStringAsync(str, plr.UserId) -- Filter string
	end)

	if success then -- String filtered with no error, return it
		return result:GetNonChatStringForBroadcastAsync()
	else -- Error occured, report it
		error("Failed to filter string. Error returned: "..tostring(result))
	end
end