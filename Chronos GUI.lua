local versionx = "0.6"

--[[
Chams
Fling
]]

---// Loading Section \\---
repeat task.wait() until game:IsLoaded()

-- # Object Creation
local Global = getgenv and getgenv() or _G
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace") 
local LocalPlayer = game:GetService("Players").LocalPlayer
local Player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GUIService = game:GetService("GuiService")
local Mouse = game.Players.LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local PlayerMouse = LocalPlayer:GetMouse();
local Menu = {};
local MouseHeld = false;
local LastRefresh = 0;
local OptionsFile = 'IC3_ESP_SETTINGS.dat';
local Binding = false;
local BindedKey = nil;
local OIndex = 0;
local LineBox = {};
local UIButtons = {};
local Sliders = {};
local Dragging = false;
local DraggingUI = false;
local DragOffset = Vector2.new();
local DraggingWhat = nil;
local OldData = {};
local IgnoreList = {};
local Red = Color3.new(1, 0, 0);
local Green = Color3.new(0, 1, 0);
local MenuLoaded = false;

local bindtp = "="
local bindfly = "E"
local bindnc = "B"
local bindctp = "V"
local bindsp = "X"

-- Loading Discord GUI
local exec = tostring(identifyexecutor())
local DiscordLib = loadstring(game:HttpGet "https://pastebin.com/raw/iXM5yY4w")()
local win = DiscordLib:Window("💫 Chronos GUI "..versionx.." - "..exec)

-- Sections
local mainserver = win:Server("Main Section     ", "http://www.roblox.com/asset/?id=11579310982")
local feserver = win:Server("Animations       ", "http://www.roblox.com/asset/?id=11585480207")
local adminserver = win:Server("Admin            ", "http://www.roblox.com/asset/?id=11579371312")

-- Subsections
local generaltab = mainserver:Channel("🌍 General")
local localtab = mainserver:Channel("👷 Local Player")
local teleporttab = mainserver:Channel("💨 Teleport")
local esptab = mainserver:Channel("💥 ESP")
local utilitytab = mainserver:Channel("🔨 Utility")
-- local keytab = mainserver:Channel("🔑 Key Binds")

local sextab = feserver:Channel("🍆 Sex")
local cooltab = feserver:Channel("🔥 Cool")
local stoptab = feserver:Channel("✋ Stop")

local commandtab = adminserver:Channel("📜 Commands")
local creditstab = adminserver:Channel("✨ Credits")

-- # Setup Functions
local changews
local changejp
local togglewsjp
local CharParts = {}
getgenv().NoClip = false

-- WSJP On Death
--[[
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
]]

-- Flight Functions
function getRoot(char)
	local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
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
		local BG = Instance.new("BodyGyro")
		local BV = Instance.new("BodyVelocity")
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
					Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
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
			if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == "w" then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == "s" then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == "a" then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == "d" then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == "e" then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == "q" then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == "w" then
			CONTROL.F = 0
		elseif KEY:lower() == "s" then
			CONTROL.B = 0
		elseif KEY:lower() == "a" then
			CONTROL.L = 0
		elseif KEY:lower() == "d" then
			CONTROL.R = 0
		elseif KEY:lower() == "e" then
			CONTROL.Q = 0
		elseif KEY:lower() == "q" then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

-- Infinite Jump Functions

local infjumpenabled = false

IYMouse.KeyDown:Connect(function(Key)
	if infjumpenabled == true and Key == " " then
		Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
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

local ncenabled = false
local clip = false

IYMouse.KeyDown:Connect(function(Key)
	if ncenabled == true and Key == "b" then
        if clip == true then
            getgenv().NoClip = false
	        Phase()
            clip = false
        elseif clip == false then
            getgenv().NoClip = true
	        Phase()
            clip = true
        end
	end
end)

-- Click Teleport Functions
function GetCharacter()
	return game.Players.LocalPlayer.Character
 end
 
 function Teleport(pos)
	local Char = GetCharacter()
	if Char then
		Char:MoveTo(Vector3.new(pos.x, pos.y + 5, pos.z)) 
	end
 end
 
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		if clicktpenabled == true then
			Teleport(Mouse.Hit)
		end
	end
 end)

IYMouse.KeyDown:Connect(function(Key)
	if clicktpenabled == true and Key == "v" then
		Teleport(Mouse.Hit)
	end
end)

-- Sprint Function
local sprintenabled = false
local fast = false

IYMouse.KeyDown:Connect(function(Key)
	if sprintenabled == true and Key == "x" then
        if fast == true then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            fast = false
        elseif fast == false then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 60
            fast = true
        end
	end
end)

 --[[
 Hold CTRL + Click
 UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		if clicktpenabled == true then
			Teleport(Mouse.Hit.p)
		end
	end
 end)
]]

-- ESP Functions

shared.MenuDrawingData = shared.MenuDrawingData or { Instances = {} };
shared.PlayerData = shared.PlayerData or {};
shared.RSName = shared.RSName or ("UnnamedESP_by_ic3-" .. HttpService:GenerateGUID(false));

local GetDataName = shared.RSName .. "-GetData";
local UpdateName = shared.RSName .. "-Update";

local Debounce = setmetatable({}, {
    __index = function(t, i)
    return rawget(t, i) or false
    end;
});

pcall(function() shared.InputBeganCon:disconnect() end);
pcall(function() shared.InputEndedCon:disconnect() end);

function GetMouseLocation()
    return UserInputService:GetMouseLocation();
end

function MouseHoveringOver(Values)
    local X1, Y1, X2, Y2 = Values[1], Values[2], Values[3], Values[4]
    local MLocation = GetMouseLocation();
    return (MLocation.x >= X1 and MLocation.x <= (X1 + (X2 - X1))) and (MLocation.y >= Y1 and MLocation.y <= (Y1 + (Y2 - Y1)));
