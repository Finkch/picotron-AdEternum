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

	-- gets the position of the player's cursor
	local cx, cy = mouse()
	local target = cam.pos + Vec:new(cx, cy)

	-- places the target on a circle about the player.
	-- this ensures the spread of their hands is more consistent
	local length = 10
	local point = target - self.pos + self.centre
	local target = point:normal() * length + self.pos + self.centre

	-- sets the target
	for appendage in all(self.appendages) do
		appendage.target = target
	end

	Entity.draw(self)
end
