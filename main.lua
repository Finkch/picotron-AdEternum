--[[pod_format="raw",created="2024-07-01 18:29:29",modified="2024-07-08 04:33:23",revision=1218]]

-- includes finkclib
rm("/ram/cart/finkchlib") -- makes sure at most one copy is present
mount("/ram/cart/finkchlib", "/ram/finkchlib")

include("player.lua")
include("lib/keys.lua")
include("lib/queue.lua")
include("lib/clock.lua")
include("map.lua")

include("finkchlib/log.lua")
include("finkchlib/tstr.lua")

function _init()

	-- creates the player
	player = Player:new(0, 3, 1)

	-- creates the keyboard
	init_keys({"w", "a", "s", "d", "e", "space", "`"})

	-- tracks map data
	world = init_map(16, 16)

	world.rooms[-1]:spawn(player, -1, Vec:new(0, 0))

	-- message queue for debug printouts
	debug = Q:new()
	
	-- keeps track of frames
	clock = Clock:new()

	-- whether to see debug visuals
	debug_visuals = true

	-- whether to debug printout
	debug_print = true
end

function _update()

	-- updates keyboard
	keys:update()

	if (keys:held("a")) player:accelerate(Vec:new(-0.25, 0))
	if (keys:held("d")) player:accelerate(Vec:new(0.25, 0))
	if (keys:held("w")) player:accelerate(Vec:new(0, -0.25))
	if (keys:held("s")) player:accelerate(Vec:new(0, 0.25))
	if (keys:pressed("`")) debug_visuals = not debug_visuals

	-- adds gravity
	player.acc.y += 0.11

	-- applies friction
	--[[
	if (player:grounded()) then
		player.vel /= 1.3
	else
		player.vel /= 1.025
	end
	]]

	player.vel /= 1.2

	player:move()
	
	-- increments frame count
	clock()
	
	debug:add(tostr(clock))
	debug:add(tostr(player.pos))
end

function _draw()
	cls(cl)
	
	camera(player.pos.x - 240 + player.width, player.pos.y - 135 + player.height)	

	map(0, 0, 0, 0, 128, 32)

	world:draw()
	player:draw()
	
	camera()

	if (debug_print) then -- performs printout, or not
		debug:print()
	else
		debug:clear()
	end

	-- prints colours out
	for i = 0, 270 do
		pset(479, i, i // 8)
		if (i % 8 == 0) then
			print(i // 8, 460, i)
		end
	end
end