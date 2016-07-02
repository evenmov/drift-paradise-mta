local function enterHouse(marker)
	setTimer(function ()
		triggerServerEvent("dpHouses.house_enter", resourceRoot, marker.id)
	end, 500, 1)
	fadeCamera(false, 0.5)
end

addEvent("dpMarkers.enter", false)
addEventHandler("dpMarkers.enter", root, function ()
	local marker = source
	if type(marker:getData("house_data")) == "table" then
		local playerId = localPlayer:getData("_id")
		local houseId = localPlayer:getData("house_id")
		local ownerId = marker:getData("owner_id")
		if not ownerId and houseId then
			marker:setData("dpMarkers.text", "", false)
		elseif ownerId and ownerId ~= playerId then
			marker:setData("dpMarkers.text", exports.dpLang:getString("markers_house_knock_text"), false)
		elseif not ownerId and not houseId then
			marker:setData("dpMarkers.text", "")
			BuyWindow.show(marker)
		else
			marker:setData("dpMarkers.text", exports.dpLang:getString("markers_house_enter_text"), false)
		end
	end
end)

addEvent("dpMarkers.use", false)
addEventHandler("dpMarkers.use", root, function ()
	local marker = source
	if type(marker:getData("house_data")) == "table" then
		local houseData = marker:getData("house_data")
		local ownerId = marker:getData("owner_id")
		local houseId = localPlayer:getData("house_id")
		local playerId = localPlayer:getData("_id")
		if not ownerId and houseId then
			exports.dpUI:showMessageBox("Покупка дома", "Чтобы купить этот дом, вы должны продать свой текущий дом!")
			return
		elseif ownerId and ownerId ~= playerId then
			return
		elseif not ownerId and not houseId then
			BuyWindow.show(marker)
			return
		end
		if ownerId == playerId then
			enterHouse(marker)
		end		
	elseif type(marker:getData("house_exit_position")) == "table" then
		setTimer(function ()
			triggerServerEvent("dpHouses.house_exit", resourceRoot, marker.id)
		end, 500, 1)
		fadeCamera(false, 0.5)		
	end
end)