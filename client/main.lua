local pedJobModel = 'a_m_m_fatlatin_01'

local inService = false


CreateThread(function()
  while true do
    local sleep = 1000
    local coordsJobStart = Config.Locations.Job
    local playerPed = PlayerPedId()
    local playerPedCoords = GetEntityCoords(playerPed)

    local dist = #(playerPedCoords - coordsJobStart)

    if dist < 5.0 then
      sleep = 5

      if inService then
        DrawText3D(coordsJobStart, "[~r~E~w~] Sair do Emprego")
      else
        DrawText3D(coordsJobStart, "[~r~E~w~] Iniciar Emprego")
      end

      if IsControlJustReleased(0, 38) then
        inService = not inService
        if inService then
          print("Emprego iniciado....")
        else
          print("Saindo do Emprego...")
        end
      end
    end
    Wait(sleep)
  end
end)


CreateThread(function()
  RequestModel(pedJobModel)

  while not HasModelLoaded(pedJobModel) do
    Wait(0)
  end

  local pedJob = CreatePed(
    4,
    pedJobModel,
    Config.Locations.Job.x,
    Config.Locations.Job.y,
    Config.Locations.Job.z - 1,
    250.0,
    false,
    true
  )

  SetEntityAsMissionEntity(pedJob, true, true)
  SetPedDefaultComponentVariation(pedJob)

  FreezeEntityPosition(pedJob, true)
  SetEntityInvincible(pedJob, true)
  SetBlockingOfNonTemporaryEvents(pedJob, true)
end)


CreateThread(function()
  while true do
    local sleep = 1000

    if inService then
      local playerPed = PlayerPedId()
      local playerPedCoords = GetEntityCoords(playerPed)

      local dist = #(playerPedCoords - Config.Locations.VehicleMarker)

      if dist < 30.0 then
        sleep = 5
        DrawMarker(
          36,
          Config.Locations.VehicleMarker.x, Config.Locations.VehicleMarker.y, Config.Locations.VehicleMarker.z - 0.5,
          0.0, 0.0, 0.0,
          0.0, 0.0, 0.0,
          1.0, 1.0, 1.0,
          0, 0, 255, 150,
          true,
          false,
          2,
          false, nil, nil, false
        )

        if dist < 5.0 then
          DrawText3D(Config.Locations.VehicleMarker, "[~r~E~w~] Pegar Veiculo")

          if IsControlJustReleased(0, 38) then
            print('spawnando veiculo....')
          end
        end
      end
    end
    Wait(sleep)
  end
end)





function DrawText3D(coord, text)
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(true)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry('STRING')
  SetTextCentre(true)
  AddTextComponentString(text)
  SetDrawOrigin(coord.x, coord.y, coord.z + 1.0, 0)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end
