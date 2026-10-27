-- BINTANGHUB V3 | Violence District
-- Owner: BintangHub | Theme: Neon Pink
-- Full Features: ESP, Combat, Killer, Survivor, Visuals, Config

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==========================================
-- CONFIG & DEFAULTS
-- ==========================================
local Config = {
    -- Combat
    SilentAim = false, AimLock = false, AimLockDash = false,
    AutoParry = false, ParryMode = "Safe", AntiFake = true,
    
    -- Survivor
    AutoGen = false, GenMode = "Normal",
    AutoSkillcheck = false, AutoTrapRelease = false,
    AutoDodgeAbyss = false, AutoCrouch = false, CrouchMode = "NearKiller",
    
    -- Killer
    AutoM1 = false, KillerAimLock = false, BypassParry = false,
    AutoDropPallet = false, TracerSurvivor = false,
    
    -- Camera
    CameraFOV = 70, DBDCamera = false, DBDDistance = 10, DBDHeight = 5,
    
    -- Visuals
    Fullbright = false, NoShadow = false, NoClip = false,
    
    -- ESP Toggles
    ESP_Survivor = false, ESP_Killer = false, ESP_Stun = false,
    ESP_Gen = false, ESP_Pumpkin = false, ESP_Trap = false,
    ESP_Hook = false, ESP_Window = false, ESP_Pallet = false, ESP_SCP = false,
    ESP_Name = true, StreamerMode = false,
    
    -- ESP Colors (RGB)
    Color_Survivor = Color3.fromRGB(40, 255, 40),
    Color_Killer = Color3.fromRGB(255, 40, 40),
    Color_Stun = Color3.fromRGB(255, 255, 0),
    Color_Gen = Color3.fromRGB(255, 165, 0),
    Color_Pumpkin = Color3.fromRGB(255, 100, 0),
    Color_Trap = Color3.fromRGB(200, 0, 0),
    Color_Hook = Color3.fromRGB(255, 255, 0),
    Color_Window = Color3.fromRGB(0, 255, 255),
    Color_Pallet = Color3.fromRGB(0, 100, 255),
    Color_SCP = Color3.fromRGB(100, 100, 100)
}

-- ==========================================
-- THEME (PINK NEON)
-- ==========================================
local Theme = {
    MainBg = Color3.fromRGB(15, 15, 18),
    SidebarBg = Color3.fromRGB(20, 20, 24),
    ElementBg = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(255, 20, 147), -- Pink Neon
    TextActive = Color3.fromRGB(255, 255, 255),
    TextInactive = Color3.fromRGB(150, 150, 150)
}

-- ==========================================
-- LOADING SCREEN
-- ==========================================
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "BH_Loading"
LoadingGui.Parent = game:GetService("CoreGui")

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 300, 0, 100)
LoadFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
LoadFrame.BackgroundColor3 = Theme.MainBg
LoadFrame.Parent = LoadingGui
Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 10)

local LoadText = Instance.new("TextLabel")
LoadText.Size = UDim2.new(1, 0, 0, 40)
LoadText.BackgroundTransparency = 1
LoadText.Text = "BINTANGHUB V3"
LoadText.TextColor3 = Theme.Accent
LoadText.Font = Enum.Font.GothamBold
LoadText.TextSize = 20
LoadText.Parent = LoadFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0.8, 0, 0, 10)
BarBg.Position = UDim2.new(0.1, 0, 0.7, 0)
BarBg.BackgroundColor3 = Theme.ElementBg
BarBg.Parent = LoadFrame

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Theme.Accent
BarFill.Parent = BarBg

for i = 1, 100 do
    task.wait(0.015)
    BarFill.Size = UDim2.new(i/100, 0, 1, 0)
end
task.wait(0.2)
LoadingGui:Destroy()

-- ==========================================
-- MAIN UI CREATION
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BINTANGHUB_V3"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Mini Icon (Default)
local MiniIcon = Instance.new("TextButton")
MiniIcon.Size = UDim2.new(0, 40, 0, 40)
MiniIcon.Position = UDim2.new(0, 20, 0, 20)
MiniIcon.BackgroundColor3 = Theme.MainBg
MiniIcon.Text = "BH"
MiniIcon.TextColor3 = Theme.Accent
MiniIcon.Font = Enum.Font.GothamBold
MiniIcon.TextSize = 18
MiniIcon.Parent = ScreenGui
Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", MiniIcon).Color = Theme.Accent

-- Main Panel
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Theme.MainBg
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

MiniIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = Theme.SidebarBg
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "BH | DASHBOARD"
Title.TextColor3 = Theme.Accent
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Sidebar

local OwnerTag = Instance.new("TextLabel")
OwnerTag.Size = UDim2.new(1, 0, 0, 20)
OwnerTag.Position = UDim2.new(0, 0, 1, -25)
OwnerTag.BackgroundTransparency = 1
OwnerTag.Text = "Owner: BintangHub"
OwnerTag.TextColor3 = Theme.Accent
OwnerTag.Font = Enum.Font.Gotham
OwnerTag.TextSize = 11
OwnerTag.Parent = Sidebar

-- Content Area & Tabs
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -150, 1, -10)
ContentArea.Position = UDim2.new(0, 145, 0, 5)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local Tabs = {}
local function CreateTab(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Theme.SidebarBg
    btn.Text = "  " .. name
    btn.TextColor3 = Theme.TextInactive
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.Visible = false
    page.Parent = ContentArea
    
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 5)
    
    Tabs[name] = {Button = btn, Page = page}
    
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Button.BackgroundColor3 = Theme.SidebarBg
            t.Button.TextColor3 = Theme.TextInactive
            t.Page.Visible = false
        end
        btn.BackgroundColor3 = Theme.ElementBg
        btn.TextColor3 = Theme.Accent
        page.Visible = true
    end)
end

CreateTab("Main", 45)
CreateTab("Combat", 80)
CreateTab("Killer", 115)
CreateTab("Survivor", 150)
CreateTab("ESP", 185)
CreateTab("Visuals", 220)
CreateTab("Settings", 255)

-- ==========================================
-- UI ELEMENT FACTORY
-- ==========================================
local function CreateToggle(parent, name, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 25)
    btn.BackgroundColor3 = Theme.ElementBg
    btn.Text = "  [ ] " .. name
    btn.TextColor3 = default and Theme.Accent or Theme.TextInactive
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Tabs[parent].Page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    btn.MouseButton1Click:Connect(function()
        local state = not Config[name]
        Config[name] = state
        btn.Text = state and ("  [x] " .. name) or ("  [ ] " .. name)
        btn.TextColor3 = state and Theme.Accent or Theme.TextInactive
        if callback then callback(state) end
    end)
end

local function CreateButton(parent, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 25)
    btn.BackgroundColor3 = Theme.ElementBg
    btn.Text = "  " .. name
    btn.TextColor3 = Theme.TextActive
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Tabs[parent].Page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(callback)
end

-- ==========================================
-- POPULATE TABS
-- ==========================================
-- Main Tab
CreateToggle("Main", "StreamerMode", Config.StreamerMode)
CreateToggle("Main", "Fullbright", Config.Fullbright)
CreateToggle("Main", "NoClip", Config.NoClip)
CreateButton("Main", "DBD Camera Mode", function() Config.DBDCamera = not Config.DBDCamera end)

-- Combat Tab
CreateToggle("Combat", "SilentAim", Config.SilentAim)
CreateToggle("Combat", "AimLock", Config.AimLock)
CreateToggle("Combat", "AimLockDash", Config.AimLockDash)
CreateToggle("Combat", "AutoParry", Config.AutoParry)
CreateButton("Combat", "Parry Mode: " .. Config.ParryMode, function()
    if Config.ParryMode == "Safe" then Config.ParryMode = "Agresif"
    elseif Config.ParryMode == "Agresif" then Config.ParryMode = "AntiFake"
    else Config.ParryMode = "Safe" end
end)

-- Killer Tab
CreateToggle("Killer", "AutoM1", Config.AutoM1)
CreateToggle("Killer", "KillerAimLock", Config.KillerAimLock)
CreateToggle("Killer", "BypassParry", Config.BypassParry)
CreateToggle("Killer", "AutoDropPallet", Config.AutoDropPallet)
CreateToggle("Killer", "TracerSurvivor", Config.TracerSurvivor)

-- Survivor Tab
CreateToggle("Survivor", "AutoGen", Config.AutoGen)
CreateButton("Survivor", "Gen Mode: " .. Config.GenMode, function()
    if Config.GenMode == "Normal" then Config.GenMode = "Legit"
    elseif Config.GenMode == "Legit" then Config.GenMode = "Instan"
    else Config.GenMode = "Normal" end
end)
CreateToggle("Survivor", "AutoSkillcheck", Config.AutoSkillcheck)
CreateToggle("Survivor", "AutoTrapRelease", Config.AutoTrapRelease)
CreateToggle("Survivor", "AutoDodgeAbyss", Config.AutoDodgeAbyss)
CreateToggle("Survivor", "AutoCrouch", Config.AutoCrouch)

