--[[
    things i need a place to store temporarly

]]

include("lib/vec.lua")

include("sprite.lua")
include("animation.lua")

include("states/state.lua")
include("states/machine.lua")

function player_state()

    idle1 = Sprite:new(
        8,
        {}
    )

    idle2 = Sprite:new(
        9,
        {}
    )

    animation = Animation:new(
        "idle",
        {idle1, idle2},
        {48, 16}
    )

    state = State:new(
        "idle",
        animation
    )

    machine = Machine:new(
        {state}
    )

    return machine
end