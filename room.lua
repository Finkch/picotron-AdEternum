--[[pod_format="raw",created="2024-07-07 02:28:48",modified="2024-07-07 17:31:56",revision=32]]
--[[
	a room is...a room.
	
	the map will be comrpised of lots of rooms.
	each room has its own collision via its walls and floors and stuff.

]]

include("finkchlib/tstr.lua")
include("entity.lua")

include("finkchlib/log.lua")

Room = {}
Room.__index = Room

-- constructor
function Room:new(id, position, segments)

	-- finds the centre of the room
	local centre = Vec:new()
	for i = 1, #segments do
		centre += segments[i][1] + segments[i][2]
	end
	centre /= 2 * #segments

	local r = {
		id = id,
		pos = position,
		segments = segments,
		centre = centre,
		connections = {},
		entities = {}
	}
	setmetatable(r, Room)
	return r
end

-- draws room
-- for now, just its bounding box
function Room:draw()

	for i = 1, #self.segments do
		line(
			self.pos.x + self.segments[i][1].x, self.pos.y + self.segments[i][1].y,
			self.pos.x + self.segments[i][2].x, self.pos.y + self.segments[i][2].y,
			8
		)
	end
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

-- places the entity at the room origin
function Room:spawn(entity, eid, pos)
	local np = Vec:new(entity.pos.x + self.pos.x, entity.pos.y + self.pos.y - entity.height - 1)
	entity:spawn(np, eid, self)
	self:add_entity(entity)
end

-- metamethods
function Room:__tostring()
	--local tbl = {} -- creates a table to print
	--tbl["Room " .. self.id .. ":"] = self.entities
	
	--return to_string(tbl)
	return "Room " .. self.id .. ":\t" .. to_string(self.pos, 1)
end





-- wall segment class. floors and ceilings, too
Wall = {}
Wall.__index = Wall

function Wall:new(p0, p1, n)
	local w = {
		p0 = nil,
		p1 = nil,
		offset = nil,
		rp0 = p0, -- relative position
		rp1 = p1,
		span = p1 - p0,
		normal = n
	}
	setmetatable(w, Wall)
	return wall
end

-- updates a wall's true position
function Wall:set(offset)
	self.offset = offset
	self.p0 = self.rp0 + offset
	self.p1 = self.rp1 + offset
end