-- ESP Tab
CreateToggle("ESP", "ESP_Survivor", Config.ESP_Survivor)
CreateToggle("ESP", "ESP_Killer", Config.ESP_Killer)
CreateToggle("ESP", "ESP_Stun", Config.ESP_Stun)
CreateToggle("ESP", "ESP_Gen", Config.ESP_Gen)
CreateToggle("ESP", "ESP_Pumpkin", Config.ESP_Pumpkin)
CreateToggle("ESP", "ESP_Trap", Config.ESP_Trap)
CreateToggle("ESP", "ESP_Hook", Config.ESP_Hook)
CreateToggle("ESP", "ESP_Window", Config.ESP_Window)
CreateToggle("ESP", "ESP_Pallet", Config.ESP_Pallet)
CreateToggle("ESP", "ESP_SCP", Config.ESP_SCP)
CreateToggle("ESP", "ESP_Name", Config.ESP_Name)

-- Visuals Tab
CreateToggle("Visuals", "NoShadow", Config.NoShadow)
CreateButton("Visuals", "ESP Colors (Default Pink)", function() end)

-- Settings Tab
CreateButton("Settings", "Save Config (Auto)", function() end)
CreateButton("Settings", "Load Config", function() end)

Tabs["Main"].Button.MouseButton1Click() -- Default tab

-- ==========================================
-- LOGIC: ESP SYSTEM
-- ==========================================
local espObjects = {}
local function CreateESP()
    local box = Drawing.new("Square")
    box.Thickness = 1.5
    box.Filled = false
    box.Visible = false
    local text = Drawing.new("Text")
    text.Size = 13
    text.Center = true
    text.Outline = true
    text.Font = 2
    text.Visible = false
    return {box = box, text = text}
end

local function GetName(plr, isKiller)
    if Config.StreamerMode then
        return isKiller and "K-" .. plr.UserId % 100 or "S-" .. plr.UserId % 100
    end
    return plr.Name
end

local function UpdateESP()
    -- Player ESP
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                if not espObjects[plr] then espObjects[plr] = CreateESP() end
                local esp = espObjects[plr]
                local isKiller = plr.Character:FindFirstChildOfClass("Tool") ~= nil
                local isStunned = plr.Character:FindFirstChild("Stun") ~= nil or hum.WalkSpeed == 0
                
                local active = (isKiller and Config.ESP_Killer) or (not isKiller and Config.ESP_Survivor)
                if isKiller and isStunned and Config.ESP_Stun then active = true end
                
                if active then
                    local vec, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                        local height = 1000 / dist
                        esp.box.Size = Vector2.new(height/2, height)
                        esp.box.Position = Vector2.new(vec.X - height/4, vec.Y - height/2)
                        
                        if isKiller and isStunned then esp.box.Color = Config.Color_Stun
                        elseif isKiller then esp.box.Color = Config.Color_Killer
                        else esp.box.Color = Config.Color_Survivor end
                        esp.box.Visible = true
                        
                        if Config.ESP_Name then
                            local nameTxt = GetName(plr, isKiller)
                            if isKiller and isStunned then nameTxt = nameTxt .. " [STUNNED]" end
                            esp.text.Text = nameTxt .. " [" .. math.floor(dist) .. "m]"
                            esp.text.Position = Vector2.new(vec.X, vec.Y - height/2 - 16)
                            esp.text.Color = esp.box.Color
                            esp.text.Visible = true
                        else
                            esp.text.Visible = false
                        end
                    else
                        esp.box.Visible = false; esp.text.Visible = false
                    end
                else
                    esp.box.Visible = false; esp.text.Visible = false
                end
            end
        end
    end

    -- Object ESP
    for _, obj in pairs(workspace:GetDescendants()) do
        local n = obj.Name:lower()
        local isGen = Config.ESP_Gen and n:find("generator")
        local isPump = Config.ESP_Pumpkin and n:find("pumpkin")
        local isTrap = Config.ESP_Trap and n:find("trap")
        local isHook = Config.ESP_Hook and n:find("hook")
        local isWin = Config.ESP_Window and n:find("window")
        local isPallet = Config.ESP_Pallet and n:find("pallet")
        local isSCP = Config.ESP_SCP and n:find("scp")
        
        if isGen or isPump or isTrap or isHook or isWin or isPallet or isSCP then
            if not espObjects[obj] then espObjects[obj] = CreateESP() end
            local esp = espObjects[obj]
            if obj:IsA("BasePart") or obj:IsA("Model") then
                local pos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
                local vec, onScreen = Camera:WorldToViewportPoint(pos)
                if onScreen then
                    esp.text.Text = isGen and "[GEN]" or isPump and "[LABU]" or isTrap and "[TRAP]" or isHook and "[HOOK]" or isWin and "[WIN]" or isPallet and "[PALLET]" or "[SCP]"
                    esp.text.Position = Vector2.new(vec.X, vec.Y)
                    esp.text.Color = isGen and Config.Color_Gen or isPump and Config.Color_Pumpkin or isTrap and Config.Color_Trap or isHook and Config.Color_Hook or isWin and Config.Color_Window or isPallet and Config.Color_Pallet or Config.Color_SCP
                    esp.text.Visible = true
                    esp.box.Visible = false
                else
                    esp.text.Visible = false
                end
            end
        end
    end
