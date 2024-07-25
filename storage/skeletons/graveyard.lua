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
    skins["right arm"] = Skin:new(18, true, nil, Vec:new(0, 4))
    skins["right forearm"] = Skin:new(19, true, nil, Vec:new(0, 4))
    skins["left arm"] = skins["right arm"]
    skins["left forearm"] = skins["right forearm"]

    skins["right leg"] = Skin:new(26, true, nil, Vec:new(0, 4))
    skins["right foreleg"] = Skin:new(27, true, nil, Vec:new(0, 4))
    skins["left leg"] = skins["right leg"]
    skins["left foreleg"] = skins["right foreleg"]

    skins["head"] = Skin:new(11, false, Vec:new(-2, -2))
    skins["core"] = Skin:new(10, false, Vec:new(-2, -8))

    for name, bone in pairs(skeleton.bones) do
        if (skins[name]) bone:add(skins[name])
    end

    return skeleton
end
