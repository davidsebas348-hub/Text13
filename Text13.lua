-- ======================
-- Teletransportar al jugador a la puerta de escape
-- ======================

local player = game.Players.LocalPlayer

-- Esperar a que el personaje esté listo
local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

-- Buscar la puerta de escape en Workspace
local function findEscapeDoor()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local name = (v.Name or ""):lower()
            if name:find("escape") or name:find("exit") or name:find("finish") then
                return v
            end
        end
    end
    return nil
end

-- Hacer TP
local function teleportToEscape()
    local hrp = getHRP()
    local door = findEscapeDoor()
    if hrp and door then
        -- Teletransporta el jugador 3 studs arriba de la puerta
        hrp.CFrame = CFrame.new(door.Position + Vector3.new(0,3,0))
        print("¡Teletransportado a la puerta de escape!")
    else
        warn("No se encontró la puerta de escape o el personaje aún no está listo.")
    end
end

-- Ejecutar TP
teleportToEscape()
