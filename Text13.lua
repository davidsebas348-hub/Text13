-- ======================
-- TRAER PUERTA AL JUGADOR + TPToLobby
-- ======================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- esperar HRP
local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

-- buscar puerta de escape
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

-- mover puerta al jugador
local function bringDoorToPlayer()
    local hrp = getHRP()
    local door = findEscapeDoor()

    if hrp and door then
        door.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 0, -3))
        print("Puerta movida al jugador")
        return true
    else
        warn("No se encontró la puerta o el jugador no está listo")
        return false
    end
end

-- ejecutar lógica
task.spawn(function()
    local success = bringDoorToPlayer()
    if not success then return end

    -- esperar 1 segundo
    task.wait(1)

    -- activar remote TPToLobby
    local remote = ReplicatedStorage:FindFirstChild("TPToLobby", true)
    if remote and remote:IsA("RemoteEvent") then
        pcall(function()
            remote:FireServer()
            print("Remote TPToLobby activado")
        end)
    else
        warn("Remote TPToLobby no encontrado")
    end
end)
