local RSGCore = exports['rsg-core']:GetCoreObject()

local diceHash = 'p_dice01x'
local dimensionsFace = { X = 0.023142, Y = 0.024278, Z = 0.023156}
local diceCupHash = 'p_gen_dicecup01x'
local dicechestHash = "p_chestmedice01x"

-- Modelo del dado
local diceResults = {}
local diceModel = -919893596 -- hash
local diceCupModel = -919893596 -- hash
local DiceCamera = nil

----------------------------
-- Función para obtener las propiedades de una entidad
----------------------------
local GetLiveEntityProperties = function(entity)
	local model = GetEntityModel(entity)
  local x, y, z = table.unpack(GetEntityCoords(entity))
  local h = GetEntityHeading(entity)
  local pitch, roll, yaw = table.unpack(GetEntityRotation(entity, 2))
  if Config.Debug then
    print('Entity Properties:'.. entity)
    print('model ='.. model,  'x ='.. x,  'y ='.. y,  'z ='.. z, 'h ='.. h)
    print('model ='.. model,  'pitch ='.. pitch,  'roll ='.. roll,  'yaw ='.. yaw)
  end
  return {
      model = model,
      x = x,
      y = y,
      z = z,
      h = h,
      pitch = pitch,
      roll = roll,
      yaw = yaw
  }
end

----------------------------
-- Función para cargar el modelo del dado
----------------------------
local LoadModel = function(model)
    if not IsModelInCdimage(model) then
        return false
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    return true
end

----------------------------
-- Función para camaras
----------------------------
local StopDiceCamera = function(entity)
    if DiceCamera then
        SetCamActive(DiceCamera, false)
        RenderScriptCams(1, true, 1000, true, false)
        DestroyCam(DiceCamera, false)
        DiceCamera = nil
    end
    SetEntityAsNoLongerNeeded(entity)
    DeleteEntity(entity)
    DeleteObject(entity)
end

local FollowDiceCamera = function(entity, value)
  local dicePosition = GetEntityCoords(entity)
  local camOffset

  if not value then
      camOffset = vector3(-0.5, -1, 0.75)
  else
      camOffset = vector3(-0.1, -0.1, 0.40)
  end

  local camCoords = dicePosition + camOffset

  if DiceCamera then
      if IsCamActive(DiceCamera) then
          DestroyCam(DiceCamera, false)
      end
  end

  DiceCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords.x, camCoords.y, camCoords.z, 315.00, 00.00, -30.00, 50.00, true, 0)
  RenderScriptCams(true, true, 1000, true, true)
  SetCamActive(DiceCamera, true)

  if not value then
      PointCamAtCoord(DiceCamera, dicePosition.x, dicePosition.y, dicePosition.z - 0.5)
  else
      PointCamAtCoord(DiceCamera, dicePosition.x, dicePosition.y, dicePosition.z)
  end
end

----------------------------
-- Función para posicion del dado
----------------------------
local function IsBetweenResult(num, low, high)
  if num > -181 and num < -179 then
    num = -180
  end
  if num > -91 and num < -89 then
    num = -90
  end
  if num < 1 and num > -1 then
    num = 0
  end
  if num < 91 and num > 89 then
    num = 90
  end
  if num < 181 and num > 179 then
    num = 180
  end

  if num > low and num < high then
    return true
  elseif num < low and num > high then
    return true
  end
  return false
end

local function DetermineUpperFace(entity)
  if not entity then
    if Config.Debug then print('Entity Properties:', "Error: No se proporcionó una entidad válida.") end
    return nil
  end
  -- Obtener las propiedades de la entidad
  local entityProperties = GetLiveEntityProperties(entity)
  local pitch, roll = entityProperties.pitch, entityProperties.roll

  if (IsBetweenResult(pitch, -1, 1) and IsBetweenResult(roll, -179, -181)) or (IsBetweenResult(pitch, -179, -181) and IsBetweenResult(roll, -1, 1))
  or (IsBetweenResult(pitch, -1, 1) and IsBetweenResult(roll, -179, -181)) or (IsBetweenResult(pitch, -1, 1) and IsBetweenResult(roll, 179, 181)) then
    return 6
  elseif IsBetweenResult(roll, -89, -91) then
    return 2
  elseif IsBetweenResult(pitch, 89, 91)  then
    return 3
  elseif IsBetweenResult(pitch, -89, -91) then
    return 4
  elseif IsBetweenResult(roll, 89, 91) then
    return 5
  else
    return 1
  end

