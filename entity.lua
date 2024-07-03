
-- represents an entity

include("lib/vec.lua")

Entity = {}
Entity.__index = Entity


-- constructor
function Entity:new(sprite, health, mass)
    local e = {
        sprite = sprite, left = false,
        max_health = health, health = health,
        mass = mass,
        pos = Vec:new(), vel = Vec:new(), acc = Vec:new(),
        state = false, -- Can't act without a state
        alive = false
    }
    setmetatable(e, Entity)
    return e
end

-- draws the entity
function Entity:draw()
    spr(self.sprite, self.pos.x, self.pos.y, self.left, false)
end

-- spawns the entity at the location
function Entity:spawn(x, y)
    self.x = x
    self.y = y
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
    self.pos += self.vel

    self.acc = Vec:new()

    -- need to check for collision

    return self
end