local pedJobModel = 'a_m_m_fatlatin_01'


CreateThread(function()
  while true do
    local sleep = 1000
    local coordsJobStart = Config.Locations.Job
    local playerPed = PlayerPedId()
    local playerPedCoords = GetEntityCoords(playerPed)

    local dist = #(playerPedCoords - coordsJobStart)

    if dist < 5.0 then
      sleep = 5
      DrawText3D(coordsJobStart, "[~g~E~w~] Iniciar Emprego")

      if IsControlJustReleased(0, 38) then
        print("Emprego iniciado....")
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

  SetPedDefaultComponentVariation(pedJob)

  FreezeEntityPosition(pedJob, true)
  SetEntityInvincible(pedJob, true)
  SetBlockingOfNonTemporaryEvents(pedJob, true)
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
