--[[pod_format="raw",created="2024-07-06 21:58:37",modified="2024-07-07 17:31:19",revision=493]]
--[[
	contains functions for the map
]]

include("finkchlib/tstr.lua")
include("room.lua")
include("lib/vec.lua")

-- tile size
tw = nil
th = nil


--  useful functions

function init_map(tile_width, tile_height)
	tw = tile_width -- tile width
	th = tile_height -- tile height
	
	local map = Map:new()


	-- creats some rooms
	-- just one, for now
	local start = Room:new(-1, Vec:new(0, 128))
	map:add(start, {})

	return map
end

-- converts coordinates to tile coordinates
function ct(x, y)
	return x // tw, y // th
end

-- checks whether a flag of a given tile is set
function flag(x, y, n, tiles)
	if (not tiles) x, y = ct(x, y)
	
	-- this may need to change for other flags
	return fget(mget(x, y), n) == 1
end



-- map object


Map = {}
Map.__index = Map

function Map:new()
	local m = {
		rooms = {},
		loaded = {},
		entities = {}
	}
	setmetatable(m, Map)
	return m
end

-- adding/removing rooms
function Map:add(room, connections)

	for i = 1, #connections do
		room:connect(self.rooms[connections[i]])
	end

	self.rooms[room.id] = room
	self.loaded[room.id] = true

	return self
end

function Map:remove(rid)
	room = self.rooms[rid]
	del(self.rooms, rid)

	-- i don't think this will work due to updating item being interated over 
	for i = 1, #room.connections do
		room:deconnect(room.connections[i])
	end

	return self
end

-- metamethods
function Map:__tostring()
	return to_string(self.rooms)
end

