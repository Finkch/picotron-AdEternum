

-- represents the player character

include("entity.lua")

Player = {}
Player.__index = Player
setmetatable(Player, Entity)

function Player:new(health)
    player = Entity.new(self, 0, health, 1)

    setmetatable(player, Player)
    return player
end