end

function GetTableData(t) -- basically table.foreach i dont even know why i made this
    if typeof(t) ~= "table" then return end
    return setmetatable(t, {
        __call = function(t, func)
        if typeof(func) ~= "function" then return end;
        for i, v in pairs(t) do
            pcall(func, i, v);
        end
        end;
    });
end
local function Format(format, ...)
    return string.format(format, ...);
end
function CalculateValue(Min, Max, Percent)
    return Min + math.floor(((Max - Min) * Percent) + .5);
end

local Options = setmetatable({}, {
    __call = function(t, ...)
    local Arguments = {...};
    local Name = Arguments[1];
    OIndex = OIndex + 1; -- (typeof(Arguments[3]) == "boolean" and 1 or 0);
    rawset(t, Name, setmetatable({
        Name = Arguments[1];
        Text = Arguments[2];
        Value = Arguments[3];
        DefaultValue = Arguments[3];
        AllArgs = Arguments;
        Index = OIndex;
    }, {
    __call = function(t, v)
    if typeof(t.Value) == "function" then
        t.Value();
    elseif typeof(t.Value) == "EnumItem" then
        local BT = Menu:GetInstance(Format("%s_BindText", t.Name));
        Binding = true;
        local Val = 0
        while Binding do
            wait();
            Val = (Val + 1) % 17;
            BT.Text = Val <= 8 and "|" or "";
        end
        t.Value = BindedKey;
        BT.Text = tostring(t.Value):match"%w+%.%w+%.(.+)";
        BT.Position = t.BasePosition + Vector2.new(t.BaseSize.X - BT.TextBounds.X - 20, -10);
    else
        local NewValue = v;
        if NewValue == nil then NewValue = not t.Value; end
        rawset(t, "Value", NewValue);
        if Arguments[2] ~= nil then
            if typeof(Arguments[3]) == "number" then
                local AMT = Menu:GetInstance(Format("%s_AmountText", t.Name));
                AMT.Text = tostring(t.Value);
                AMT.Position = t.BasePosition + Vector2.new(t.BaseSize.X - AMT.TextBounds.X - 10, -10);
            else
                local Inner = Menu:GetInstance(Format("%s_InnerCircle", t.Name));
                Inner.Visible = t.Value;
            end
        end
    end
    end;
}));
end;
})


function Load()
local _, Result = pcall(readfile, OptionsFile);
if _ then -- extremely ugly code yea i know but i dont care p.s. i hate pcall
    local _, Table = pcall(HttpService.JSONDecode, HttpService, Result);
    if _ then
        for i, v in pairs(Table) do
            if Options[i] ~= nil and Options[i].Value ~= nil and (typeof(Options[i].Value) == "boolean" or typeof(Options[i].Value) == "number") then
                Options[i].Value = v.Value;
                pcall(Options[i], v.Value);
            end
        end
    end
end
end

Options("Enabled", "ESP Enabled", false);
Options("ShowTeam", "Show Team", false);
Options("ShowName", "Show Names", true);
Options("ShowDistance", "Show Distance", true);
Options("ShowHealth", "Show Health", true);
Options("ShowBoxes", "Show Boxes", true);
Options("ShowTracers", "Show Tracers", true);
Options("ShowDot", "Show Head Dot", false);
Options("VisCheck", "Visibility Check", false);
Options("Crosshair", "Crosshair", false);
Options("TextOutline", "Text Outline", true);
Options("TextSize", "Text Size", syn and 18 or 14, 10, 24); -- cuz synapse fonts look weird???
Options("MaxDistance", "Max Distance", 2500, 100, 5000);
Options("RefreshRate", "Refresh Rate (ms)", 5, 1, 200);
Options("MenuKey", "Menu Key", Enum.KeyCode.F4, 1);
Options("ResetSettings", "Reset Settings", function()
for i, v in pairs(Options) do
if Options[i] ~= nil and Options[i].Value ~= nil and Options[i].Text ~= nil and (typeof(Options[i].Value) == "boolean" or typeof(Options[i].Value) == "number") then
    Options[i](Options[i].DefaultValue);
end
end
end, 4);
Options("LoadSettings", "Load Settings", Load, 3);
Options("SaveSettings", "Save Settings", function()
writefile(OptionsFile, HttpService:JSONEncode(Options));
end, 2)
-- Options.SaveSettings.Value();

Load();

Options("MenuOpen", nil, false);

local function Set(t, i, v)
t[i] = v;
end
local function Combine(...)
local Output = {};
for i, v in pairs{...} do
    if typeof(v) == "table" then
        table.foreach(v, function(i, v)
        Output[i] = v;
        end)
    end
end
return Output
end
function IsStringEmpty(String)
if type(String) == "string" then
    return String:match"^%s+$" ~= nil or #String == 0 or String == "" or false;
end
return false
end

function NewDrawing(InstanceName)
local Instance = Drawing.new(InstanceName);
return (function(Properties)
for i, v in pairs(Properties) do
    pcall(Set, Instance, i, v);
end
return Instance;
end)
end

function Menu:AddMenuInstace(Name, Instance)
if shared.MenuDrawingData.Instances[Name] ~= nil then
    shared.MenuDrawingData.Instances[Name]:Remove();
end
shared.MenuDrawingData.Instances[Name] = Instance;
return Instance;
end
function Menu:UpdateMenuInstance(Name)
local Instance = shared.MenuDrawingData.Instances[Name];
if Instance ~= nil then
    return (function(Properties)
    for i, v in pairs(Properties) do
        -- print(Format("%s %s -> %s", Name, tostring(i), tostring(v)));
        pcall(Set, Instance, i, v);
    end
    return Instance;
    end)
