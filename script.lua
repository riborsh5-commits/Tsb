-- Versión Rogan: Original Logic + Modern UI
--

_G.AutoBlock = true 
_G.InfEnergy = true
_G.NoCooldown = true 

-- [HOOK] No Cooldown Original
spawn(function()
    local a
    a = hookfunction(wait, function(b) 
        if b ~= 0 and tostring(getcallingscript(a)) ~= "nil" and tonumber(b) < 2.5 and _G.NoCooldown == true then 
            return a() 
        end 
        return a(b) 
    end)
end)

-- [GUI] Interfaz de Rogan Plegable
local function CreateInstance(cls,props)
    local inst = Instance.new(cls)
    for i,v in pairs(props) do inst[i] = v end
    return inst
end

local ScreenGui = CreateInstance('ScreenGui',{DisplayOrder=10,Enabled=true,ResetOnSpawn=false,Name='RoganGui', Parent=game.CoreGui})
local MainFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=true,BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.5,Position=UDim2.new(0.7, 0, 0.2, 0),Size=UDim2.new(0, 180, 0, 220),Visible=true,Parent=ScreenGui,Draggable=true})

-- Botones con la estética que elegimos
local AutoBlockBtn = CreateInstance('TextButton',{Text='Auto Block: ON',BackgroundColor3=Color3.new(0.1, 0.4, 0.1),Position=UDim2.new(0.05, 0, 0.1, 0),Size=UDim2.new(0.9, 0, 0, 40),Parent=MainFrame,TextColor3=Color3.new(1,1,1)})
local InfEnergyBtn = CreateInstance('TextButton',{Text='Inf Energy: ON',BackgroundColor3=Color3.new(0.1, 0.4, 0.1),Position=UDim2.new(0.05, 0, 0.35, 0),Size=UDim2.new(0.9, 0, 0, 40),Parent=MainFrame,TextColor3=Color3.new(1,1,1)})
local NoCooldownBtn = CreateInstance('TextButton',{Text='No Cooldown: ON',BackgroundColor3=Color3.new(0.1, 0.4, 0.1),Position=UDim2.new(0.05, 0, 0.6, 0),Size=UDim2.new(0.9, 0, 0, 40),Parent=MainFrame,TextColor3=Color3.new(1,1,1)})
local CloseBtn = CreateInstance('TextButton',{Text='OCULTAR',BackgroundColor3=Color3.new(0.5, 0, 0),Position=UDim2.new(0.05, 0, 0.85, 0),Size=UDim2.new(0.9, 0, 0, 30),Parent=MainFrame,TextColor3=Color3.new(1,1,1)})
local OpenBtn = CreateInstance('TextButton',{Text='Abrir Menú',Visible=false,BackgroundColor3=Color3.new(0, 0.5, 0),Position=UDim2.new(1, -140, 0, 80),Size=UDim2.new(0, 130, 0, 45),Parent=ScreenGui,TextColor3=Color3.new(1,1,1)})

-- Lógica de los Toggles
AutoBlockBtn.MouseButton1Click:Connect(function()
    _G.AutoBlock = not _G.AutoBlock
    AutoBlockBtn.Text = _G.AutoBlock and "Auto Block: ON" or "Auto Block: OFF"
    AutoBlockBtn.BackgroundColor3 = _G.AutoBlock and Color3.new(0.1, 0.4, 0.1) or Color3.new(0.4, 0.1, 0.1)
end)

InfEnergyBtn.MouseButton1Click:Connect(function()
    _G.InfEnergy = not _G.InfEnergy
    InfEnergyBtn.Text = _G.InfEnergy and "Inf Energy: ON" or "Inf Energy: OFF"
    InfEnergyBtn.BackgroundColor3 = _G.InfEnergy and Color3.new(0.1, 0.4, 0.1) or Color3.new(0.4, 0.1, 0.1)
end)

NoCooldownBtn.MouseButton1Click:Connect(function()
    _G.NoCooldown = not _G.NoCooldown
    NoCooldownBtn.Text = _G.NoCooldown and "No Cooldown: ON" or "No Cooldown: OFF"
    NoCooldownBtn.BackgroundColor3 = _G.NoCooldown and Color3.new(0.1, 0.4, 0.1) or Color3.new(0.4, 0.1, 0.1)
end)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenBtn.Visible = false end)

-- [MAIN LOOP] Lógica Original Reinsertada
local name = tostring(game.Players.LocalPlayer.Name)
game:GetService("RunService").Heartbeat:Connect(function()
    -- Bloqueo Original (Encender/Apagar con Wait)
    spawn(function()
        if _G.AutoBlock == true then
            wait()
            game:GetService("ReplicatedStorage").RemoteEvents.ReplicateGuardOn:FireServer()
            if game:GetService("Workspace")[name]:FindFirstChild("Guarding") then
                game:GetService("Workspace")[name].Guarding.Value = false
            end
            wait()
            game:GetService("ReplicatedStorage").RemoteEvents.ReplicateGuardOff:FireServer()
        end
    end)

    -- Energía Original
    spawn(function()
        if _G.InfEnergy then
            if game:GetService("Workspace")[name]:FindFirstChild("Energy") then
                game:GetService("Workspace")[name].Energy.Value = 97
            end
        end
    end)
end)
