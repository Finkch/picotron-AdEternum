--[[pod_format="raw",created="2024-07-07 02:28:48",modified="2024-07-08 00:25:34",revision=37]]
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
function Room:new(id, position, walls)

	-- sets true position of each wall
	for wall in all(walls) do
		wall:set(position)
	end

	-- finds the centre of the room
	local centre = Vec:new()
	for wall in all(walls) do
		centre += wall.p0 + wall.p1
	end
	centre /= 2 * #walls

	local r = {
		id = id,
		pos = position,
		walls = walls,
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

	for i = 1, #self.walls do
		line(
			self.walls[i].p0.x, self.walls[i].p0.y,
			self.walls[i].p1.x, self.walls[i].p1.y,
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

-- collision
function Room:collides(entity)
	local col = false
	local bounding = entity:bounding()
	local mtv = nil
	local dir = nil

	for wall in all(self.walls) do
		col, mtv, dir = wall:collides(bounding)

		if (col) return col, mtv, dir
	end
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
	return w
end

-- updates a wall's true position
function Wall:set(offset)
	self.offset = offset
	self.p0 = self.rp0 + offset
	self.p1 = self.rp1 + offset
end



-- collision detection
function Wall:intersects(q0, q1) -- intersects a line

	-- finds the orientation of the order triples (p, q, r)
	local function orientation(p, q, r)
		local ori = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
		if (ori == 0) return 0
		return (ori > 0) and 1 or 2 -- return cases to handle
	end

	-- determines whether a point lies on the segment
	local function on_segment(p, q, r)
		return (
			q.x <= max(p.x, r.x) and q.x >= min(p.x, r.x) and
			q.y <= max(p.y, r.y) and q.y >= min(p.y, r.y)
		)
	end

	-- gets the orientation of all triplets
	local ori1 = orientation(self.p0, self.p1, q0)
	local ori2 = orientation(self.p0, self.p1, q1)
	local ori3 = orientation(q0, q1, self.p0)
	local ori4 = orientation(q0, q1, self.p1)

	-- general case
	if (ori1 != ori2 and ori3 != ori4) return true

	-- special cases
	if (ori1 == 0 and on_segment(self.p0, q0, self.p1)) return true
	if (ori2 == 0 and on_segment(self.p0, q1, self.p1)) return true
	if (ori3 == 0 and on_segment(q0, self.p0, q1)) return true
	if (ori4 == 0 and on_segment(q0, self.p1, q1)) return true

	-- otherwise, there is no intersection
	return false
end

function Wall:collides(bounding) -- collides with a bounding box
	
	local intersection = false

	local intersections = {}
	local count = 0
	for j = 1, #bounding do
		add(intersections, self:intersects(bounding[j], bounding[j % 4 + 1]))
		if (intersections[j]) count += 1
	end

	-- if there's an intersection, finds minimum translation vector.
	if (count > 0) return true, self:mtv(bounding, intersections, count)

    -- otherwise, there is no collision
    return false
end

function Wall:mtv(bounding, intersections, count) -- finds minimum translation vector

	-- this implementation only works for walls orthogonal to axis

	local tv = nil
	local dir = nil

	-- if two counts of collision, push normal to wall
	if (count > 1) then

		if (intersections[2] or intersections[4]) then	-- floor/cieling
			local dup = self.p0.y - bounding[1].y
			local ddown = self.p0.y - bounding[3].y
			
			if (abs(dup) > abs(ddown)) then
				tv = Vec:new(ddown, 0)
				dir = 3
			else
				tv = Vec:new(dup, 0)
				dir = 1
			end
			
		else						-- wall

			local dleft = self.p0.x - bounding[3].x
			local dright = self.p0.x - bounding[1].x

			if (abs(dleft) > abs(dright)) then
				tv = Vec:new(0, dright)
				dir = 2
			else
				tv = Vec:new(0, dleft)
				dir = 4
			end
		end

	-- if one count, push towards smallest distance
	else
		-- do nothing :^(
		mtv = Vec:new(-1, -1) -- bogus values
		dir = -1
	end

	debug:add("collision (" .. dir .. "):\t" .. to_string(tv))

	return tv, dir
end