end
end
function Menu:GetInstance(Name)
return shared.MenuDrawingData.Instances[Name];
end

-- Load ESP
Options.Enabled.Value = false
Options.TextOutline.Value = true

function LineBox:Create(Properties)
local Box = { Visible = true }; -- prevent errors not really though dont worry bout the Visible = true thing

local Properties = Combine({
    Transparency = 1;
    Thickness = 1;
    Visible = true;
}, Properties);

Box["TopLeft"] = NewDrawing"Line"(Properties);
Box["TopRight"] = NewDrawing"Line"(Properties);
Box["BottomLeft"] = NewDrawing"Line"(Properties);
Box["BottomRight"] = NewDrawing"Line"(Properties);

function Box:Update(CF, Size, Color, Properties)
    if not CF or not Size then return end

    local TLPos, Visible1 = Camera:WorldToViewportPoint((CF * CFrame.new( Size.X,  Size.Y, 0)).p);
    local TRPos, Visible2 = Camera:WorldToViewportPoint((CF * CFrame.new(-Size.X,  Size.Y, 0)).p);
    local BLPos, Visible3 = Camera:WorldToViewportPoint((CF * CFrame.new( Size.X, -Size.Y, 0)).p);
    local BRPos, Visible4 = Camera:WorldToViewportPoint((CF * CFrame.new(-Size.X, -Size.Y, 0)).p);
    -- ## BEGIN UGLY CODE
    if Visible1 then
        Box["TopLeft"].Visible = true;
        Box["TopLeft"].Color = Color;
        Box["TopLeft"].From = Vector2.new(TLPos.X, TLPos.Y);
        Box["TopLeft"].To = Vector2.new(TRPos.X, TRPos.Y);
    else
        Box["TopLeft"].Visible = false;
    end
    if Visible2 then
        Box["TopRight"].Visible = true;
        Box["TopRight"].Color = Color;
        Box["TopRight"].From = Vector2.new(TRPos.X, TRPos.Y);
        Box["TopRight"].To = Vector2.new(BRPos.X, BRPos.Y);
    else
        Box["TopRight"].Visible = false;
    end
    if Visible3 then
        Box["BottomLeft"].Visible = true;
        Box["BottomLeft"].Color = Color;
        Box["BottomLeft"].From = Vector2.new(BLPos.X, BLPos.Y);
        Box["BottomLeft"].To = Vector2.new(TLPos.X, TLPos.Y);
    else
        Box["BottomLeft"].Visible = false;
    end
    if Visible4 then
        Box["BottomRight"].Visible = true;
        Box["BottomRight"].Color = Color;
        Box["BottomRight"].From = Vector2.new(BRPos.X, BRPos.Y);
        Box["BottomRight"].To = Vector2.new(BLPos.X, BLPos.Y);
    else
        Box["BottomRight"].Visible = false;
    end
    -- ## END UGLY CODE
    if Properties then
        GetTableData(Properties)(function(i, v)
        pcall(Set, Box["TopLeft"], i, v);
        pcall(Set, Box["TopRight"], i, v);
        pcall(Set, Box["BottomLeft"], i, v);
        pcall(Set, Box["BottomRight"], i, v);
        end)
    end
end
function Box:SetVisible(bool)
    pcall(Set, Box["TopLeft"], "Visible", bool);
    pcall(Set, Box["TopRight"], "Visible", bool);
    pcall(Set, Box["BottomLeft"], "Visible", bool);
    pcall(Set, Box["BottomRight"], "Visible", bool);
end
function Box:Remove()
    self:SetVisible(false);
    Box["TopLeft"]:Remove();
    Box["TopRight"]:Remove();
    Box["BottomLeft"]:Remove();
    Box["BottomRight"]:Remove();
end

return Box;
end

function CreateMenu(NewPosition) -- Create Menu
local function FromHex(HEX)
    HEX = HEX:gsub("#", "");
    return Color3.fromRGB(tonumber("0x" .. HEX:sub(1, 2)), tonumber("0x" .. HEX:sub(3, 4)), tonumber("0x" .. HEX:sub(5, 6)));
end

local Colors = {
    Primary = {
        Main = FromHex"424242";
        Light = FromHex"6d6d6d";
        Dark = FromHex"1b1b1b";
    };
    Secondary = {
        Main = FromHex"e0e0e0";
        Light = FromHex"ffffff";
        Dark = FromHex"aeaeae";
    };
};

MenuLoaded = false;

GetTableData(UIButtons)(function(i, v)
v.Instance.Visible = false;
v.Instance:Remove();
end)
GetTableData(Sliders)(function(i, v)
v.Instance.Visible = false;
v.Instance:Remove();
end)

UIButtons = {};
Sliders = {};

local BaseSize = Vector2.new(300, 580);
local BasePosition = NewPosition or Vector2.new(Camera.ViewportSize.X / 8 - (BaseSize.X / 2), Camera.ViewportSize.Y / 2 - (BaseSize.Y / 2));

Menu:AddMenuInstace("CrosshairX", NewDrawing"Line"{
    Visible = false;
    Color = Color3.new(0, 1, 0);
    Transparency = 1;
    Thickness = 1;
});
Menu:AddMenuInstace("CrosshairY", NewDrawing"Line"{
    Visible = false;
    Color = Color3.new(0, 1, 0);
    Transparency = 1;
    Thickness = 1;
});

