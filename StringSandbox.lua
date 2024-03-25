--[[

    String Sandbox v1.0
    Made by NicePotato (discord .nicepotato)

    StringSandbox allows non-filtered string manipulation in a sandboxed enviornment
    and a filtered string to be returned after the manipulation is done

    A sandboxed string cannot have its raw string be applied to any property due to it being a userdata type
    Since it is a userdata type, it will not conflict with other functions that check type

    Originally made for RetroStudio


    Dev notes:

    why is there no type annotation for userdata???
    Some work may have to be done for sending through remotes

]]--

local StringSandbox = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunctions = ReplicatedStorage.RemoteFunctions
local ClientFilterRequest = RemoteFunctions.ClientFilterRequest
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

local filterString -- function to filter a string

if RunService:IsServer() then -- If server, use local function for filtering
	filterString = function(str : string) -- Filter string and catch error
		local success, result = pcall(function()
			return TextService:FilterStringAsync(str, Players:FindFirstChildOfClass("Player").UserId) -- Filter string
		end)

		if success then -- String filtered with no error, return it
			return result:GetNonChatStringForBroadcastAsync()
		else -- Error occured, report it
			error("Failed to filter string. Error returned: "..tostring(result))
		end
	end
else -- If client, use module for filtering
	filterString = function(str : string)
		local filtered = ClientFilterRequest:InvokeServer(str)
		if filtered then -- Filtered string successfully
			return filtered
		else
			error("Failed to filter string.")
		end
	end
end

local function getType(input)
    local dataType = type(input)
    if dataType == "nil" then
        error("nil value passed to SandboxString function")
    end
    if dataType ~= "userdata" and dataType ~= "string" then
        error("Attempt to affect a non userdata or string in SandboxString, wrong data-type")
    end

    return dataType
end

function StringSandbox.raw(input) -- Return a strings raw form
    local dataType = getType(input)

    if dataType == "userdata" then -- This is a sandbox
        return input.raw
    else -- Otherwise it's a string
        return input
    end
end

local getString = StringSandbox.raw -- Easier access to raw method
local sandbox -- Easier access to sandbox method

function StringSandbox.getString(input) -- different from getString defined above, gets sandboxed string form of any input
    if type(input) == "userdata" then
        return input
    else
        return sandbox(tostring(input))
    end
end

function StringSandbox.plainString(input) -- get plain string from any input
    if type(input) == "userdata" then
        return input.raw
    else
        return tostring(input)
    end
end

function StringSandbox.filter(input) -- Take a string and returned its filtered form
    local dataType = getType(input)

    if dataType == "userdata" then -- This is a sandbox
        return filterString(input.raw)
    else -- Otherwise it's a string
        return filterString(input)
    end
end

function StringSandbox.split(input, seperator) -- Split string by delimiter
    local outTable = {}
    for k,v in pairs(getString(input):split(seperator)) do -- Sandbox every entry in table
        outTable[k] = sandbox(v)
    end

    return outTable
end

function StringSandbox.match(input, pattern, init)
    return sandbox(getString(input):match(pattern, init))
end

function StringSandbox.upper(input)
    return sandbox(getString(input):upper())
end

function StringSandbox.gsub(input, pattern, replacement, replacements)
    local str, num = getString(input):gsub(pattern, replacement, replacements)
    return sandbox(str), num
end

function StringSandbox.format(input, ...)
    return sandbox(getString(input):format(...))
end

function StringSandbox.lower(input)
    return sandbox(getString(input):lower())
end

function StringSandbox.sub(input, i, j)
    return sandbox(getString(input):sub(i,j))
end

function StringSandbox.find(input, pattern, init, plain)
    return getString(input):find(pattern, init, plain)
end

function StringSandbox.char(...)
    return sandbox(string.char(...))
end

function StringSandbox.reverse(input)
    return sandbox(getString(input):reverse())
end

function StringSandbox.byte(input, i, j)
    return getString(input):byte(i,j)
end

function StringSandbox.rep(input, num)
    return sandbox(getString(input):rep(num))
end

function StringSandbox.len(input)
    return getString(#input.raw)
end

function StringSandbox.sandbox(input , plr : Player) -- Takes a string and returns a sandboxed string
	local sandboxed = newproxy(true) -- Create new userdata with blank metatable

    local rawstr = getString(input)

	local mt = getmetatable(sandboxed) -- Get new blank metatable

	local mtIndex = {} -- Functions for sandboxed string

	mtIndex.raw = rawstr

    mtIndex.filter = function() -- Attempt to filter
        if RunService:IsServer() then -- Return filtered string
            return filterString(rawstr)
        else -- This is a client, error
            error("Due to limitations with luau, you must use the module function on client-side.")
        end
    end

    mtIndex.split = StringSandbox.split -- retro
    mtIndex.match = StringSandbox.match -- strbox
    mtIndex.upper = StringSandbox.upper -- retro
    mtIndex.gsub = StringSandbox.gsub -- retro
    mtIndex.format = StringSandbox.format -- strbox
    mtIndex.lower = StringSandbox.lower -- retro
    mtIndex.sub = StringSandbox.sub -- retro
    mtIndex.find = StringSandbox.find -- retro
    mtIndex.char = StringSandbox.char -- strbox
    mtIndex.reverse = StringSandbox.reverse -- strbox
    mtIndex.byte = StringSandbox.byte -- strbox
    mtIndex.rep = StringSandbox.rep -- strbox
    mtIndex.len = StringSandbox.len -- retro

	mt.__index = function(_, key) -- index metamethod
		if type(key) == "number" then -- Return sandboxed character of string
			sandbox(rawstr:sub(key,key), plr)
		else -- Return from mtIndex
			return mtIndex[key]
		end
	end

    mt.__mul = function(a, b) -- same as string.rep
        local aType = type(a)
        local bType = type(b)

        -- Convert sandboxes to strings first
        if aType == "userdata" then -- This is a sandbox
            a = a.raw
        end

        if bType == "userdata" then -- This is a sandbox
            b = b.raw
        end

        aType = type(a)
        bType = type(b)

        local str
        local rep

        -- Make sure we have at least one number
        if aType == "string" then -- If a is string
            if bType ~= "number" then -- Non-number
                error("Attempt to multiply string by non-number")
            end
            str = a
            rep = b
        else -- If a is not string, b has to be
            if aType ~= "number" then -- Non-number
                error("Attempt to multiply string by non-number")
            end
            str = b
            rep = a
        end

        return sandbox(str:rep(rep))
    end

    mt.__div = function(a,b) -- same as string.split
        a = getString(a)
        if type(a) ~= "string" then
            error("Attempt to divide non-string by string")
        end
        if type(b) ~= "string" then
            error("Attempt to divide string by non-string")
        end

        return StringSandbox.split(a,b)
    end

    mt.__len = function()
        return #rawstr
    end

    mt.__concat = function(a,b) -- concat metamethod
        local aType = type(a)
        local bType = type(b)

        -- Convert sandboxes to strings first
        if aType == "userdata" then -- This is a sandbox
            a = a.raw
        end

        if bType == "userdata" then -- This is a sandbox
            b = b.raw
        end

        return sandbox(tostring(a)..tostring(b))        
    end

    mt.__add = mt.__concat

	mt.__tostring = function() -- Attempt to convert to string
        if RunService:IsServer() then -- Return filtered string
            return filterString(rawstr)
        else -- This is a client, error
            error("Due to limitations with luau, you must convert this SandboxString back to string first with String Sandbox filter block on client-side.")
        end
    end

	return sandboxed
end

sandbox = StringSandbox.sandbox -- Have to set it down here :P

return StringSandbox