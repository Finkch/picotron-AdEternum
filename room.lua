--[[pod_format="raw",created="2024-07-07 02:28:48",modified="2024-07-07 17:31:56",revision=32]]
--[[
	a room is...a room.
	
	the map will be comrpised of lots of rooms.
	each room has its own collision via its walls and floors and stuff.

]]

include("finkchlib/tstr.lua")
include("entity.lua")

Room = {}
Room.__index = Room

-- constructor
function Room:new(id, position, segments)
	local r = {
		id = id,
		pos = position,
		seg = segments,
		connections = {},
		entities = {}
	}
	setmetatable(r, Room)
	return r
end

-- adds/removes room connections
function Room:connection(room)
	add(self.connections, room)
	add(room.connections, self)
end

function Room:deconnect(room)
	del(self.connections, room)
	del(room.connections, self)
end

-- adds or removes an entity from the room
function Room:add_entity(ent)
	self.entities[ent.id] = ent
	return self
end

function Room:remove_entity(ent)
	del(self.entities, ent.id)
	return self
end

function Room:spawn(entity, eid, pos)
	entity:spawn(pos, eid, self.id)
	self:add_entity(entity)
end

-- metamethods
function Room:__tostring()
	local tbl = {} -- creates a table to print
	tbl["Room " .. self.id .. ":"] = self.entities
	
	return to_string(tbl)
end

