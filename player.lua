--[[pod_format="raw",created="2024-07-06 20:55:18",modified="2024-07-06 23:43:58",revision=606]]


-- represents the player character

include("entity.lua")

Player = {}
Player.__index = Player
setmetatable(Player, Entity)

function Player:new(health)
	local player = Entity.new(self, 1, health, 1, 12 - 1, 27 - 1)

	setmetatable(player, Player)
	return player
end