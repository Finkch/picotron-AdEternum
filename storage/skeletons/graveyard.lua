--[[
    retrieves and modifies skeletons

]]

include("picotron-skeleton/gravedig.lua")

function player_skeleton()
    local skeleton = import(fetch("storage/skeletons/player.pod"))

    return skeleton
end
