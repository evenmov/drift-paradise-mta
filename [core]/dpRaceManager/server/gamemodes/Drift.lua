Drift = RaceGamemode:subclass "Drift"

function Drift:init(...)
    self.super:init(...)
    self.forceHandling = "drift"
end

function Drift:playerFinished(player)
    self.super:playerFinished(player)
end

function Drift:raceFinished(timeout)
    local players = self.race:getPlayers()
    table.sort(players, function (player1, player2)
        local score1 = player1:getData("raceDriftScore") or 0
        local score2 = player2:getData("raceDriftScore") or 0
        return score1 > score2
    end)
    for i, player in ipairs(players) do
        triggerEvent("RaceLobby.playerFinished", self.race.element, player, self:getTimePassed(), i, player:getData("raceDriftScore"))
    end
end