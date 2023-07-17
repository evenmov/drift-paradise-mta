function generateDefaultNumberplate(vehicleId)
	if not vehicleId then
		vehicleId = 0
	end
	math.randomseed(tonumber(vehicleId))
	return tostring(exports.dpUtils:generateString(2)) .. tostring(math.random(10, 99)) .. " " .. tostring(exports.dpUtils:generateString(3))
end