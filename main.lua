--[[pod_format="raw",created="2024-07-01 18:29:29",modified="2024-07-03 20:14:28",revision=326]]
include("lib/vec.lua")
include("entity.lua")

function _init()
	-- creates the player
	player = Entity:new(0, 3, 1)
	player:spawn(32, 32)
end

function _update()

	if (btn(0)) player:accelerate(Vec:new(-0.25, 0))
	if (btn(1)) player:accelerate(Vec:new(0.25, 0))
	if (btn(2)) player:accelerate(Vec:new(0, -0.25))
	if (btn(3)) player:accelerate(Vec:new(0, 0.25))


	-- applies friction
	player.vel /= 1.3

	player:move()

end

function _draw()
	cls()
	player:draw()
end