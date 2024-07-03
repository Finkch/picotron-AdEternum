--[[pod_format="raw",created="2024-07-01 18:29:29",modified="2024-07-03 20:14:28",revision=326]]

include("player.lua")
include("lib/keys.lua")


function _init()

	-- creates the player
	player = Player:new(0, 3, 1)
	player:spawn(32, 32)

	-- creates the keyboard
	init_keys({"w", "a", "s", "d", "e"})
end

function _update()

	-- updates keyboard
	keys:update()

	if (keys:down("a")) player:accelerate(Vec:new(-0.25, 0))
	if (keys:down("d")) player:accelerate(Vec:new(0.25, 0))
	if (keys:down("w")) player:accelerate(Vec:new(0, -0.25))
	if (keys:down("s")) player:accelerate(Vec:new(0, 0.25))


	-- applies friction
	player.vel /= 1.3

	player:move()
end

function _draw()
	cls(cl)
	player:draw()
	
	print(keys:frames("e"))
	if (keys:pressed("e")) print("press!")
	if (keys:released("e")) print("release!")
	if (keys:down("e")) print("down!")

end