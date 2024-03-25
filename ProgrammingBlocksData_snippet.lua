local module = {}

module.BlockCategories = {
    ["Misc"] = {
        {
            "String Sandbox", -- Expected to go after Text

            "StrboxNewString",
            "StrboxIf",
            "StrboxConcatenate",
			"StrboxSplitString",
			"StrboxFindString",
			"StrboxSubstring",
			"StrboxGSubString",
			"StrboxGetLength",
			"StrboxToNumber",
			"StrboxUpper",
			"StrboxLower",
            "StrboxFilterString",
            "StrboxNumberToChar",
            "StrboxStringToBytes", -- Maybe add to Text?
            "StrboxRepeatString", -- Should be added to Text as well (with filtering)
            "StrboxReverseString", -- ^
            "StrboxMatchString", -- ^
            "StrboxFormatString", -- ^
			
        }
    }
}

module.BlockCategories = {
    ["StrboxNewString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "New SandboxString String",
		["Description"] = [[
			Takes in an input and converts it to a SandboxString.
            SandboxStrings aren't filtered right away, but must be filtered to be used anywhere outside of the sandbox.
            Useful for heavy string manipulation.
            Note that some inputs aren't required to be SandboxStrings even if it can take one.
            (made by NicePotato)
		]], -- You can remove credits here if you want, I don't mind

		["PreviewDisplay"] = {
			"Convert ",
            "!Input",
            " to SandboxString ",
            "!SandboxString"
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
		},
		["Outputs"] = {
			-- Outputs
			"SandboxString"
		},
	},
    ["StrboxIf"] = {
		["AutoExecuteChildren"] = false,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "SandboxString If",
		["Description"] = [[
			Runs connected blocks if the condition given is true.
            Required for comparisons with SandboxStrings.
		]],

		["PreviewDisplay"] = {
			"!Value 1",
			" ",
			"!ComparisonType",
			" ",
			"!Value 2"
		},

		["Inputs"] = {
			["Value 1"] = {
				["VariableType"] = "Any",
				["ListOrder"] = 1,
			},
			["ComparisonType"] = {
				["VariableType"] = "Choice",
				["Choices"] = {"==", "~=", ">", "<", "<=", ">="},
				["ListOrder"] = 2,
			},
			["Value 2"] = {
				["VariableType"] = "Any",
				["ListOrder"] = 3,
			},
		},
		["Outputs"] = {
			-- Outputs
		},
	},
    ["StrboxConcatenate"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Combine Values as SandboxString",
		["Description"] = [[
			Combines two values and return a SandboxString from them.
            Any values allowed.
		]],

		["PreviewDisplay"] = {
			"Combine ",
			"!FirstValue",
			" with ",
			"!SecondValue",
			" to SandboxString",
		},

		["Inputs"] = {
			["FirstValue"] = {
				["VariableType"] = "Any",
				["ListOrder"] = 1,
			},
			["SecondValue"] = {
				["VariableType"] = "Any",
				["ListOrder"] = 2,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
	["StrboxSplitString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Split SandboxString",
		["Description"] = [[
			Splits an input into parts based on the defined seperator character(s), returning a table of ordered results.
            Table is filled with SandboxStrings.
		]],

		["PreviewDisplay"] = {
			"Split ",
			"!Input",
			" with seperator ",
			"!Seperator",
			" to StringSandbox",
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
			["Seperator"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 2,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
	["StrboxFindString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Find String in SandboxString",
		["Description"] = [[
			Looks for the first match of the given pattern.
		]],

		["PreviewDisplay"] = {
			"Find ",
			"!Pattern",
			" in SandboxString ",
			"!Input",
		},

		["Inputs"] = {
			["Pattern"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 2,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxSubstring"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "StringSandbox Substring",
		["Description"] = [[
			Returns the substring of an input that starts at the first number to the last number.
            Result is StringSandbox.
		]],

		["PreviewDisplay"] = {
			"Get Substring from ",
			"!Input",
			" starting at ",
			"!StartPoint",
			" ending at ",
			"!EndPoint",
			" to StringSandbox"
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
			["StartPoint"] = {
				["VariableType"] = "Number",
                ["DefaultValue"] = 1,
				["ListOrder"] = 2,
			},
			["EndPoint"] = {
				["VariableType"] = "Number",
                ["DefaultValue"] = 1,
				["ListOrder"] = 3
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
	["StrboxGSubString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Global Sub SandboxString",
		["Description"] = [[
			Returns a copy of the provided input in which all occurences of the pattern are replaced with the given replacement.
            Result is SandboxString.
		]],

		["PreviewDisplay"] = {
			"Replace ",
			"!Pattern",
			" in string ",
			"!Input",
			" with replacement ",
			"!Replacement",
            " to SandboxString"
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
			["Pattern"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 2,
			},
			["Replacement"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 3
			}
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxGetLength"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Get Length Of A SandboxString",
		["Description"] = [[
            Returns the number of characters in an input.
		]],

		["PreviewDisplay"] = {
			"Length of SandboxString ",
			"!Input"
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1
			}
		},
		["Outputs"] = {
			"Length"
		}
	},
	["StrboxToNumber"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "SandboxString To Number",
		["Description"] = [[
			Converts input to a number.
            Optionally define a radix for bases other than 10.
		]],

		["PreviewDisplay"] = {
            "SandboxString ",
			"!Input",
            " to Number with radix ",
            "!Radix"
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
            ["Radix"] = {
				["VariableType"] = "Number",
				["ListOrder"] = 2,
				["DefaultValue"] = 10,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Number",
		},
	},
	["StrboxUpper"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Upper SandboxString",
		["Description"] = [[
			Capitalizes all characters in input.
            Result is SandboxString.
		]],

		["PreviewDisplay"] = {
			"Capitalize SandboxString '",
			"!Input",
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
	["StrboxLower"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Lower SandboxString",
		["Description"] = [[
			Lower all characters in input.
            Result in SandboxString.
		]],

		["PreviewDisplay"] = {
			"Lower all characters in SandboxString ",
			"!Input",
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxFilterString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Filter SandboxString",
		["Description"] = [[
			Filters an input SandboxString back to normal string.
		]],

		["PreviewDisplay"] = {
			"Filter SandboxString ",
			"!Input",
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxNumberToChar"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Bytes to SandboxString",
		["Description"] = [[
			Takes an input number or table of numbers and converts them to string byte form.
            Result is SandboxString.
		]],

		["PreviewDisplay"] = {
			"Byte(s) ",
			"!Bytes ",
            " to SandboxString"
		},

		["Inputs"] = {
			["Bytes"] = {
				["VariableType"] = "Number",
                ["AllowedTypes"] = {"Number", "Table"},
				["ListOrder"] = 1,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxStringToBytes"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "SandboxString to Bytes",
		["Description"] = [[
			Takes characters from StartPoint to EndPoint in an input SandboxString and
            returns a table of numbers if there is more than one character, else just returns a single number of the character(s) as bytes.
		]],

		["PreviewDisplay"] = {
			"Get bytes from SandboxString ",
			"!Input",
			" starting at ",
			"!StartPoint",
			" ending at ",
			"!EndPoint",
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
			["StartPoint"] = {
				["VariableType"] = "Number",
                ["DefaultValue"] = 1,
				["ListOrder"] = 2,
			},
			["EndPoint"] = {
				["VariableType"] = "Number",
                ["DefaultValue"] = 1,
				["ListOrder"] = 3
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxRepeatString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Repeat SandboxString",
		["Description"] = [[
			Repeat an input Times times.
            Result is a SandboxString.
		]],

		["PreviewDisplay"] = {
            "Repeat SandboxString ",
			"!Input",
            " ",
            "!Times",
            " times"
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
            ["Times"] = {
				["VariableType"] = "Number",
				["ListOrder"] = 2,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxReverseString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Reverse SandboxString",
		["Description"] = [[
			Reverse an input.
            Result is a SandboxString.
		]],

		["PreviewDisplay"] = {
            "Reverse SandboxString ",
			"!Input",
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxMatchString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Match in SandboxString",
		["Description"] = [[
			Finds first match of Pattern in input, if match is found, string is returned, otherwise returns nil.
            Init argument specifies which character to start search.
            Result is a SandboxString.
		]],

		["PreviewDisplay"] = {
            "Match pattern ",
            "!Pattern",
            " in SandboxString ",
            "!Input",
            " starting at ",
            "!Init"
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
            ["Pattern"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 2,
			},
            ["Init"] = {
				["VariableType"] = "Number",
                ["DefaultValue"] = 1,
				["ListOrder"] = 3,
			},
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
    ["StrboxFormatString"] = {
		["AutoExecuteChildren"] = true,
		["BumpEnvironment"] = false,
		["IsEvent"] = false,

		["Server"] = true,
		["Local"] = true,

		["VisualName"] = "Format SandboxString",
		["Description"] = [[
			Applies formatting from table Formatting to input.
            Table should be filled 
            Result is a SandboxString.
		]],

		["PreviewDisplay"] = {
            "Apply formats from ",
            "!Formatting",
            " to SandboxString ",
			"!Input",
		},

		["Inputs"] = {
			["Input"] = {
				["VariableType"] = "String",
                ["AllowedTypes"] = {"Any"},
				["ListOrder"] = 1,
			},
            ["Formatting"] = {
                ["VariableType"] = "Table",
                ["ListOrder"] = 2
            }
		},
		["Outputs"] = {
			-- Outputs
			"Result",
		},
	},
}