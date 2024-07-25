--[[
    retrieves and modifies skeletons

]]

include("picotron-skeleton/gravedig.lua")
include("picotron-skeleton/skin.lua")

include("lib/vec.lua")

function player_skeleton()
    local skeleton = import(fetch("storage/skeletons/player.pod"))

    -- adds skin
    local skins = {}
    skins["right arm"] = Skin:new(18, nil, Vec:new(0, 4))
    skins["right forearm"] = Skin:new(19, nil, Vec:new(0, 4))
    skins["left arm"] = skins["right arm"]
    skins["left forearm"] = skins["right forearm"]

    for name, bone in pairs(skeleton.bones) do
        if (skins[name]) bone:add(skins[name])
    end

    return skeleton
end
