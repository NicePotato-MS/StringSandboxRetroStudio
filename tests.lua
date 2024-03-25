--[[

    Tests for StringSandbox library
    Made by NicePotato

]]--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StringSandbox = require(ReplicatedStorage.StringSandbox)

local sandbox = StringSandbox.sandbox

local tests = {
	["Creation"] = function()
		assert(type(sandbox) == "function", "sandbox function nil or not function, all tests will fail")
		local sandboxed = sandbox("This is a test string.")
		assert(sandboxed.raw == "This is a test string.", "sandboxed.raw is not source string")
		assert(type(sandboxed.len) == "function", "sandboxed.len function nil or not function")
	end,
	["String standard functions"] = function()
		local sandboxed = sandbox("This is a test string.")
		local split = sandboxed:split(" ") -- Split string by space
		for k,v in pairs(string.split("This is a test string.", " ")) do -- Check if same contents returned
			assert(v == split[k].raw, "Split function failed")
		end
		assert(sandboxed:upper().raw == "THIS IS A TEST STRING.", "Upper function failed")
	end,
	["Filter"] = function()
		local sandboxed = sandbox("This is a test string.")
		assert(StringSandbox.filter(sandboxed) == "This is a test string.", "String filtered when it shouldn't be! (Blame roblox probably)")
		local bad = sandbox("This dumbass text will be fucking filtered!")
		assert(StringSandbox.filter(bad) ~= "This dumbass text will be fucking filtered!", "String not filtered (are you in studio?)")
	end,
    ["Concat Metamethod"] = function()
        assert((sandbox("a")..sandbox("b")).raw == "ab", "SandboxString 'a' .. SandboxString 'b' not returning 'ab'")
        assert((sandbox("a").."b").raw == "ab", "SandboxString 'a' .. string 'b' not returning 'ab")
        assert(("b"..sandbox("a")).raw == "ba", "string 'b' .. SandboxString 'a' not returning 'ba")

        local testNum = 1
        assert((sandbox("a")..testNum).raw == "a1", "SandboxString 'a' .. 1 not returning 'a1'")
        assert((testNum..sandbox("a")).raw == "1a", "1 .. SandboxString 'a' not returning '1a'")
    end,
    ["Addition Metamethod"] = function()
        local testStr = "b"
        assert((sandbox("a")+sandbox("b")).raw == "ab", "SandboxString 'a' + SandboxString 'b' not returning 'ab'")
        assert((sandbox("a")+testStr).raw == "ab", "SandboxString 'a' + string 'b' not returning 'ab")
        assert((testStr+sandbox("a")).raw == "ba", "string 'b' + SandboxString 'a' not returning 'ba")

        assert((sandbox("a")+1).raw == "a1", "SandboxString 'a' + 1 not returning 'a1'")
        assert((1+sandbox("a")).raw == "1a", "1 + SandboxString 'a' not returning '1a'")
    end,
    ["Multiplication Metamethod"] = function()
        assert((sandbox("a")*3).raw == "aaa", "SandboxString 'a' * 3 not equal to 'aaa'")
        assert((3 * sandbox("a")).raw == "aaa", "3 * SandboxString 'a' not equal to 'aaa'")
    end,
    ["Division Metamethod"] = function()
        local testStr = " " -- Space
        local split = sandbox("This is a test string.")/testStr
        for k,v in pairs(string.split("This is a test string.", " ")) do -- Check if same contents returned
			assert(v == split[k].raw, "Invalid contents returned")
		end
    end,
    ["Length Metamethod"] = function()
        assert(#sandbox("test") == 4, "Length of SandboxString 'test' not being reported as 4")
    end
}

for testname, test in pairs(tests) do
	local success, result = pcall(test)
	if success then
		print("[PASS] - "..testname)
	else
		warn("[FAIL] - "..testname.." - Reason: "..result)
	end
end