function isPlayerOwningVehicle(...)
	return VehicleSpawn.isPlayerOwningVehicle(...)
end

function updateVehicle(...)
	return UserVehicles.updateVehicle(...)
end

function updateVehicleTuning(...)
	return VehicleTuning.updateVehicleTuning(...)
end

function getPlayerVehicles(player)
	if not isElement(player) then
		return false
	end
	local ownerId = player:getData("_id")
	return UserVehicles.getVehicles(ownerId)
end



function getPlayerSpawnedVehicles(player)
	return VehicleSpawn.getPlayerSpawnedVehicles(player)
end




function getVehicleOwnerAsync(vehicleId, eventName, ...)
	if not vehicleId then
		return
	end
	local args = {...}
	local callerRoot = sourceResourceRoot
	return UserVehicles.getVehicleOwner(vehicleId, function (result)
		triggerEvent(eventName, callerRoot, result[1].owner_id, unpack(args))
	end)
end