end

--------------------------
-- ONE DICE ADV
------------------------
local RollDiceAdv = function()
    local ped = PlayerPedId()
    local coords = GetLiveEntityProperties(ped)
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger00")
    SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)

    -- Cargar el modelo del dado
    if not LoadModel(diceModel) then
      if Config.Debug then print("Error: No se pudo cargar el modelo del dado.") end
      return nil
    end
    -- Action with prop
    local diceObject = CreateObject(diceModel, coords.x, coords.y, coords.z, true, true, true)
    SetEntityRotation(diceObject, 0.0, 0.0, 0.0, 2, true)
    AttachEntityToEntity(diceObject, ped, boneIndex, 0.10, -0.00, 0.02, 75.0, 270.0, 120.0, true, false, true, false, 0, true)
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_PLAYER_PICKUP_WEAPON_THROWN_TOMAHAWK_ANCIENT'), -1, true) -- WORLD_PLAYER_PICKUP_WEAPON_THROWN_TOMAHAWK_ANCIENT
    FollowDiceCamera(diceObject, false) -- false start cam
    local airTimer = 0
    while airTimer < 100 do
        Wait(0)
        if IsEntityInAir(diceObject) then
            airTimer = airTimer + 1
        else
            break
        end
    end
    Wait(1400)
    -- confirm coords and delete first prop
    local coordsDice = GetLiveEntityProperties(diceObject)
    DeleteEntity(diceObject)

    local dice1 = CreateObject(diceModel, coordsDice.x, coordsDice.y, coordsDice.z, true, true, true)
    SetEntityRotation(dice1, 0.0, 0.0, 0.0, 2, true)
    SetModelAsNoLongerNeeded(dice1)

    local forceX = 0
    local forceY = 1.5

    ApplyForceToEntity(dice1, 1, forceX, forceY, 0, 0, 0, 0, boneIndex, false, false, false, true, true)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "dice", 0.8)

    local randX = math.random(1, 360) + 0.0
    local randY = math.random(1, 360) + 0.0
    local randZ = math.random(1, 360) + 0.0
    if Config.Debug then print('diceObject Rotation' ..dice1,' randx=' ..randX ,' randy=' ..randY ,' randz=' ..randZ) end
    SetEntityRotation(dice1, randX, randY, randZ, 0, true)
    SetEntityCollision(dice1, true, true)

    Wait(1000)

    FollowDiceCamera(dice1, false) -- true follow cam
    local stationaryTimer = 0
    local stationaryThreshold = 0.1 -- Umbral de velocidad para considerar que el objeto está parado

    while stationaryTimer < 10 do
        Wait(0)
        local velocity = GetEntityVelocity(dice1)
        local speed = #(velocity)

        if speed < stationaryThreshold then
            stationaryTimer = stationaryTimer + 1
        else
            stationaryTimer = 0 -- Reiniciar el temporizador si el objeto no está parado
        end
    end

    Wait(1000)
    FollowDiceCamera(dice1, true) -- true follow cam

    Wait(3000)
    local upperFace = DetermineUpperFace(dice1)

    TriggerServerEvent('hdrp-dice:server:Discord', 1, upperFace, false, false, false, false)
    print("La cara superior del cubo:", upperFace)
    table.insert(diceResults, upperFace)
    StopDiceCamera(dice1)
end

--------------------------
-- SIMPLE DICE RANDOM
------------------------
local RollDiceSimple = function()
  TaskStartScenarioInPlace(PlayerPedId(), joaat('WORLD_PLAYER_PICKUP_WEAPON_THROWN_TOMAHAWK_ANCIENT'), -1, true, false, false, false)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "dice", 0.8)
  Wait(1400)
  local upperFace = math.random(1, 6)
  if Config.Debug then print("La cara superior del dado:", upperFace) end
  TriggerServerEvent('hdrp-dice:server:Discord', 1, upperFace, false, false, false, false)
  table.insert(diceResults, upperFace)
end

-- Manejar el evento para abrir el dado
RegisterNetEvent('hdrp-dice:client:OpenDice')
AddEventHandler('hdrp-dice:client:OpenDice', function()
  if not Config.DiceAdv then
    RollDiceSimple()
  else
   RollDiceAdv()
  end
end)
------------------------------------------------------ 

--------------------------
-- TWO DICE
--------------------------
local dice1
local dice2

