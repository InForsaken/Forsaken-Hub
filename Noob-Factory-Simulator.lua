-- Init
repeat task.wait() until game:IsLoaded()
if game.PlaceId ~= 10360781460 then
    while true do
        task.wait()
    end
end

-- Loading UI
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/InForsaken/Forsaken-Hub/main/Rayfield-Lib.lua'))()

local Window = Rayfield:CreateWindow({
	Name = "Forsaken Suite",
	LoadingTitle = "Forsaken Suite",
	LoadingSubtitle = "by InForsaken#3634",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Forsaken Suite",
		FileName = "Forsaken Hub"
	},
	KeySystem = false, -- Set this to true to use their key system
	KeySettings = {
		Title = "Forsaken Suite",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/Bu85QE6zwE)",
		SaveKey = true,
		Key = "ABCDEF"
	}
})

-- Globals
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer
local User = Player.Name
local UserId = Player.UserId
local Stages = game:GetService("Workspace"):WaitForChild("Homes"):WaitForChild(tostring(UserId)):WaitForChild("Util"):WaitForChild("Factory"):WaitForChild("SellArea"):WaitForChild("Stages")
local Bank = game:GetService("Workspace"):WaitForChild("Homes"):WaitForChild(tostring(UserId)):WaitForChild("Util"):WaitForChild("Bank"):WaitForChild("Areas")

local EnchantsBalance = {"Strength", "Protection", "Energized"}
local EnchantsGlass = {"Strength", "Energized", "Speed"}

local Message
local Case
local Pick
local Reason
local Pass
local Check
local Attack
local Health
local Price
local Slot

-- Functions
local mode = require(game:GetService("ReplicatedStorage").Modules.Services.ClientPickupsService)
mode["PICKUP_RANGE"] = math.huge

function Swap()
    for x=1, 3, 1 do
        args = {[1] = 1}
        game:GetService("Workspace"):WaitForChild("Homes"):WaitForChild(tostring(UserId)):WaitForChild("Util"):WaitForChild("MedBay"):WaitForChild("Stages"):WaitForChild(tostring(x)):WaitForChild("Events"):WaitForChild("SwapNoob"):InvokeServer(unpack(args))
    end
end

function FindCase(par)
    if Stages:WaitForChild(par):FindFirstChild("NoobCase") then
        return Stages:WaitForChild(par)
    end
end

function Webhook()
    if getgenv().Webhook then
        if not debounce then
            local response = syn.request(
                {
                    Url = getgenv().Webhook,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService('HttpService'):JSONEncode({content = Message})
                }
            );
            debounce = true
            wait(5)
            debounce = false
        end
    end
end

-- Main
local Main = Window:CreateTab("Main")

local MainSec1 = Main:CreateSection("Noob Farm")

local AutoDetect = Main:CreateToggle({
	Name = "Auto Detect",
	CurrentValue = getgenv().AutoDetect,
	Flag = "AutoDetect", 
	Callback = function(Value)
    	getgenv().AutoDetect = Value
	end,
})

local AutoBank = Main:CreateToggle({
	Name = "Auto Bank",
	CurrentValue = getgenv().AutoBank,
	Flag = "AutoBank", 
	Callback = function(Value)
    	getgenv().AutoBank = Value
	end,
})

local CheckEnchants = Main:CreateToggle({
	Name = "Check Enchants",
	CurrentValue = getgenv().CheckEnchants,
	Flag = "CheckEnchants", 
	Callback = function(Value)
    	getgenv().CheckEnchants = Value
	end,
})

local MainSec2 = Main:CreateSection("Config")

local MinStat = Main:CreateInput({
	Name = "Minimum Stat (Attack or Health)",
	PlaceholderText = getgenv().MinimumStat,
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		getgenv().MinimumStat = tonumber(Text)
		print("Minimum Stat set to: "..getgenv().MinimumStat)
	end,
})

