--[[pod_format="raw",created="2024-07-06 21:58:37",modified="2024-07-07 02:39:34",revision=492]]
--[[
	contains functions for the map
]]

include("finkchlib/tstr.lua")
include("room.lua")

-- tile size
tw = nil
th = nil


--  useful functions

function init_map(tile_width, tile_height)
	tw = tile_width -- tile width
	th = tile_height -- tile height
	
	local rooms = {}
	return rooms
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
Map.__index = self

function Map:new()
	local m = {
		rooms = {},
		entities = {}
	}
	setmetatable(m, Map)
	return m
end

-- adding/removing rooms
function Map:add(rid, pos, connections)
	local room = Room:new(rid, pos)

	for i = 1, #connections do
		room:connect(self.rooms[connections[i]])
	end

	add(self.rooms, room)

	return map
end

function Map:remove(rid)
	room = self.rooms[rid]
	del(self.rooms, rid)

	-- i don't think this will work due to updating item being interated over 
	for i = 1, #room.connections do
		room:deconnect(room.connections[i])
	end

	return map
end

-- metamethods
function Map:__tostring()
	return to_string(self.rooms)
end