end

-- ==========================================
-- LOGIC: COMBAT & PARry
-- ==========================================
local function GetClosestTarget()
    local closest, minDist = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local vec, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                if onScreen and dist < minDist and dist < 200 then
                    minDist = dist
                    closest = hrp
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    UpdateESP()
    
    -- Silent Aim / Aim Lock
    if Config.SilentAim or Config.AimLock then
        local target = GetClosestTarget()
        if target then
            if Config.AimLock then
                -- Smooth Camera Lock
                local lookAt = CFrame.new(Camera.CFrame.Position, target.Position)
                Camera.CFrame = Camera.CFrame:Lerp(lookAt, 0.2)
            end
        end
    end
    
    -- Camera FOV
    if Camera.FieldOfView ~= Config.CameraFOV then Camera.FieldOfView = Config.CameraFOV end
end)

-- Silent Aim Hook
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if Config.SilentAim and (method == "Raycast" or method == "FindPartOnRay" or method == "FindPartOnRayWithIgnoreList") then
        local target = GetClosestTarget()
        if target then
            local args = {...}
            if typeof(args[1]) == "Ray" then
                args[1] = Ray.new(args[1].Origin, (target.Position - args[1].Origin).Unit * 500)
            end
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- Auto Parry Logic
local parryRemote = nil
for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    if v:IsA("RemoteEvent") and (v.Name:lower():find("parry") or v.Name:lower():find("block")) then parryRemote = v break end
end

local lastParry = 0
local function DoParry()
    if tick() - lastParry < 0.4 then return end
    lastParry = tick()
    if parryRemote then pcall(function() parryRemote:FireServer() end)
    else
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
    end
end

-- Auto Skillcheck & Trap Release
for _, remote in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    if remote:IsA("RemoteEvent") then
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                local args = {...}
                local txt = ""
                for _, a in pairs(args) do if type(a) == "string" then txt = txt .. a:lower() end end
                
                -- Parry check
                if Config.AutoParry and (txt:find("attack") or txt:find("slash")) then
                    if Config.ParryMode == "Safe" then task.wait(0.15); DoParry()
                    elseif Config.ParryMode == "Agresif" then DoParry() end
                end
                
                -- Skillcheck/Trap check
                if txt:find("skill") or txt:find("trap") then
                    if (Config.AutoSkillcheck or Config.AutoTrapRelease) then
                        task.wait(0.15)
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                        task.wait(0.05)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                    end
                end
            end)
        end)
    end
end

-- ==========================================
-- LOGIC: SURVIVOR & KILLER (LOOP)
-- ==========================================
task.spawn(function()
    while task.wait(0.1) do
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                -- Auto Crouch
                if Config.AutoCrouch then
                    hum.CameraOffset = Vector3.new(0, -1, 0) -- Visual crouch
                else
                    hum.CameraOffset = Vector3.new(0, 0, 0)
                end
                
                -- NoClip
                if Config.NoClip then
                    for _, v in pairs(char:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                end
            end
        end

        -- Fullbright & NoShadow
        if Config.Fullbright then
            Lighting.Brightness = 3; Lighting.ClockTime = 14; Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 1; Lighting.GlobalShadows = true
        end
        if Config.NoShadow then
            for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.CastShadow = false end end
        end
    end
end)

print("[BINTANGHUB V3] Loaded. Owner: BintangHub.")