local MinVal = Main:CreateInput({
	Name = "Minimum Value (x???)",
	PlaceholderText = getgenv().MinimumValue,
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		getgenv().MinimumValue = tonumber(Text)
		print("Minimum Value set to: "..getgenv().MinimumValue)
	end,
})

local EnchantType = Main:CreateDropdown({
	Name = "Enchantment Type",
	Options = {"Glass [Stre|Ener|Spee]","Balanced [Stre|Ener|Prot]", "Both"},
	CurrentOption = getgenv().EnchantType,
	Flag = "EnchantType",
	Callback = function(Option)
	  	  getgenv().EnchantType = Option
	  	  print("Enchantment Type set to: "..getgenv().EnchantType)
	end,
})

local FarmSlot = Main:CreateInput({
	Name = "Hotbar Slot used to farm",
	PlaceholderText = getgenv().FarmSlot,
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		getgenv().FarmSlot = tonumber(Text)
		print("Slot used to farm: "..getgenv().FarmSlot)
	end,
})

local ClassesKept = ""
for x=1, #getgenv().Noobs, 1 do
    ClassesKept = ClassesKept..getgenv().Noobs[x].."\n"
end
ClassesKept = ClassesKept.."\nEdit code to change"

local ClassInfo = Main:CreateParagraph({Title = "Keep Classes:", Content = ClassesKept})