delay(.025, function() -- since zindex doesnt exist
Menu:AddMenuInstace("Main", NewDrawing"Square"{
    Size = BaseSize;
    Position = BasePosition;
    Filled = false;
    Color = Colors.Primary.Main;
    Thickness = 3;
    Visible = true;
});
end);
Menu:AddMenuInstace("TopBar", NewDrawing"Square"{
    Position = BasePosition;
    Size = Vector2.new(BaseSize.X, 25);
    Color = Colors.Primary.Dark;
    Filled = true;
    Visible = true;
});
Menu:AddMenuInstace("TopBarTwo", NewDrawing"Square"{
    Position = BasePosition + Vector2.new(0, 25);
    Size = Vector2.new(BaseSize.X, 60);
    Color = Colors.Primary.Main;
    Filled = true;
    Visible = true;
});
Menu:AddMenuInstace("TopBarText", NewDrawing"Text"{
    Size = 25;
    Position = shared.MenuDrawingData.Instances.TopBarTwo.Position + Vector2.new(25, 15);
    Text = "Unnamed ESP";
    Color = Colors.Secondary.Light;
    Visible = true;
});
Menu:AddMenuInstace("TopBarTextBR", NewDrawing"Text"{
    Size = 15;
    Position = shared.MenuDrawingData.Instances.TopBarTwo.Position + Vector2.new(BaseSize.X - 65, 40);
    Text = "by InForsaken";
    Color = Colors.Secondary.Dark;
    Visible = true;
});
Menu:AddMenuInstace("Filling", NewDrawing"Square"{
    Size = BaseSize - Vector2.new(0, 85);
    Position = BasePosition + Vector2.new(0, 85);
    Filled = true;
    Color = Colors.Secondary.Main;
    Transparency= .5;
    Visible = true;
});

local CPos = 0;

