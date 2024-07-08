--[[pod_format="raw",created="2024-07-06 20:55:18",modified="2024-07-08 05:55:16",revision=635]]


-- represents the player character

include("entity.lua")
include("appendage.lua")

include("finkchlib/tstr.lua")

Player = {}
Player.__index = Player
setmetatable(Player, Entity)

function Player:new(health)

	-- arms the player
	local larm 		= Appendage:new(Vec:new(3, 11), 5)
	local lforearm 	= Appendage:new(Vec:new(0, 0), 5)
	larm:setchild(lforearm)
	
	local rarm 		= Appendage:new(Vec:new(8, 11), 5)
	local rforearm  = Appendage:new(Vec:new(0, 0), 5)
	rarm:setchild(rforearm)

	local appendages = {larm, rarm, lforearm, rforearm}

	local player = Entity.new(self, 2, health, 1, 12, 27, appendages)

	larm.parent = player
	rarm.parent = player

	setmetatable(player, Player)
	return player
end

function Player:draw()

	-- gets the position of the player's cursor
	local target = kbm.pos

	-- places the target on a circle about the player.
	-- this ensures the spread of their hands is more consistent
	local tocentre = self.pos + self.centre
	local length = 10
	local point = target - tocentre
	local target = point:normal() * length + tocentre
	

	-- sets the target
	for appendage in all(self.appendages) do
		appendage.target = target
	end

	Entity.draw(self)
end


-- gets player input
function Player:input()
	if (kbm:held("a")) player:accelerate(Vec:new(-0.25, 0))
	if (kbm:held("d")) player:accelerate(Vec:new(0.25, 0))
	if (kbm:held("w")) player:accelerate(Vec:new(0, -0.25))
	if (kbm:held("s")) player:accelerate(Vec:new(0, 0.25))
	if (kbm:pressed("`")) debug_visuals = not debug_visuals

	-- checks which direction the player is facing
	if (kbm:held("d") and self.acc.x > 0) then
		self.left = false
	elseif (kbm:held("a") and self.acc.x < 0) then
		self.left = true
	end
end