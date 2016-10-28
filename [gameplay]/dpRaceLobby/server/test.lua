local TEST_RACE_ENABLED = true

addEventHandler("onResourceStart", resourceRoot, function ()    
    if not TEST_RACE_ENABLED then
        return
    end
    RaceManager.startRace({
        id = 1, 
        map = "hello-world",
        gamemode = "sprint",
        players = getElementsByType("player"),
        rank = 1,
        readyCount = 1
    })
end)