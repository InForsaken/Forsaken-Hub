local versionx = "0.1"

Wait(10)

--[[
ESP + Chams

Fling /
]]

-- # Object Creation
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace") 
local plr = game:GetService("Players").LocalPlayer
local Player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
local Global = getgenv and getgenv() or _G

local bindtp
local bindfly
local bindtfly
local bindnc
local bindij
local bindctp

local bkeytp
local bkeyfly
local bkeytfly
local bkeync
local bkeyij
local bkeyctp

-- Loading Discord GUI
local exec = tostring(identifyexecutor())
local DiscordLib = loadstring(game:HttpGet "https://pastebin.com/raw/iXM5yY4w")()
local win = DiscordLib:Window("💫 Chronos GUI "..versionx.." - "..exec)

-- Sections
local mainserver = win:Server("Main Section     ", "http://www.roblox.com/asset/?id=11579310982")
local feserver = win:Server("Animations       ", "http://www.roblox.com/asset/?id=11585480207")
local adminserver = win:Server("Admin            ", "http://www.roblox.com/asset/?id=11579371312")

-- Subsections
local generaltab = mainserver:Channel("[][] General")
local localtab = mainserver:Channel("[][] Local Player")
local teleporttab = mainserver:Channel("[][] Teleport")
local esptab = mainserver:Channel("[][] ESP")
local utilitytab = mainserver:Channel("[][] Utility")
local keytab = mainserver:Channel("[][] Key Binds")

local sextab = feserver:Channel("[][] Sex")
local cooltab = feserver:Channel("[][] Cool")
local stoptab = feserver:Channel("[][] Stop")

local commandtab = adminserver:Channel("[][] Commands")
local creditstab = adminserver:Channel("[][] Credits")

-- # Setup Functions
local changews
local changejp
local togglewsjp
local CharParts = {}
getgenv().NoClip = false

-- WSJP On Death
Players.PlayerAdded:Connect(function(player)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    player.CharacterAdded:Connect(function(char)
        if togglewsjp == true then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = changews
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = changejp
        end
    end)
end)

-- Flight Functions
function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

local enableflight
local currentfly = false
local FLYING = false
local QEfly = true
local iyflyspeed = 1
local vehicleflyspeed = 1
local IYMouse = Players.LocalPlayer:GetMouse()
function sFLY(vfly)
	repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat wait() until IYMouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	local T = getRoot(Players.LocalPlayer.Character)
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0
	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

-- Infinite Jump Functions

local infjumpenabled = false

IYMouse.KeyDown:Connect(function(Key)
	if infjumpenabled == true and Key == " " then
		Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
	end
end)

-- NoClip Functions

function Phase()
	game:GetService("RunService").Stepped:connect(function()
    	if getgenv().NoClip then
        	for i = 1, #CharParts do
            	CharParts[i].CanCollide = false
        	end
    	end
	end)

	function SetupCharCollide(Char)
    	CharParts = {}
    	Char:WaitForChild("Head")
    	for i, v in pairs(Char:GetChildren()) do
        	if v:IsA("BasePart") then
        	    table.insert(CharParts, v)
        	end
    	end
	end

	if game.Players.LocalPlayer.Character then
    	SetupCharCollide(game.Players.LocalPlayer.Character)
	end
	game.Players.LocalPlayer.CharacterAdded:connect(function(Ch)
    	SetupCharCollide(Ch)
	end)
end

-- Click Teleport Functions
function GetCharacter()
	return game.Players.LocalPlayer.Character
 end
 
 function Teleport(pos)
	local Char = GetCharacter()
	if Char then
		Char:MoveTo(pos)
	end
 end
 
 
 UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		if clicktpenabled == true then
			Teleport(mouse.Hit.p)
		end
	end
 end)

-- ESP Functions



-- # Main Section
-- General
generaltab:Toggle("NoClip", false, function(nc)
	getgenv().NoClip = nc
	Phase()
end)

generaltab:Toggle("Infinite Jump", false, function(inf)
	infjumpenabled = inf
end)

generaltab:Toggle("Click TP", false, function(ctp)
	clicktpenabled = ctp
end)

generaltab:Toggle("Enable Fly: Press \"E\" to Toggle", false, function(toggle)
    enableflight = toggle
end)

