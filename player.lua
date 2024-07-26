--[[pod_format="raw",created="2024-07-06 20:55:18",modified="2024-07-08 05:55:16",revision=635]]


--[[
	represents the player character

]]

include("entity.lua")

include("storage/skeletons/player_graveyard.lua")

include("lib/tstr.lua")


Player = {}
Player.__index = Player
setmetatable(Player, Entity)


function Player:new(health)

	-- grabs the skeleton from the graveyard
	local skeleton = player_skeleton()

	-- a player is pretty much just a specific type of entity
	local player = Entity.new(self, skeleton, health, 1, 8, 26)


	setmetatable(player, Player)
	return player
end


function Player:draw()
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