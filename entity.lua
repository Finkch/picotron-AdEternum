--[[pod_format="raw",created="2024-07-06 21:42:09",modified="2024-07-07 17:31:19",revision=641]]

-- represents an entity

include("lib/vec.lua")

include("finkchlib/log.lua")

Entity = {}
Entity.__index = Entity


-- constructor
function Entity:new(sprite, health, mass, width, height, appendages, step)
	step = step or 4
    local e = {
		id = nil,
        sprite = sprite, left = false,
        max_health = health, health = health,
        mass = mass,
        width = width,
        height = height,
		centre = Vec:new(width, height) / 2,
		appendages = appendages,
        steps = step,	-- how many steps to take for one move
        pos = Vec:new(), vel = Vec:new(), acc = Vec:new(),
		room = nil,
        state = false, -- Can't act without a state
        alive = false
    }
    setmetatable(e, Entity)

	-- sets appendages' owner
	for appendage in all(appendages) do
		appendage.body = e
	end

    return e
end

-- draws the entity
function Entity:draw()
    spr(self.sprite, self.pos.x, self.pos.y, self.left, false)

	for appendage in all(self.appendages) do
		appendage:draw()
	end

	if (debug_visuals) rect(self.pos.x, self.pos.y, self.pos.x + self.width, self.pos.y + self.height, 18)
end

-- gets bounding box
function Entity:bounding(offset)
	offset = offset or Vec:new(0, 0)
	return {
		self.pos + offset,                                     -- top left
		self.pos + Vec:new(self.width, 0) + offset,            -- top right
		self.pos + Vec:new(self.width, self.height) + offset,  -- bottom right
		self.pos + Vec:new(0, self.height) + offset            -- bottom left
	}
end

-- spawns the entity at the location
function Entity:spawn(pos, id, room)
    self.pos = pos
	self.id = id
	self.room = room
    self.state = "idle"
    self.alive = true
    return self
end

-- kills entity
function Entity:die()
    self.state = false
    self.alive = false
    return self
end

-- damages entity
function Entity:damage(damage)

    -- lower bound on damage
    if (damage < 0) damage = 0

    -- takes damage
    self.health -= damage

    -- dies if no health remaining
    if (self.health <= 0) then
        return self.die()
    end

    return self
end

-- applies a force on the entity
function Entity:force(force)
    self.acc += force / mass
    return self
end

-- applies a direct acceleration, ignoring mass
function Entity:accelerate(acceleration)
    self.acc += acceleration
    return self
end


-- updates spatial vectors
function Entity:move()
	self.vel += self.acc

	-- one computation to get the n-step velocity
	--[[
	local nv = self.vel / self.steps
	for i = 1, self.steps do
		self:step(nv)
	end
	]]
	self:step(self.vel)
	
	self.acc = Vec:new()

	-- need to check for collision

	return self
end

-- step is one n-th of a move.
-- like mario n64's quarter steps
function Entity:step(nv)
	
	-- gets the would-be position
	local np = self.pos + nv

	--[[
	-- cancels velocity in a direction during a collision
	if (self:collided(np, 1) or self:collided(np, 3)) then
		self.vel = Vec:new(self.vel.x, 0)
		nv = self.vel / self.steps
		np = self.pos + nv
	end	
	
	if (self:collided(np, 2) or self:collided(np, 4)) then
		self.vel = Vec:new(0, self.vel.y)
		nv = self.vel / self.steps
		np = self.pos + nv
	end	
	]]

	-- only one step for now
	col, mtv, dir = self:collided(nv)
	if (col) then
		np += mtv
	end
	
	self.pos = np
end

--[[
-- checks if the entity is on the ground
function Entity:grounded(pos, offset)
	offset = offset or 0
	pos = pos or self.pos
	
	local y = pos.y + self.height + 1 - offset

	-- checks two points to determine if the entity is on the ground
	return flag(pos.x + 1, y, 0) or flag(pos.x + self.width - 1, y, 0)
end
]]


-- checks for collisions
function Entity:collided(vel)
	return self.room:collides(self:bounding(vel))
end