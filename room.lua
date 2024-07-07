--[[pod_format="raw",created="2024-07-07 02:28:48",modified="2024-07-07 02:41:13",revision=27]]
--[[
	a room is...a room.
	
	the map will be comrpised of lots of rooms.
	each room has its own collision via its walls and floors and stuff.

]]

include("finkchlib/tstr.lua")

Room = {}
Room.__index = Room

-- constructor
function Room:new(id, position)
	local r = {
		id = id,
		pos = pos,
		entities = {}
	}
	setmetatable(r, Room)
	return r
end

-- adds or removes an entity from the room
function Room:add_entity(eid, ent)
	self.entities[eid] = ent
	return self
end

function Room:remove_entity(eid)
	del(self.entities, eid)
	return self
end

-- metamethods
function Room:__tostring()
	local tbl = {} -- creates a table to print
	tbl["Room " .. self.id .. ":"] = self.entities
	
	return to_string(tbl)
end