GetTableData(Options)(function(i, v)
if typeof(v.Value) == "boolean" and not IsStringEmpty(v.Text) and v.Text ~= nil then
    CPos = CPos + 25;
    local BaseSize = Vector2.new(BaseSize.X, 30);
    local BasePosition = shared.MenuDrawingData.Instances.Filling.Position + Vector2.new(30, v.Index * 25 - 10);
    UIButtons[#UIButtons + 1] = {
        Option = v;
        Instance = Menu:AddMenuInstace(Format("%s_Hitbox", v.Name), NewDrawing"Square"{
            Position = BasePosition - Vector2.new(30, 15);
            Size = BaseSize;
            Visible = false;
        });
    };
    Menu:AddMenuInstace(Format("%s_OuterCircle", v.Name), NewDrawing"Circle"{
        Radius = 10;
        Position = BasePosition;
        Color = Colors.Secondary.Light;
        Filled = true;
        Visible = true;
    });
    Menu:AddMenuInstace(Format("%s_InnerCircle", v.Name), NewDrawing"Circle"{
        Radius = 7;
        Position = BasePosition;
        Color = Colors.Secondary.Dark;
        Filled = true;
        Visible = v.Value;
    });
    Menu:AddMenuInstace(Format("%s_Text", v.Name), NewDrawing"Text"{
        Text = v.Text;
        Size = 20;
        Position = BasePosition + Vector2.new(20, -10);
        Visible = true;
        Color = Colors.Primary.Dark;
    });
end
end)
GetTableData(Options)(function(i, v) -- just to make sure certain things are drawn before or after others, too lazy to actually sort table
if typeof(v.Value) == "number" then
    CPos = CPos + 25;

    local BaseSize = Vector2.new(BaseSize.X, 30);
    local BasePosition = shared.MenuDrawingData.Instances.Filling.Position + Vector2.new(0, CPos - 10);

    local Text = Menu:AddMenuInstace(Format("%s_Text", v.Name), NewDrawing"Text"{
        Text = v.Text;
        Size = 20;
        Position = BasePosition + Vector2.new(20, -10);
        Visible = true;
        Color = Colors.Primary.Dark;
    });
    local AMT = Menu:AddMenuInstace(Format("%s_AmountText", v.Name), NewDrawing"Text"{
        Text = tostring(v.Value);
        Size = 20;
        Position = BasePosition;
        Visible = true;
        Color = Colors.Primary.Dark;
    });
    local Line = Menu:AddMenuInstace(Format("%s_SliderLine", v.Name), NewDrawing"Line"{
        Transparency = 1;
        Color = Colors.Primary.Dark;
        Thickness = 3;
        Visible = true;
        From = BasePosition + Vector2.new(20, 20);
        To = BasePosition + Vector2.new(BaseSize.X - 10, 20);
    });
    CPos = CPos + 10;
    local Slider = Menu:AddMenuInstace(Format("%s_Slider", v.Name), NewDrawing"Circle"{
        Visible = true;
        Filled = true;
        Radius = 6;
        Color = Colors.Secondary.Dark;
        Position = BasePosition + Vector2.new(35, 20);
    })

    local CSlider = {Slider = Slider; Line = Line; Min = v.AllArgs[4]; Max = v.AllArgs[5]; Option = v};
    Sliders[#Sliders + 1] = CSlider;

    -- local Percent = (v.Value / CSlider.Max) * 100;
    -- local Size = math.abs(Line.From.X - Line.To.X);
    -- local Value = Size * (Percent / 100); -- this shit"s inaccurate but fuck it i"m not even gonna bother fixing it

    Slider.Position = BasePosition + Vector2.new(40, 20);

    v.BaseSize = BaseSize;
    v.BasePosition = BasePosition;
    AMT.Position = BasePosition + Vector2.new(BaseSize.X - AMT.TextBounds.X - 10, -10)
end
end)
GetTableData(Options)(function(i, v) -- just to make sure certain things are drawn before or after others, too lazy to actually sort table
if typeof(v.Value) == "EnumItem" then
    CPos = CPos + 30;

    local BaseSize = Vector2.new(BaseSize.X, 30);
    local BasePosition = shared.MenuDrawingData.Instances.Filling.Position + Vector2.new(0, CPos - 10);

    UIButtons[#UIButtons + 1] = {
        Option = v;
        Instance = Menu:AddMenuInstace(Format("%s_Hitbox", v.Name), NewDrawing"Square"{
            Size = Vector2.new(BaseSize.X, 20) - Vector2.new(30, 0);
            Visible = true;
            Transparency= .5;
            Position = BasePosition + Vector2.new(15, -10);
            Color = Colors.Secondary.Light;
            Filled = true;
        });
    };
    local Text = Menu:AddMenuInstace(Format("%s_Text", v.Name), NewDrawing"Text"{
        Text = v.Text;
        Size = 20;
        Position = BasePosition + Vector2.new(20, -10);
        Visible = true;
        Color = Colors.Primary.Dark;
    });
    local BindText = Menu:AddMenuInstace(Format("%s_BindText", v.Name), NewDrawing"Text"{
        Text = tostring(v.Value):match"%w+%.%w+%.(.+)";
        Size = 20;
        Position = BasePosition;
        Visible = true;
        Color = Colors.Primary.Dark;
    });

    Options[i].BaseSize = BaseSize;
    Options[i].BasePosition = BasePosition;
    BindText.Position = BasePosition + Vector2.new(BaseSize.X - BindText.TextBounds.X - 20, -10);
end
end)
GetTableData(Options)(function(i, v) -- just to make sure certain things are drawn before or after others, too lazy to actually sort table
if typeof(v.Value) == "function" then
    local BaseSize = Vector2.new(BaseSize.X, 30);
    local BasePosition = shared.MenuDrawingData.Instances.Filling.Position + Vector2.new(0, CPos + (25 * v.AllArgs[4]) - 35);

    UIButtons[#UIButtons + 1] = {
        Option = v;
        Instance = Menu:AddMenuInstace(Format("%s_Hitbox", v.Name), NewDrawing"Square"{
            Size = Vector2.new(BaseSize.X, 20) - Vector2.new(30, 0);
            Visible = true;
            Transparency= .5;
            Position = BasePosition + Vector2.new(15, -10);
            Color = Colors.Secondary.Light;
            Filled = true;
        });
    };
    local Text = Menu:AddMenuInstace(Format("%s_Text", v.Name), NewDrawing"Text"{
        Text = v.Text;
        Size = 20;
        Position = BasePosition + Vector2.new(20, -10);
        Visible = true;
        Color = Colors.Primary.Dark;
    });

    -- BindText.Position = BasePosition + Vector2.new(BaseSize.X - BindText.TextBounds.X - 10, -10);
end
end)

delay(.1, function()
MenuLoaded = false;
end);

-- this has to be at the bottom cuz proto drawing api doesnt have zindex :triumph:
Menu:AddMenuInstace("Cursor1", NewDrawing"Line"{
    Visible = false;
    Color = Color3.new(1, 0, 0);
    Transparency = 1;
    Thickness = 2;
});
Menu:AddMenuInstace("Cursor2", NewDrawing"Line"{
    Visible = false;
    Color = Color3.new(1, 0, 0);
    Transparency = 1;
    Thickness = 2;
});
Menu:AddMenuInstace("Cursor3", NewDrawing"Line"{
    Visible = false;
    Color = Color3.new(1, 0, 0);
    Transparency = 1;
    Thickness = 2;
});
end

shared.InputBeganCon = UserInputService.InputBegan:connect(function(input)
if input.UserInputType.Name == "MouseButton1" and Options.MenuOpen.Value then
MouseHeld = true;
local Bar = Menu:GetInstance"TopBar";
local Values = {
    Bar.Position.X;
    Bar.Position.Y;
    Bar.Position.X + Bar.Size.X;
    Bar.Position.Y + Bar.Size.Y;
}
if MouseHoveringOver(Values) and not syn then -- disable dragging for synapse cuz idk why it breaks
    DraggingUI = false; -- also breaks for other exploits
    DragOffset = Menu:GetInstance"Main".Position - GetMouseLocation();
else
    for i, v in pairs(Sliders) do
        local Values = {
            v.Line.From.X - (v.Slider.Radius);
            v.Line.From.Y - (v.Slider.Radius);
            v.Line.To.X + (v.Slider.Radius);
            v.Line.To.Y + (v.Slider.Radius);
        };
        if MouseHoveringOver(Values) then
            DraggingWhat = v;
            Dragging = true;
            break
        end
    end
end
end
end)
shared.InputEndedCon = UserInputService.InputEnded:connect(function(input)
if input.UserInputType.Name == "MouseButton1" and Options.MenuOpen.Value then
MouseHeld = false;
for i, v in pairs(UIButtons) do
    local Values = {
        v.Instance.Position.X;
        v.Instance.Position.Y;
        v.Instance.Position.X + v.Instance.Size.X;
        v.Instance.Position.Y + v.Instance.Size.Y;
    };
    if MouseHoveringOver(Values) then
        v.Option();
        break -- prevent clicking 2 options
    end
end
elseif input.UserInputType.Name == "Keyboard" then
if Binding then
    BindedKey = input.KeyCode;
    Binding = false;
elseif input.KeyCode == Options.MenuKey.Value or (input.KeyCode == Enum.KeyCode.Home and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)) then
    Options.MenuOpen();
end
end
end)

function ToggleMenu()
if Options.MenuOpen.Value then
    GetTableData(shared.MenuDrawingData.Instances)(function(i, v)
    if OldData[v] then
        pcall(Set, v, "Visible", true);
    end
    end)
