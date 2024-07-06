--[[pod_format="raw",created="2024-07-01 18:29:29",modified="2024-07-06 23:43:58",revision=1159]]

-- includes finkclib
rm("/ram/cart/finkchlib") -- makes sure at most one copy is present
mount("/ram/cart/finkchlib", "/ram/finkchlib")

include("finkchlib/log.lua")
include("player.lua")
include("lib/keys.lua")
include("lib/queue.lua")
include("lib/clock.lua")
include("map.lua")


function _init()

	-- creates the player
	player = Player:new(0, 3, 1)
	player:spawn(32, -32)

	-- creates the keyboard
	init_keys({"w", "a", "s", "d", "e"})
	
	-- tracks map data
	init_map(16, 16)

	-- message queue for debug printouts
	debug = Q:new()
	
	-- keeps track of frames
	clock = Clock:new()
end

function _update()

	-- updates keyboard
	keys:update()

	if (keys:held("a")) player:accelerate(Vec:new(-0.25, 0))
	if (keys:held("d")) player:accelerate(Vec:new(0.25, 0))
	if (keys:held("w")) player:accelerate(Vec:new(0, -0.25))
	if (keys:held("s")) player:accelerate(Vec:new(0, 0.25))

	-- adds gravity
	player.acc.y += 0.11

	-- applies friction
	if (player:grounded()) then
		player.vel /= 1.3
	else
		player.vel /= 1.025
	end

	player:move()
	
	-- increments frame count
	clock()
	
	debug:add(tostr(clock))
	debug:add(tostr(player.pos))
	debug:add(tostr(player:grounded()))
end

function _draw()
	cls(cl)
	
	camera(player.pos.x - 240 + player.width, player.pos.y - 135 + player.height)	

	map(0, 0, 0, 0, 128, 32)
	player:draw()
	
	camera()
	debug:print()
end