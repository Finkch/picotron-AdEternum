--[[
    collision detection.
    this was pretty much written by ChatGPT (gosh, I dislike collision code)
]]

include("lib/vec.lua")

include("finkchlib/tstr.lua")

-- checks if an entity collides with a room
function collision(entity, room)

    -- gets the four corners of the sprite
    local top_left = Vec:new(entity.pos.x, entity.pos.y)
    local top_right = Vec:new(entity.pos.x + entity.width, entity.pos.y)
    local bottom_right = Vec:new(entity.pos.x + entity.width, entity.pos.y + entity.height)
    local bottom_left = Vec:new(entity.pos.x, entity.pos.y + entity.height)


    -- checks if any of the room's segments intersect the bounding box
    for i = 1, #room.segments do

        -- gets the line segment of the room
        local p0 = room.pos + room.segments[i][1]
        local p1 = room.pos + room.segments[i][2]

        -- checks an intersection between the segment and all segments of the bounding box
        if (
            intersect(p0, p1, top_left, top_right) or
            intersect(p0, p1, top_right, bottom_right) or
            intersect(p0, p1, bottom_right, bottom_left) or
            intersect(p0, p1, bottom_left, top_left)
        ) then
            return true
        end
    end

    -- otherwise, there is no collision
    return false
end

-- checks if two line segments intersect.
-- lines are (p0, p1) and (q0, q1).
function intersect(p0, p1, q0, q1)

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
    local ori1 = orientation(p0, p1, q0)
    local ori2 = orientation(p0, p1, q1)
    local ori3 = orientation(q0, q1, p0)
    local ori4 = orientation(q0, q1, p1)

    -- general case
    if (ori1 != ori2 and ori3 != ori4) return true

    -- special cases
    if (ori1 == 0 and on_segment(p0, q0, p1)) return true
    if (ori2 == 0 and on_segment(p0, q1, p1)) return true
    if (ori3 == 0 and on_segment(q0, p0, q1)) return true
    if (ori4 == 0 and on_segment(q0, p1, q1)) return true

    -- otherwise, there is no intersection
    return false
end