else
    -- GUIService:SetMenuIsOpen(false);
    GetTableData(shared.MenuDrawingData.Instances)(function(i, v)
    if v.Visible == true then
        OldData[v] = true;
        pcall(Set, v, "Visible", false);
    end
    end)
end
end

function CheckRay(Player, Distance, Position, Unit)
local Pass = true;

if Distance > 999 then return false; end

local _Ray = Ray.new(Position, Unit * Distance);

local List = {LocalPlayer.Character, Camera, PlayerMouse.TargetFilter};

for i,v in pairs(IgnoreList) do table.insert(List, v); end;

local Hit = workspace:FindPartOnRayWithIgnoreList(_Ray, List);
if Hit and not Hit:IsDescendantOf(Player.Character) then
    Pass = false;
    if Hit.Transparency >= .3 or not Hit.CanCollide and Hit.ClassName ~= Terrain then -- Detect invisible walls
        IgnoreList[#IgnoreList + 1] = Hit;
    end
end

return Pass;
end

function CheckPlayer(Player)
if not Options.Enabled.Value then return false end

local Pass = true;
local Distance = 0;

if Player ~= LocalPlayer and Player.Character then
    if not Options.ShowTeam.Value and Player.TeamColor == LocalPlayer.TeamColor then
        Pass = false;
    end

    local Head = Player.Character:FindFirstChild"Head";

    if Pass and Player.Character and Head then
        Distance = (Camera.CFrame.p - Head.Position).magnitude;
        if Options.VisCheck.Value then
            Pass = CheckRay(Player, Distance, Camera.CFrame.p, (Head.Position - Camera.CFrame.p).unit);
        end
        if Distance > Options.MaxDistance.Value then
            Pass = false;
        end
    end
else
    Pass = false;
end

return Pass, Distance;
end

function UpdatePlayerData()
if (tick() - LastRefresh) > (Options.RefreshRate.Value / 1000) then
    LastRefresh = tick();
    for i, v in pairs(Players:GetPlayers()) do
        local Data = shared.PlayerData[v.Name] or { Instances = {} };

        Data.Instances["Box"] = Data.Instances["Box"] or LineBox:Create{Thickness = 3};
        Data.Instances["Tracer"] = Data.Instances["Tracer"] or NewDrawing"Line"{
            Transparency = 1;
            Thickness = 2;
        }
        Data.Instances["HeadDot"] = Data.Instances["HeadDot"] or NewDrawing"Circle"{
            Filled = true;
            NumSides = 30;
        }
        Data.Instances["NameTag"] = Data.Instances["NameTag"] or NewDrawing"Text"{
            Size = Options.TextSize.Value;
            Center = true;
            Outline = Options.TextOutline.Value;
            Visible = true;
        };
        Data.Instances["DistanceHealthTag"] = Data.Instances["DistanceHealthTag"] or NewDrawing"Text"{
            Size = Options.TextSize.Value - 1;
            Center = true;
            Outline = Options.TextOutline.Value;
            Visible = true;
        };

        local NameTag = Data.Instances["NameTag"];
        local DistanceTag = Data.Instances["DistanceHealthTag"];
        local Tracer = Data.Instances["Tracer"];
        local HeadDot = Data.Instances["HeadDot"];
        local Box = Data.Instances["Box"];

        local Pass, Distance = CheckPlayer(v);

        if Pass and v.Character then
            Data.LastUpdate = tick();
            local Humanoid = v.Character:FindFirstChildOfClass"Humanoid";
            local Head = v.Character:FindFirstChild"Head";
            local HumanoidRootPart = v.Character:FindFirstChild"HumanoidRootPart";
            if v.Character ~= nil and Head then
                local ScreenPosition, Vis = Camera:WorldToViewportPoint(Head.Position);
                if Vis then
                    local Color = v.TeamColor == LocalPlayer.TeamColor and Green or Red;

                    local ScreenPositionUpper = Camera:WorldToViewportPoint(Head.CFrame * CFrame.new(0, Head.Size.Y, 0).p);
                    local Scale = Head.Size.Y / 2;

                    if Options.ShowName.Value then
                        NameTag.Visible = true;
                        NameTag.Text = v.Name;
                        NameTag.Size = Options.TextSize.Value;
                        NameTag.Outline = Options.TextOutline.Value;
                        NameTag.Position = Vector2.new(ScreenPositionUpper.X, ScreenPositionUpper.Y);
                        NameTag.Color = Color;
                        if Drawing.Fonts then -- CURRENTLY SYNAPSE ONLY :MEGAHOLY:
                            NameTag.Font = Drawing.Fonts.UI;
                        end
                    else
                        NameTag.Visible = false;
                    end
                    if Options.ShowDistance.Value or Options.ShowHealth.Value then
                        DistanceTag.Visible = true;
                        DistanceTag.Size = Options.TextSize.Value - 1;
                        DistanceTag.Outline = Options.TextOutline.Value;
                        DistanceTag.Color = Color3.new(1, 1, 1);
                        if Drawing.Fonts then -- CURRENTLY SYNAPSE ONLY :MEGAHOLY:
                            NameTag.Font = Drawing.Fonts.UI;
                        end

                        local Str = "";

                        if Options.ShowDistance.Value then
                            Str = Str .. Format("[%d] ", Distance);
                        end
                        if Options.ShowHealth.Value and Humanoid then
                            Str = Str .. Format("[%d/100]", Humanoid.Health / Humanoid.MaxHealth * 100);
                        end

                        DistanceTag.Text = Str;
                        DistanceTag.Position = Vector2.new(ScreenPositionUpper.X, ScreenPositionUpper.Y) + Vector2.new(0, NameTag.Size);
                    else
                        DistanceTag.Visible = false;
                    end
                    if Options.ShowDot.Value then
                        local Top = Camera:WorldToViewportPoint((Head.CFrame * CFrame.new(0, Scale, 0)).p);
                        local Bottom = Camera:WorldToViewportPoint((Head.CFrame * CFrame.new(0, -Scale, 0)).p);
                        local Radius = (Top - Bottom).y;

                        HeadDot.Visible = true;
                        HeadDot.Color = Color;
                        HeadDot.Position = Vector2.new(ScreenPosition.X, ScreenPosition.Y);
                        HeadDot.Radius = Radius;
                    else
                        HeadDot.Visible = false;
                    end
                    if Options.ShowTracers.Value then
                        Tracer.Visible = true;
                        Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y);
                        Tracer.To = Vector2.new(ScreenPosition.X, ScreenPosition.Y);
                        Tracer.Color = Color;
                    else
                        Tracer.Visible = false;
                    end
                    if Options.ShowBoxes.Value and HumanoidRootPart then
                        Box:Update(HumanoidRootPart.CFrame, Vector3.new(2, 3, 0) * (Scale * 2), Color);
                    else
                        Box:SetVisible(false);
                    end
                else
                    NameTag.Visible = false;
                    DistanceTag.Visible = false;
                    Tracer.Visible = false;
                    HeadDot.Visible = false;

                    Box:SetVisible(false);
                end
            end
        else
            NameTag.Visible = false;
            DistanceTag.Visible = false;
            Tracer.Visible = false;
            HeadDot.Visible = false;

            Box:SetVisible(false);
        end

        shared.PlayerData[v.Name] = Data;
    end
