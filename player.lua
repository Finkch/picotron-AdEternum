--[[pod_format="raw",created="2024-07-06 20:55:18",modified="2024-07-08 05:55:16",revision=635]]


-- represents the player character

include("entity.lua")

include("storage.lua")

include("picotron-skeleton/gravedig.lua")

include("finkchlib/tstr.lua")

Player = {}
Player.__index = Player
setmetatable(Player, Entity)

-- arm sprite for texture mapping
larm = --[[pod_type="gfx"]]unpod("b64:bHo0AC0AAAArAAAA8BxweHUAQyAEEAQQHxUADg0FABIFDg0PEh4cHgwOAA4NDgAOAQ4ABg0QFvAK")
rarm = --[[pod_type="gfx"]]unpod("b64:bHo0AC4AAAAuAAAA8RJweHUAQyAIEAQRUAUPEg8VQAUPEhJAAQ4PFVABDVARDUADAIBQDw0GUBbwIw==")

function Player:new(health)

	local skeleton = import(fetch("storage/skeletons/player.pod"))

	local player = Entity.new(self, skeleton, health, 1, 8, 26)


	setmetatable(player, Player)
	return player
end


function Player:draw()
	
	-- main sprites
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