mouse.KeyDown:connect(function(key)
    if enableflight == true then
        if key:lower() == "e" and currentfly == false then
            NOFLY()
	        wait()
	        sFLY()
            currentfly = true
        elseif key:lower() == "e" and currentfly == true then
            NOFLY()
            currentfly = false
        end
    end
end)

generaltab:Textbox("Set Flyspeed", "Default: 100", false, function(speed)
    iyflyspeed = speed / 100
end)

generaltab:Button("Respawn", function()
	game.Players.LocalPlayer.Character.Head:Destroy()
end)

-- Local Player Editor
localtab:Textbox("Change Walkspeed", "Enter Walkspeed", false, function(ws)
    changews = ws
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ws
end)
localtab:Textbox("Change Jump Power", "Enter Jump Power", false, function(jp)
    changejp = jp
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jp
end)
localtab:Toggle("Set on Death:", false, function(set)
    togglewsjp = set
end)
localtab:Button("Set Walkspeed + Jump Power", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = changews
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = changejp
end)
localtab:Button("Normal Walkspeed + Jump Power", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
end)

-- Teleporter
local playertable = {}
local displaytable = {}
local playerdisplay = {}
local targetuser

for i,v in pairs(game:GetService("Players"):GetDescendants()) do
   if v:IsA("Player") and v.Name ~= game:GetService("Players").LocalPlayer.Name then
       playertable[#playertable+1] = v.Name
       displaytable[#displaytable+1] = v.DisplayName
       playerdisplay[#playerdisplay+1] = "["..v.Name.."] "..v.DisplayName
   end
end

local tptarget = teleporttab:Dropdown(("Target User:                                                                      ["..#playerdisplay.."]"), playerdisplay, "Select a target", function(target)
    targetuser = target
end)

teleporttab:Button("Teleport", function()
    local pdlength = #playerdisplay
    for i = 0, pdlength, 1 do
        if targetuser == playerdisplay[i] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[playertable[i]].Character.HumanoidRootPart.CFrame
        end
    end
end)

--[[ Refresh Players Script, needs to be edited so it works
teleporttab:Button("Refresh Playerlist", function()
    tptarget:Clear()
    playertable = {}
    displaytable = {}
    playerdisplay = {}

    
    for i,v in pairs(game:GetService("Players"):GetDescendants()) do
        if v:IsA("Player") and v.Name ~= game:GetService("Players").LocalPlayer.Name then
            playertable[#playertable+1] = v.Name
            displaytable[#displaytable+1] = v.DisplayName
            playerdisplay[#playerdisplay+1] = "["..v.Name.."] "..v.DisplayName
            tptarget:Add(playerdisplay)
        end
     end
end)
]]

-- ESP Toggle
local enableesp = esptab:Toggle("Enable ESP", false)
local espchams = esptab:Toggle("CHAMS", false)
local espteam = esptab:Toggle("Show Team", false)
local espname = esptab:Toggle("Show Names", true)
local espdistance = esptab:Toggle("Show Distance", true)
local esphealth = esptab:Toggle("Show Health", true)
local esptracer = esptab:Toggle("Show Tracers", true)
local espbox = esptab:Toggle("Show Boxes", true)
local espoutline = esptab:Toggle("Text Outlines", true)

local espsize = esptab:Slider("Text Size", 10, 24, 18)
local espmax = esptab:Slider("Max Distance", 100, 5000, 2500)
local esprefresh = esptab:Slider("Refresh Rate (ms)", 1, 200, 5)



-- Utility Scripts
utilitytab:Button("Give BTools", function()
	local tool1 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
	local tool2 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
	local tool3 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
	local tool4 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
	local tool5 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
	tool1.BinType = "Clone"
	tool2.BinType = "GameTool"
	tool3.BinType = "Hammer"
	tool4.BinType = "Script"
	tool5.BinType = "Grab"
end)
utilitytab:Button("Clarify Client (Fog + Lighting)", function()
	loadstring(game:HttpGet "https://pastebin.com/raw/ec0AcW7a")()
end)
utilitytab:Button("Rejoin", function()
	wait(.1)
	game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
	while true do
		wait()
		game.Lighting.FogEnd = 1000000
		wait()
	end
end)

-- Key Binds
--[[
bindtp = keytab:Bind("Teleport", "T")
bindfly = keytab:Bind("Fly", "E")
bindtfly = keytab:Bind("Toggle Fly", "]")
bindnc = keytab:Bind("Toggle NoClip", "N")
bindij = keytab:Bind("Toggle Infinite Jump", "J")
bindctp = keytab:Bind("Click TP", "c")
generaltab:Button("GOOD UP TO HERE")
]]

-- # Filtering Enabled Section


-- FE Animations

sextab:Button("Fuck", function()
	stupid = Instance.new('Animation')
	stupid.AnimationId = 'rbxassetid://148840371'
	hummy = game:GetService("Players").LocalPlayer.Character.Humanoid
	pcall(function()
   		hummy.Parent.Pants:Destroy()
	end)

	pcall(function()
   		hummy.Parent.Shirt:Destroy()
	end)
	notfunny = hummy:LoadAnimation(stupid)
	notfunny:Play()
	notfunny:AdjustSpeed(10)
	while hummy.Parent.Parent ~= nil do
		wait()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Username.Text].Character.HumanoidRootPart.CFrame
	end
end)

cooltab:Button("Hatspin", function()
	local obese = game:GetService('Players')
for i,v in pairs(obese.LocalPlayer.Character:GetChildren()) do
if v.ClassName == "Accessory" then
local stg = v.Handle:FindFirstChildOfClass("BodyForce")
if stg == nil then
local a = Instance.new("BodyPosition")
local b = Instance.new("BodyAngularVelocity")
a.Parent = v.Handle
b.Parent = v.Handle
v.Handle.AccessoryWeld:Destroy()
b.AngularVelocity = Vector3.new(0,100,0)
b.MaxTorque = Vector3.new(0,200,0)
a.P = 30000
a.D = 50
game:GetService('RunService').Stepped:connect(function()
a.Position = obese.LocalPlayer.Character.Head.Position
end)
end
end
end
end)

--------------------------------------------------------------------------
sextab:Button("Basic Bang", function()
	local number = "4966833843"
	if Global.Dancing == true then
		lobal.Dancing = false
	end

	local aaa = 'rbxassetid://' .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua'))()
	end

	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService'TweenService'
	if game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator") then game.Players.LocalPlayer.Character.Humanoid.Animator:Destroy() end
	if game.Players.LocalPlayer.Character:FindFirstChild("Animate") then game.Players.LocalPlayer.Character:FindFirstChild("Animate"):Destroy() end
		local Joints = {
			["Torso"] = game.Players.LocalPlayer.Character.HumanoidRootPart["RootJoint"],
			["Right Arm"] =  game.Players.LocalPlayer.Character.Torso["Right Shoulder"],
			["Left Arm"] =  game.Players.LocalPlayer.Character.Torso["Left Shoulder"],
			["Head"] =  game.Players.LocalPlayer.Character.Torso["Neck"],
			["Left Leg"] =  game.Players.LocalPlayer.Character.Torso["Left Hip"],
			["Right Leg"] =  game.Players.LocalPlayer.Character.Torso["Right Hip"]
		}
		Global.dancing = true
		local speed = 1
		local keyframes = NeededAssets:GetKeyframes() -- get keyframes, this is better then getchildren bc it gets the correct order 
	repeat
		for ii,frame in pairs(keyframes) do -- for i,v on each keyframe to get each individual frame
			local duration = keyframes[ii+1] and keyframes[ii+1].Time - frame.Time or task.wait(1/120)
			print(tostring(duration))
			if keyframes[ii-1] then
				task.wait((frame.Time - keyframes[ii-1].Time)*speed)
			end
			for i,v in pairs(frame:GetDescendants()) do -- get each part in the frame
				if Joints[v.Name] then -- see if the part exists in the joint table
					TweenService:Create(Joints[v.Name],TweenInfo.new(duration*speed),{Transform = v.CFrame}):Play()
				end
			end
		end
		task.wait(1/120)
	until Global.dancing == false
end)

sextab:Button("Pushups", function()
	local number = "4966881089"

	if Global.Dancing == true then
		Global.Dancing = false
	end

	local aaa = 'rbxassetid://' .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua'))()
	end

	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService'TweenService'
	if game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator") then game.Players.LocalPlayer.Character.Humanoid.Animator:Destroy() end
	if game.Players.LocalPlayer.Character:FindFirstChild("Animate") then game.Players.LocalPlayer.Character:FindFirstChild("Animate"):Destroy() end
		local Joints = {
			["Torso"] = game.Players.LocalPlayer.Character.HumanoidRootPart["RootJoint"],
			["Right Arm"] =  game.Players.LocalPlayer.Character.Torso["Right Shoulder"],
			["Left Arm"] =  game.Players.LocalPlayer.Character.Torso["Left Shoulder"],
			["Head"] =  game.Players.LocalPlayer.Character.Torso["Neck"],
			["Left Leg"] =  game.Players.LocalPlayer.Character.Torso["Left Hip"],
			["Right Leg"] =  game.Players.LocalPlayer.Character.Torso["Right Hip"]
		}
		Global.dancing = true
		local speed = 1
		local keyframes = NeededAssets:GetKeyframes() -- get keyframes, this is better then getchildren bc it gets the correct order 
	repeat
		for ii,frame in pairs(keyframes) do -- for i,v on each keyframe to get each individual frame
			local duration = keyframes[ii+1] and keyframes[ii+1].Time - frame.Time or task.wait(1/120)
			print(tostring(duration))
			if keyframes[ii-1] then
				task.wait((frame.Time - keyframes[ii-1].Time)*speed)
			end
			for i,v in pairs(frame:GetDescendants()) do -- get each part in the frame
				if Joints[v.Name] then -- see if the part exists in the joint table
					TweenService:Create(Joints[v.Name],TweenInfo.new(duration*speed),{Transform = v.CFrame}):Play()
				end
			end
		end
		task.wait(1/120)
	until Global.dancing == false
end)

sextab:Button("Bend Over", function()
	local number = "4966882047"

	if Global.Dancing == true then
		Global.Dancing = false
	end

	local aaa = 'rbxassetid://' .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua'))()
	end

	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService'TweenService'
	if game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator") then game.Players.LocalPlayer.Character.Humanoid.Animator:Destroy() end
	if game.Players.LocalPlayer.Character:FindFirstChild("Animate") then game.Players.LocalPlayer.Character:FindFirstChild("Animate"):Destroy() end
		local Joints = {
			["Torso"] = game.Players.LocalPlayer.Character.HumanoidRootPart["RootJoint"],
			["Right Arm"] =  game.Players.LocalPlayer.Character.Torso["Right Shoulder"],
			["Left Arm"] =  game.Players.LocalPlayer.Character.Torso["Left Shoulder"],
			["Head"] =  game.Players.LocalPlayer.Character.Torso["Neck"],
			["Left Leg"] =  game.Players.LocalPlayer.Character.Torso["Left Hip"],
			["Right Leg"] =  game.Players.LocalPlayer.Character.Torso["Right Hip"]
		}
		Global.dancing = true
		local speed = 1
		local keyframes = NeededAssets:GetKeyframes() -- get keyframes, this is better then getchildren bc it gets the correct order 
	repeat
		for ii,frame in pairs(keyframes) do -- for i,v on each keyframe to get each individual frame
			local duration = keyframes[ii+1] and keyframes[ii+1].Time - frame.Time or task.wait(1/120)
			print(tostring(duration))
			if keyframes[ii-1] then
				task.wait((frame.Time - keyframes[ii-1].Time)*speed)
			end
			for i,v in pairs(frame:GetDescendants()) do -- get each part in the frame
				if Joints[v.Name] then -- see if the part exists in the joint table
					TweenService:Create(Joints[v.Name],TweenInfo.new(duration*speed),{Transform = v.CFrame}):Play()
				end
			end
		end
		task.wait(1/120)
	until Global.dancing == false
end)

sextab:Button("Lay Down", function()
	local number = "4966879039"

	if Global.Dancing == true then
		Global.Dancing = false
	end

	local aaa = 'rbxassetid://' .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua'))()
	end

	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService'TweenService'
	if game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator") then game.Players.LocalPlayer.Character.Humanoid.Animator:Destroy() end
	if game.Players.LocalPlayer.Character:FindFirstChild("Animate") then game.Players.LocalPlayer.Character:FindFirstChild("Animate"):Destroy() end
		local Joints = {
			["Torso"] = game.Players.LocalPlayer.Character.HumanoidRootPart["RootJoint"],
			["Right Arm"] =  game.Players.LocalPlayer.Character.Torso["Right Shoulder"],
			["Left Arm"] =  game.Players.LocalPlayer.Character.Torso["Left Shoulder"],
			["Head"] =  game.Players.LocalPlayer.Character.Torso["Neck"],
			["Left Leg"] =  game.Players.LocalPlayer.Character.Torso["Left Hip"],
			["Right Leg"] =  game.Players.LocalPlayer.Character.Torso["Right Hip"]
		}
		Global.dancing = true
		local speed = 1
		local keyframes = NeededAssets:GetKeyframes() -- get keyframes, this is better then getchildren bc it gets the correct order 
	repeat
		for ii,frame in pairs(keyframes) do -- for i,v on each keyframe to get each individual frame
			local duration = keyframes[ii+1] and keyframes[ii+1].Time - frame.Time or task.wait(1/120)
			print(tostring(duration))
			if keyframes[ii-1] then
				task.wait((frame.Time - keyframes[ii-1].Time)*speed)
			end
			for i,v in pairs(frame:GetDescendants()) do -- get each part in the frame
				if Joints[v.Name] then -- see if the part exists in the joint table
					TweenService:Create(Joints[v.Name],TweenInfo.new(duration*speed),{Transform = v.CFrame}):Play()
				end
			end
		end
		task.wait(1/120)
	until Global.dancing == false
end)

sextab:Button("Blowjob", function()
	local number = "4963373273"

	if Global.Dancing == true then
		Global.Dancing = false
	end

	local aaa = 'rbxassetid://' .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua'))()
	end

	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService'TweenService'
	if game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator") then game.Players.LocalPlayer.Character.Humanoid.Animator:Destroy() end
	if game.Players.LocalPlayer.Character:FindFirstChild("Animate") then game.Players.LocalPlayer.Character:FindFirstChild("Animate"):Destroy() end
		local Joints = {
			["Torso"] = game.Players.LocalPlayer.Character.HumanoidRootPart["RootJoint"],
			["Right Arm"] =  game.Players.LocalPlayer.Character.Torso["Right Shoulder"],
			["Left Arm"] =  game.Players.LocalPlayer.Character.Torso["Left Shoulder"],
			["Head"] =  game.Players.LocalPlayer.Character.Torso["Neck"],
			["Left Leg"] =  game.Players.LocalPlayer.Character.Torso["Left Hip"],
			["Right Leg"] =  game.Players.LocalPlayer.Character.Torso["Right Hip"]
		}
		Global.dancing = true
		local speed = 1
		local keyframes = NeededAssets:GetKeyframes() -- get keyframes, this is better then getchildren bc it gets the correct order 
	repeat
		for ii,frame in pairs(keyframes) do -- for i,v on each keyframe to get each individual frame
			local duration = keyframes[ii+1] and keyframes[ii+1].Time - frame.Time or task.wait(1/120)
			print(tostring(duration))
			if keyframes[ii-1] then
				task.wait((frame.Time - keyframes[ii-1].Time)*speed)
			end
			for i,v in pairs(frame:GetDescendants()) do -- get each part in the frame
				if Joints[v.Name] then -- see if the part exists in the joint table
					TweenService:Create(Joints[v.Name],TweenInfo.new(duration*speed),{Transform = v.CFrame}):Play()
				end
			end
		end
		task.wait(1/120)
	until Global.dancing == false
end)

stoptab:Button("Stop Animation", function()
	Global.dancing = false
end)
-----------------------------------------------------------------------------
-- # Admin Section
-- Infinite Yield
commandtab:Button("Load Infinite Yield", function()
    loadstring(game:HttpGet "https://pastebin.com/raw/xNAEvCXE")()
end)

-- Reviz Admin
commandtab:Button("Load Reviz Admin", function()
    loadstring(game:HttpGet "https://pastebin.com/raw/yGS0j7mT")()
end)

-- Developer Credits
creditstab:Label("Script Developer: InForsaken#3634")
creditstab:Button("👉 Copy Official Discord Link!", function()
    setclipboard("https://discord.gg/QEQ5Se2V")
    DiscordLib:Notification("Copied!!", "✔ Discord Invite Link Has Been Copied To Your Clipboard!!", "Okay!")
end)

-- # Script Utility
--[[
    Anti AFK
]]

-- Anti AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)

    game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
end)

-- Check if loaded correctly
creditstab:Label("Script loaded successfully!")