end
end

function Update()
for i, v in pairs(shared.PlayerData) do
    if not Players:FindFirstChild(tostring(i)) then
        GetTableData(v.Instances)(function(i, obj)
        obj.Visible = false;
        obj:Remove();
        v.Instances[i] = nil;
        end)
        shared.PlayerData[i] = nil;
    end
end

local CX = Menu:GetInstance"CrosshairX";
local CY = Menu:GetInstance"CrosshairY";
if Options.Crosshair.Value then
    CX.Visible = true;
    CY.Visible = true;

    CX.To = Vector2.new((Camera.ViewportSize.X / 2) - 8, (Camera.ViewportSize.Y / 2));
    CX.From = Vector2.new((Camera.ViewportSize.X / 2) + 8, (Camera.ViewportSize.Y / 2));
    CY.To = Vector2.new((Camera.ViewportSize.X / 2), (Camera.ViewportSize.Y / 2) - 8);
    CY.From = Vector2.new((Camera.ViewportSize.X / 2), (Camera.ViewportSize.Y / 2) + 8);
end

Options.MenuOpen.value = false
if Options.MenuOpen.Value and MenuLoaded then
    local MLocation = GetMouseLocation();
    shared.MenuDrawingData.Instances.Main.Color = Color3.fromHSV(tick() * 24 % 255/255, 1, 1);
    local MainInstance = Menu:GetInstance"Main";
    local Values = {
        MainInstance.Position.X;
        MainInstance.Position.Y;
        MainInstance.Position.X + MainInstance.Size.X;
        MainInstance.Position.Y + MainInstance.Size.Y;
    };
    if MainInstance and MouseHoveringOver(Values) then
        Debounce.CursorVis = true;
        -- GUIService:SetMenuIsOpen(true);
        Menu:UpdateMenuInstance"Cursor1"{
            Visible = true;
            From = Vector2.new(MLocation.x, MLocation.y);
            To = Vector2.new(MLocation.x + 5, MLocation.y + 6);
        }
        Menu:UpdateMenuInstance"Cursor2"{
            Visible = true;
            From = Vector2.new(MLocation.x, MLocation.y);
            To = Vector2.new(MLocation.x, MLocation.y + 8);
        }
        Menu:UpdateMenuInstance"Cursor3"{
            Visible = true;
            From = Vector2.new(MLocation.x, MLocation.y + 6);
            To = Vector2.new(MLocation.x + 5, MLocation.y + 5);
        }
    else
        if Debounce.CursorVis then
            Debounce.CursorVis = false;
            -- GUIService:SetMenuIsOpen(false);
            Menu:UpdateMenuInstance"Cursor1"{Visible = false};
            Menu:UpdateMenuInstance"Cursor2"{Visible = false};
            Menu:UpdateMenuInstance"Cursor3"{Visible = false};
        end
    end
    if MouseHeld then
        if Dragging then
            DraggingWhat.Slider.Position = Vector2.new(math.clamp(MLocation.X, DraggingWhat.Line.From.X, DraggingWhat.Line.To.X), DraggingWhat.Slider.Position.Y);
            local Percent = (DraggingWhat.Slider.Position.X - DraggingWhat.Line.From.X) / ((DraggingWhat.Line.To.X - DraggingWhat.Line.From.X));
            local Value = CalculateValue(DraggingWhat.Min, DraggingWhat.Max, Percent);
            DraggingWhat.Option(Value);
        elseif DraggingUI then
            Debounce.UIDrag = true;
            local Main = Menu:GetInstance"Main";
            local MousePos = GetMouseLocation();
            Main.Position = MousePos + DragOffset;
        end
    else
        Dragging = false;
        if DraggingUI and Debounce.UIDrag then
            Debounce.UIDrag = false;
            DraggingUI = false;
            CreateMenu(Menu:GetInstance"Main".Position);
        end
    end
    if not Debounce.Menu then
        Debounce.Menu = true;
        ToggleMenu();
    end
elseif Debounce.Menu and not Options.MenuOpen.Value then
    Debounce.Menu = false;
    ToggleMenu();