local QualityInfo = Main:CreateParagraph({Title = "Ignored Qualities:", Content = getgenv().BadQuality[1].." to "..getgenv().BadQuality[#getgenv().BadQuality].."\n\nEdit code to change"})

-- Utilities
local Utilities = Window:CreateTab("Utilities")

local UtilitiesSec1 = Utilities:CreateSection("Utility")

local SwapToggle = Utilities:CreateKeybind({
	Name = "Swap Units",
	CurrentKeybind = "F",
	HoldToInteract = false,
	Flag = "SwapToggle",
	Callback = function(Keybind)
	    Swap()
    end,
})

local UtilitiesSec2 = Utilities:CreateSection("Auto Clicker")

local AutoE = Utilities:CreateToggle({
	Name = "Auto Spam E",
	CurrentValue = getgenv().AutoE,
	Flag = "AutoE", 
	Callback = function(Value)
    	getgenv().AutoE = Value
	end,
})

local AutoBuyValue = Utilities:CreateToggle({
	Name = "Auto Upgrade Evaluator (Uses Mouse)",
	CurrentValue = getgenv().AutoBuyValue,
	Flag = "AutoBuyValue", 
	Callback = function(Value)
    	getgenv().AutoBuyValue = Value
	end,
})
local ABV
local AutoBuyValueToggle = Utilities:CreateKeybind({
	Name = "Auto Upgrade Evaluator Toggle",
	CurrentKeybind = "G",
	HoldToInteract = false,
	Flag = "AutoBuyValueToggle",
	Callback = function(Keybind)
	    if getgenv().AutoBuyValue == true then
	        ABV = false
	    elseif getgenv().AutoBuyValue == false then
	        ABV = true
	    end
        
        getgenv().AutoBuyValue = ABV
	    AutoBuyValue:Set(ABV)
    end,
})

local UtilitiesSec3 = Utilities:CreateSection("Settings")

local Destroy = Utilities:CreateButton({
	Name = "Destroy UI",
	Callback = function()
		Rayfield:Destroy()
	end,
})

-- AutoFarm
coroutine.wrap(function()
    while wait() do
        if getgenv().AutoDetect == true then
            for x=1, 10, 1 do
                if FindCase(x) then
                    Pick = false
                    Case = FindCase(x)
                    Stats = FindCase(x):WaitForChild("NoobCase"):WaitForChild("LabelGui"):WaitForChild("Stats")
                    Class = Stats:WaitForChild("ClassTL").Text
                    Quality = Stats:WaitForChild("QualityTL").Text
                    Attack = tonumber(Stats:WaitForChild("AttackLabel"):WaitForChild("TextLabel").Text)
                    Health = tonumber(Stats:WaitForChild("ArmorLabel"):WaitForChild("TextLabel").Text)
                    Enchant1 = string.split(Stats:WaitForChild("EnchantmentTL1").Text, " ")[1]
                    Enchant2 = string.split(Stats:WaitForChild("EnchantmentTL2").Text, " ")[1]
                    Enchant3 = string.split(Stats:WaitForChild("EnchantmentTL3").Text, " ")[1]
                    Price = tonumber(string.split(string.split(Stats:WaitForChild("EvalTL").Text, "x")[2], ".")[1])
                    
                    -- Quality Check
                    
                    if not table.find(getgenv().BadQuality,Quality) then
                        if Attack >= getgenv().MinimumStat then
                            Pick = true
                            Reason = Attack.." Attack Stat"
                        end
                        
                        if Health >= getgenv().MinimumStat then
                            Pick = true
                            Reason = Health.." Health Stat"
                        end
                        
                        if Price >= getgenv().MinimumValue then
                            Pick = true
                            Reason = Price.." Value Multiplier"
                        end
                    end
                    
                    if getgenv().CheckEnchants == true then
                        if getgenv().EnchantType == "Balanced [Stre|Ener|Prot]" or "Both" then
                            if table.find(getgenv().Noobs, Class) then
                                if table.find(EnchantsBalance, Enchant1) then
                                    if table.find(EnchantsBalance, Enchant2) then
                                        if table.find(EnchantsBalance, Enchant3) then
                                            Pick = true
                                            Reason = "Balanced Enchants"
                                        end
                                    end
                                end
                            end    
                        end
                        if getgenv().EnchantType == "Glass [Stre|Ener|Spee]" or "Both" then
                            if table.find(getgenv().Noobs, Class) then
                                if table.find(EnchantsGlass, Enchant1) then
                                    if table.find(EnchantsGlass, Enchant2) then
                                        if table.find(EnchantsGlass, Enchant3) then
                                            Pick = true
                                            Reason = "Glass Cannon Enchants"
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    if Pick == true then
                        Message = "\n[ Unit Alert ]\nCase Number: "..x.."\nReason: "..Reason.."\n"
			print(Message)
                        if getgenv().AutoBank == false then
                            game:GetService("StarterGui"):SetCore("SendNotification",{
                                Title = "Unit Alert",
                                Text = "Case Number: "..x.." ["..Quality.."]\nReason: "..Reason,
                                Duration = 0.01
                            })
                        elseif getgenv().AutoBank == true then
                            game:GetService("StarterGui"):SetCore("SendNotification",{
                                Title = "Unit Alert",
                                Text = "Case Number: "..x.."\nReason: "..Reason,
                                Duration = 0.5
                            })
                            Case:WaitForChild("Events"):WaitForChild("EquipNoob"):InvokeServer()
                            Wait(0.5)
                        end
                    end
                    
                    if getgenv().AutoBank == true then
                        argSlot = {[1] = getgenv().FarmSlot}
                        for z=1, 8, 1 do
                            Bank:WaitForChild("2"):WaitForChild(tostring(z)):WaitForChild("Events"):WaitForChild("PlaceNoob"):InvokeServer(unpack(argSlot))
                        end
                        for z=1, 8, 1 do
                            Bank:WaitForChild("4"):WaitForChild(tostring(z)):WaitForChild("Events"):WaitForChild("PlaceNoob"):InvokeServer(unpack(argSlot))
                        end
                    end
                end
            end
            Wait(0.1)
        end
    end
end)()

coroutine.wrap(function()
    while wait() do
        if getgenv().AutoE == true then
            keypress(0x45)
            wait(0.1)
            keyrelease(0x45)
        end
    end
end)()

coroutine.wrap(function()
    while wait() do
        if getgenv().AutoBuyValue == true then
            mousemoveabs(428, 670)
            mousemoverel(1,1)
            mouse1click()
            
            Wait(0.5)
            
            mousemoveabs(861, 633)
            mousemoverel(1,1)
            mouse1click()
            
            Wait(1)
        end
    end
end)()
