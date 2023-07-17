SERVER_ID = 1
if string.find(getServerName(), "#2", 1, true) then
	SERVER_ID = 2
elseif string.find(getServerName(), "Default") or string.find(getServerName(), "Test") then
	SERVER_ID = 3
end

addEventHandler("onPlayerQuit", root, function ()
	Users.logoutPlayer(source)
end)
