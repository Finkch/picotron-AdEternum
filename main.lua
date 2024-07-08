--[[pod_format="raw",created="2024-07-01 18:29:29",modified="2024-07-08 18:31:31",revision=1221]]

-- includes finkclib
rm("/ram/cart/finkchlib") -- makes sure at most one copy is present
mount("/ram/cart/finkchlib", "/ram/finkchlib")

include("lib/keys.lua")
include("lib/queue.lua")
include("lib/clock.lua")
include("lib/camera.lua")
include("lib/timer.lua")
include("lib/logger.lua")
include("player.lua")
include("map.lua")

include("finkchlib/tstr.lua")
include("finkchlib/ttype.lua")

function _init()

	-- could also have timers for _update and _draw(), but these are all
	-- so fast they're registering 0s. Not enough granularity in time()...
	local timer_init = Timer:new(2)
	timer_init()

	-- logger object
	logger = Logger:new("appdata/AE/logs")

	-- creates the player
	player = Player:new(0, 3, 1)

	-- creates the keyboard
	keys = KBM:new({"lmb", "rmb", "w", "a", "s", "d", "e", "space", "`"})

	-- tracks map data
	world = init_map(16, 16)

	world.rooms[-1]:spawn(player, -1, Vec:new(0, 0))

	-- message queue for debug printouts
	debug = Q:new()
	
	-- keeps track of frames
	clock = Clock:new()

	-- handles the camera
	cam = Camera:new()

	-- whether to see debug visuals
	debug_visuals = false

	-- whether to debug printout
	debug_print = true

	timer_init()
	logger("startup time:" .. tostr(timer_init), "times.txt")
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
	
	cam:focus(player)	
	cam()

	map(0, 0, 0, 0, 128, 32)

	world:draw()
	player:draw()
	
	cam(true)

	if (debug_print) then -- performs printout, or not
		debug:print()
	else
		debug:clear()
	end

	if (debug_visuals) then
		line(0, 135, 240, 135, 8)
		line(240, 0, 240, 135, 8)
	end

	-- prints colours out
	for i = 0, 270 do
		pset(479, i, i // 8)
		if (i % 8 == 0) then
			print(i // 8, 460, i)
		end
	end
end