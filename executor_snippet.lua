-- Stuff at top is to make linter shut up
local blocktype
local inputValues
local writeVariable
local executeChildren
local printError
local name
local data

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StringSandbox = require(ReplicatedStorage.StringSandbox) -- This must be added to top

if false then -- The rest of the executor...

elseif blocktype == "StrboxNewString" then
    writeVariable(data.Outputs.SandboxString, StringSandbox.getString(inputValues["Input"]))
elseif blocktype == "StrboxIf" then
    if tonumber(inputValues["Value 1"]) then
		inputValues["Value 1"] = tonumber(inputValues["Value 1"])
	end
	if tonumber(inputValues["Value 2"]) then
		inputValues["Value 2"] = tonumber(inputValues["Value 2"])
	end

    local function lt(a,b) -- If two strings, return if #a<#b or if string and number return if #a<b
        local aType = type(a)
        local bType = type(b)

        -- Convert sandboxes to strings first
        if aType == "userdata" then -- This is a sandbox
            a = a.raw
        end

        if bType == "userdata" then -- This is a sandbox
            b = b.raw
        end

        if type(a) == "string" then
            if type(b) == "string" then -- Two strings, return result of #a < #b
                return #a < #b
            elseif type(b) == "number" then -- Check if length of a < number b
                return #a < b
            else
                error("Attempt to compare string to non string or number")
            end
        elseif type(a) == "number" then
            return #b < a -- Check if length of b < number a
        else
            error("Attempt to compare string to non string or number")
        end
    end

    local function le(a,b) -- If two strings, return if #a<=#b or if string and number return if #a<=b
        local aType = type(a)
        local bType = type(b)

        -- Convert sandboxes to strings first
        if aType == "userdata" then -- This is a sandbox
            a = a.raw
        end

        if bType == "userdata" then -- This is a sandbox
            b = b.raw
        end

        if type(a) == "string" then
            if type(b) == "string" then -- Two strings, return result of #a < #b
                return #a <= #b
            elseif type(b) == "number" then -- Check if length of a < number b
                return #a <= b
            else
                error("Attempt to compare string to non string or number")
            end
        elseif type(a) == "number" then
            return #b <= a -- Check if length of b < number a
        else
            error("Attempt to compare string to non string or number")
        end
    end

    local function eq(a,b) -- If two strings, check if content is equal, if string and number, check length equal to num
        local aType = type(a)
        local bType = type(b)

        -- Convert sandboxes to strings first
        if aType == "userdata" then -- This is a sandbox
            a = a.raw
        end

        if bType == "userdata" then -- This is a sandbox
            b = b.raw
        end

        print(aType, type(a), a)
        print(bType, type(b), b)

        if type(a) == "string" then
            if type(b) == "string" then -- Two strings, return result of a == b
                return a == b
            elseif type(b) == "number" then -- Check if length of a == number b
                return #a == b
            else
                error("Attempt to compare string to non string or number")
            end
        elseif type(a) == "number" then -- if a is number, b must be the string
            return #b == a -- Check if length of b == number a
        else
            error("Attempt to compare string to non string or number")
        end
    end

	if inputValues.ComparisonType == "==" then
		if eq(inputValues["Value 1"],inputValues["Value 2"]) then
			executeChildren(nil)
		end
	elseif inputValues.ComparisonType == "~=" then
		if not eq(inputValues["Value 1"],inputValues["Value 2"]) then
			executeChildren(nil)
		end
	elseif inputValues.ComparisonType == ">" then
		if lt(inputValues["Value 2"],inputValues["Value 1"]) then
			executeChildren(nil)
		end
	elseif inputValues.ComparisonType == "<" then
		if lt(inputValues["Value 1"],inputValues["Value 2"]) then
			executeChildren(nil)
		end
	elseif inputValues.ComparisonType == ">=" then
		if le(inputValues["Value 2"],inputValues["Value 1"]) then
			executeChildren(nil)
		end
	elseif inputValues.ComparisonType == "<=" then
		if le(inputValues["Value 1"],inputValues["Value 2"]) then
			executeChildren(nil)
		end
	else
		printError("Attempt to compare " .. type(inputValues["Value 1"]) .. " " .. inputValues.ComparisonType .. " " .. type(inputValues["Value 2"]), script, name)
	end
elseif blocktype == "StrboxConcatenate" then
	writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["FirstValue"])..StringSandbox.getString(inputValues["SecondValue"]))
elseif blocktype == "StrboxSplitString" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):split(StringSandbox.plainString(inputValues["Seperator"])))
elseif blocktype == "StrboxFindString" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):find(StringSandbox.plainString(inputValues["Pattern"])))
elseif blocktype == "StrboxSubstring" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):sub(inputValues["StartPoint"],inputValues["EndPoint"]))
elseif blocktype == "StrboxGSubString" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):gsub(StringSandbox.plainString(inputValues["Pattern"]),StringSandbox.plainString(inputValues["Replacement"])))
elseif blocktype == "StrboxGetLength" then
    writeVariable(data.Outputs.Length, #StringSandbox.getString(inputValues["Input"]))
elseif blocktype == "StrboxToNumber" then
    writeVariable(data.Outputs.Result, tonumber(StringSandbox.plainString(inputValues["Input"]),inputValues["Radix"]))
elseif blocktype == "StrboxUpper" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):upper())
elseif blocktype == "StrboxLower" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):lower())
elseif blocktype == "StrboxFilterString" then
    writeVariable(data.Outputs.Result, StringSandbox.filter(StringSandbox.getString(inputValues["Input"])))
elseif blocktype == "StrboxNumberToChar" then
    local inBytes = inputValues["Bytes"]
    if type(inBytes) == "number" then
        writeVariable(data.Outputs.Result, StringSandbox.char(inBytes))
    elseif type(inBytes) == "table" then
        writeVariable(data.Outputs.Result, StringSandbox.char(table.unpack(inBytes)))
    else
        printError("Attempt to convert non number or table bytes to string, got type "..type(inBytes))
    end
elseif blocktype == "StrboxStringToBytes" then
    local startPos = inputValues["StartPoint"]
    local endPos = inputValues["EndPoint"]
    if startPos == endPos then -- Return single number
        writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):byte(startPos,endPos))
    else -- Return Table
        writeVariable(data.Outputs.Result, {StringSandbox.getString(inputValues["Input"]):byte(startPos,endPos)})
    end
elseif blocktype == "StrboxRepeatString" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):rep(inputValues["Times"]))
elseif blocktype == "StrboxReverseString" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):reverse())
elseif blocktype == "StrboxMatchString" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):match(StringSandbox.plainString(inputValues["Pattern"]),inputValues["Init"]))
elseif blocktype == "StrboxFormatString" then
    writeVariable(data.Outputs.Result, StringSandbox.getString(inputValues["Input"]):format(table.unpack(inputValues["Formatting"])))
end -- The rest of the executor...