end
end

RunService:UnbindFromRenderStep(GetDataName);
RunService:UnbindFromRenderStep(UpdateName);

RunService:BindToRenderStep(GetDataName, 1, UpdatePlayerData);
RunService:BindToRenderStep(UpdateName, 1, Update);

-- # Main Section
-- General

generaltab:Toggle("Infinite Jump", false, function(inf)
	infjumpenabled = inf
end)

generaltab:Toggle(("Enable Sprint: Press \""..bindsp.."\" to Toggle Run"), false, function(sp)
	sprintenabled = sp
end)

generaltab:Toggle(("Enable Click TP: Press \""..bindctp.."\" to Teleport"), false, function(ctp)
	clicktpenabled = ctp
end)

generaltab:Toggle(("Enable NoClip: Press \""..bindnc.."\" to Toggle Clip"), false, function(nc)
	ncenabled = nc
end)

generaltab:Toggle(("Enable Fly: Press \""..bindfly.."\" to Toggle Flight"), false, function(toggle)
    enableflight = toggle
end)

Mouse.KeyDown:connect(function(key)
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
-- localtab:Toggle("Set on Death:", false, function(set)
--    togglewsjp = set
-- end)
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

local enabletp = false

teleporttab:Toggle(("Enable Key TP: Press \""..bindtp.."\" to Teleport to Player"), false, function(toggle)
    enabletp = toggle
end)

IYMouse.KeyDown:Connect(function(Key)
	if enabletp == true and Key == "=" then
		local pdlength = #playerdisplay
    	for i = 0, pdlength, 1 do
        	if targetuser == playerdisplay[i] then
            	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[playertable[i]].Character.HumanoidRootPart.CFrame
        	end
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
esptab:Toggle("Enable ESP", false, function(tog)
	Options.Enabled.Value = tog
end)
-- esptab:Toggle("CHAMS", false, function(tog)
-- end)
esptab:Toggle("Show Team", false, function(tog)
	Options.ShowTeam.Value = tog
end)
esptab:Toggle("Show Names", true, function(tog)
	Options.ShowName.Value = tog
end)
esptab:Toggle("Show Distance", true, function(tog)
	Options.ShowDistance.Value = tog
end)
esptab:Toggle("Show Health", true, function(tog)
	Options.ShowHealth.Value = tog
end)
esptab:Toggle("Show Tracers", true, function(tog)
	Options.ShowTracers.Value = tog
end)
esptab:Toggle("Show Boxes", true, function(tog)
	Options.ShowBoxes.Value = tog
end)
esptab:Toggle("Text Outlines", true, function(tog)
	Options.TextOutline.Value = tog
end)

esptab:Slider("Text Size", 10, 24, 18, function(tog)
	Options.TextSize.Value = tog
end)
esptab:Slider("Max Distance", 100, 5000, 2500, function(tog)
	Options.MaxDistance.Value = tog
end)
esptab:Slider("Refresh Rate (ms)", 1, 200, 5, function(tog)
	Options.RefreshRate.Value = tog
end)



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
	local lighting = game:GetService("Lighting");
	lighting.Ambient = Color3.fromRGB(255, 255, 255);
	lighting.Brightness = 1;
	lighting.FogEnd = 1e10;
	for i, v in pairs(lighting:GetDescendants()) do
		if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
			v.Enabled = false;
		end;
	end;
	lighting.Changed:Connect(function()
		lighting.Ambient = Color3.fromRGB(255, 255, 255);
		lighting.Brightness = 1;
		lighting.FogEnd = 1e10;
	end);
	spawn(function()
		local character = game:GetService("Players").LocalPlayer.Character;
		while wait() do
			repeat wait() until character ~= nil;
			if not character.HumanoidRootPart:FindFirstChildWhichIsA("PointLight") then
				local headlight = Instance.new("PointLight", character.HumanoidRootPart);
				headlight.Brightness = 1;
				headlight.Range = 60;
			end;
		end;
	end);
	game.Lighting.FogEnd = 100000
	for i,v in pairs(game.Lighting:GetDescendants()) do
		if v:IsA("Atmosphere") then
			v:Destroy()
		end
	end
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

--[[
keytab:Bind("Teleport", Enum.KeyCode.T, function(tp) 
	
end)
]]

-- # Filtering Enabled Section
-- FE Animations

sextab:Button("Fuck", function()
	stupid = Instance.new("Animation")
	stupid.AnimationId = "rbxassetid://148840371"
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

sextab:Button("Basic Bang", function()
	local number = "4966833843"
	if Global.Dancing == true then
		lobal.Dancing = false
	end
	
	local aaa = "rbxassetid://" .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua"))()
	end
	
	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService"TweenService"
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
	
	local aaa = "rbxassetid://" .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua"))()
	end
	
	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService"TweenService"
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
	
	local aaa = "rbxassetid://" .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua"))()
	end
	
	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService"TweenService"
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
	
	local aaa = "rbxassetid://" .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua"))()
	end
	
	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService"TweenService"
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
	
	local aaa = "rbxassetid://" .. number
	if (not Global.CloneRig) or game.Players.LocalPlayer.Character ~= Global.CloneRig then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/ReanimMain.lua"))()
	end
	
	local NeededAssets = game:GetObjects(aaa)[1]
	local TweenService = game:GetService"TweenService"
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

cooltab:Button("Hatspin", function()
	local obese = game:GetService("Players")
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
				game:GetService("RunService").Stepped:connect(function()
				a.Position = obese.LocalPlayer.Character.Head.Position
				end)
			end
		end
	end
end)

stoptab:Button("Stop Animation", function()
	Global.dancing = false
end)

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
