--[[
    things i need a place to store temporarly

]]

include("lib/vec.lua")

include("sprite.lua")
include("animation.lua")

include("states/state.lua")
include("states/machine.lua")

function player_state()

    sprite = Sprite:new(
        8,
        {}
    )

    animation = Animation:new(
        "idle",
        {sprite},
        16
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