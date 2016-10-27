local PRIZE_INITIAL = 2000
local PRIZE_PLAYER_ADD = 1000

local CLASS_MUL = 0.9
local LEVEL_MUL = 2

local EXP_INITIAL = 100
local EXP_PLAYER_ADD = 50

local function getVehicleClassMul(vehicleClass)
    return 1 + (vehicleClass - 1) / 5 * CLASS_MUL
end

local function getLevelMul(player)
    local level = player:getData("level")
    if not level then
        level = 1
    end
    level = level - 1
    return 1 + level / 99 * LEVEL_MUL
end

local function showPlayerRaceFinish(player, race, time)
    if not isElement(player) then
        return 
    end 

    local raceInfo = race:getData("dpRaceLobby.raceInfo")
    outputDebugString(tostring(raceInfo))
    if type(raceInfo) ~= "table" then
        raceInfo = { rank = 1 }
    end
    local score = math.random(90000, 800000)

    local players = exports.dpRaceManager:raceGetAllPlayers(race)
    local mul = getVehicleClassMul(raceInfo.rank) * getLevelMul(player)
    local prize = math.floor((PRIZE_INITIAL + (#players * PRIZE_PLAYER_ADD)) * mul / 250) * 250
    local exp = math.floor((EXP_INITIAL + (#players * EXP_PLAYER_ADD)) * mul / 50) * 50

    exports.dpCore:givePlayerMoney(player, prize)
    exports.dpCore:givePlayerXP(player, exp)

    for i, p in ipairs(players) do
        triggerClientEvent(p, "RaceLobby.playerFinished", resourceRoot, player, prize, exp, time, score)
    end
    exports.dpRaceManager:raceRemovePlayer(race, player)
    fadeCamera(player, true, 2)
end

addEvent("RaceLobby.playerFinished", false)
addEventHandler("RaceLobby.playerFinished", root, function (player, time)
    if not isElement(player) then
        return false
    end
    local race = source
    if not time then
        time = 0
    else
        time = time / 1000
    end
    setTimer(fadeCamera, 2000, 1, player, false, 1)
    setTimer(showPlayerRaceFinish, 3000, 1, player, race, time)
end)