local function RollTwoDice()
    local randX1 = math.random(1, 360) + 0.0
    local randY1 = math.random(1, 360) + 0.0

    local randX2 = math.random(1, 360) + 0.0
    local randY2 = math.random(1, 360) + 0.0

    -- Cargar el modelo del dado
    local diceModel = -919893596
    if not IsModelValid(diceModel) then
        print("Error: Modelo de dado no válido.")
        return
    end

    -- Verificar si el modelo del dado está cargado
    if not HasModelLoaded(diceModel) then
        RequestModel(diceModel)
        while not HasModelLoaded(diceModel) do
            Wait(100)
        end
    end

    local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger00")
    local coords = GetEntityCoords(PlayerPedId())

    dice1 = CreateObject(diceModel, coords.x, coords.y , coords.z, false, true, false)
    dice2 = CreateObject(diceModel, coords.x - 0.01, coords.y - 0.01, coords.z, false, true, false)

		SetEntityRotation(dice1, 0.0, 0.0, 0.0, 2, true)
		SetEntityRotation(dice2, 0.0, 0.0, 0.0, 2, true)

    ApplyForceToEntity(dice1, 1, 0, 1.5, 0.0, 0, 0, 0, boneIndex, false, false, false, true, true)
    ApplyForceToEntity(dice2, 1, 0, 1.5, 0.0, 0, 0, 0, boneIndex, false, false, false, true, true)

    SetEntityRotation(dice1, randX1, randY1, 0, 0, true)
    SetEntityRotation(dice2, randX2, randY2, 0, 0, true)


    Wait(3000)
    FollowDiceCamera(dice2)

    local diceResult1 = DetermineUpperFace(dice1)-- Resultado y log
    local diceResult2 = DetermineUpperFace(dice2)-- Resultado y log

    Wait(3000)
    StopDiceCamera(dice2)

    TriggerServerEvent('hdrp-dice:server:Discord', 2, diceResult1, diceResult2, false, false, false)
    if Config.Debug then print("La cara superior del dado:", diceResult1, diceResult2) end
    -- table.insert(diceResults, diceResult1, diceResult2)
    SetEntityAsNoLongerNeeded(dice1)
    SetEntityAsNoLongerNeeded(dice2)
    DeleteEntity(dice1)
    DeleteEntity(dice2)
end

RegisterNetEvent('hdrp-dice:client:OpenTwoDice')
AddEventHandler('hdrp-dice:client:OpenTwoDice', function()
  TaskStartScenarioInPlace(PlayerPedId(), joaat('WORLD_PLAYER_PICKUP_WEAPON_THROWN_TOMAHAWK_ANCIENT'), -1, true, false, false, false)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "dice", 0.8)
  Wait(1400)
  RollTwoDice()
end)

------------
-- Variables iniciales:
-- diceModel: un identificador hash para el modelo de los dados.
-- diceHash: un identificador para los dados.
-- dimensionsFace: un conjunto de dimensiones para las caras de los dados.
-- DiceCamera: una variable para almacenar la cámara utilizada para seguir los dados.
-- diceResults: una tabla para almacenar los resultados de los dados.

-- Funciones para cámaras:
-- StopDiceCamera: una función para detener y limpiar la cámara utilizada para seguir los dados.
-- FollowDiceCamera: una función para iniciar la cámara y seguir los dados. Dos opciones false para empezar, true para hacer el seguimiento

-- Función para obtener propiedades de entidad:
-- GetLiveEntityProperties: una función que toma una entidad como argumento y devuelve un conjunto de propiedades de esa entidad, como su modelo, coordenadas y orientación.

-- Función DetermineUpperFace: 
-- Esta función determina la cara superior del cubo basándose en la orientación de la entidad. Se asegura de que las caras estén emparejadas correctamente, de modo que la suma de las caras opuestas siempre sea igual a 7.

-- Función LoadModel: 
-- Esta función carga el modelo del dado.

-- Función RollDice: 
-- Esta función realiza el lanzamiento del dado, creando un objeto con un modelo dado, aplicándole fuerzas aleatorias y rotándolo de manera aleatoria. Luego, determina la cara superior del dado y realiza el registro del resultado.
------------

RegisterCommand("verificarDado", function(source, args)
  RollDiceAdv()  -- Llama a la función RollDice para lanzar el dado y verificar la cara
end, false)

RegisterCommand("verificarDado2", function(source, args)
  RollTwoDice()  -- Llama a la función RollDice para lanzar el dado y verificar la cara
end, false)