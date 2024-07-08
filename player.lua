--[[pod_format="raw",created="2024-07-06 20:55:18",modified="2024-07-08 05:55:16",revision=635]]


-- represents the player character

include("entity.lua")
include("appendage.lua")

include("finkchlib/log.lua")
include("finkchlib/tstr.lua")

Player = {}
Player.__index = Player
setmetatable(Player, Entity)

function Player:new(health)

	-- arms the player
	local appendages = {
		Appendage:new(Vec:new(3, 11), 10, nil),
		Appendage:new(Vec:new(8, 11), 10, nil)
	}

	local player = Entity.new(self, 2, health, 1, 12, 27, appendages)

	setmetatable(player, Player)
	return player
end

function Player:draw()

	local cx, cy = mouse()

	for appendage in all(self.appendages) do
		appendage.target = cam.pos + Vec:new(cx, cy)
	end

	Entity.draw(self)
end
