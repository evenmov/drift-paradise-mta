
-- Время, через которое удаляется взорвавшийся автомобиль
local EXPLODED_VEHICLE_DESTROY_TIMEOUT = 5000


local autosaveFields = {
	"mileage"
}
-- Поля, которые можно менять на клиенте
local allowedFields = {
	mileage = true,
}




-- Возвращает массив автомобилей, принадлежащих пользователю с userId


-- Возвращает массив автомобилей, заспавненных игроком
function VehicleSpawn.getPlayerSpawnedVehicles(player)
	if not isElement(player) then
		return false
	end
	local userId = player:getData("_id")
	return VehicleSpawn.getUserSpawnedVehicles(userId)
end

-- Возвращает элемент заспавненного автомобиля по его _id в базе данных
function VehicleSpawn.getSpawnedVehicle(vehicleId)
	return getElementByID("vehicle_" .. tostring(vehicleId))
end

-- Возвращает игрока, который является владельцем автомобиля
function VehicleSpawn.getVehicleOwnerPlayer(vehicle)
	if not isElement(vehicle) then
		return false
	end
	local ownerId = vehicle:getData("owner_id")
	return Users.getPlayerById(ownerId)
end

-- Возвращает, является ли игрок владельцем автомобиля
function VehicleSpawn.isPlayerOwningVehicle(player, vehicle)
	if not isElement(player) or not isElement(vehicle) then
		return false
	end
	local playerId = player:getData("_id")
	local ownerId = vehicle:getData("owner_id")
	return playerId == ownerId
end




-------------------

-- 不是很理解
addEventHandler("onElementDataChange", root, function(dataName, oldValue)
	if not client then
		return
	end
	if source.type == "vehicle" then
		if not allowedFields[dataName] then
			source:setData(dataName, oldValue)
		end
	end
end)

addEventHandler("onVehicleExplode", root, function()
	local vehicle = source
	setTimer(function ()
		if isElement(vehicle) then
			VehicleSpawn.returnToGarage(vehicle)
		end
	end, EXPLODED_VEHICLE_DESTROY_TIMEOUT, 1)
end)

addEventHandler("onPlayerQuit", root, function ()
	local vehicles = VehicleSpawn.getPlayerSpawnedVehicles(source)
	if type(vehicles) == "table" then
		for i, vehicle in ipairs(vehicles) do
			VehicleSpawn.returnToGarage(vehicle)
		end
	end
end)
